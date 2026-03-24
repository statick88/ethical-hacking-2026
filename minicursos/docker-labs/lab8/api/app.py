#!/usr/bin/env python3
"""
Vulnerable REST API for Lab 8: REST API Security Testing
Intentionally insecure for educational purposes - DO NOT USE IN PRODUCTION

Vulnerabilities included:
- SQL Injection in /api/users
- Missing Authentication on admin endpoints
- Insecure Direct Object Reference (IDOR)
- Hardcoded Credentials
- Weak Password Hashing
- No HTTPS enforcement
- Information Disclosure
"""

import os
import json
import hashlib
import sqlite3
from datetime import datetime
from functools import wraps
from flask import Flask, request, jsonify, g
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)
app.config["SECRET_KEY"] = "supersecretkey"  # Hardcoded secret - VULNERABLE
app.config["JSON_SORT_KEYS"] = False

# Global credentials storage (in-memory for demo)
HARDCODED_USERS = {
    "admin": "admin123",  # Hardcoded password - VULNERABLE
    "user1": "password123",
    "user2": "letmein",
}

# Database initialization
DB_PATH = "/tmp/vulnerable_api.db"


def init_db():
    """Initialize SQLite database with vulnerable schema"""
    if os.path.exists(DB_PATH):
        os.remove(DB_PATH)

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # Users table with simple MD5 hashing (VULNERABLE)
    cursor.execute("""
        CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE,
            password TEXT,
            email TEXT,
            role TEXT,
            api_key TEXT
        )
    """)

    # Products table
    cursor.execute("""
        CREATE TABLE products (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            price REAL,
            description TEXT,
            stock INTEGER
        )
    """)

    # Logs table (for information disclosure)
    cursor.execute("""
        CREATE TABLE logs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER,
            action TEXT,
            timestamp DATETIME,
            details TEXT
        )
    """)

    # Insert sample users with weak hashing
    users = [
        (
            "admin",
            hashlib.md5(b"admin123").hexdigest(),
            "admin@lab.local",
            "admin",
            "admin-key-123",
        ),
        (
            "user1",
            hashlib.md5(b"user1pass").hexdigest(),
            "user1@lab.local",
            "user",
            "user1-key-456",
        ),
        (
            "user2",
            hashlib.md5(b"user2pass").hexdigest(),
            "user2@lab.local",
            "user",
            "user2-key-789",
        ),
        (
            "john",
            hashlib.md5(b"john2024").hexdigest(),
            "john@lab.local",
            "user",
            "john-key-012",
        ),
    ]

    for username, password, email, role, api_key in users:
        cursor.execute(
            """
            INSERT INTO users (username, password, email, role, api_key)
            VALUES (?, ?, ?, ?, ?)
        """,
            (username, password, email, role, api_key),
        )

    # Insert sample products
    products = [
        ("Laptop", 999.99, "High-performance laptop", 5),
        ("Mouse", 29.99, "Wireless mouse", 50),
        ("Keyboard", 79.99, "Mechanical keyboard", 20),
        ("Monitor", 299.99, "4K display", 10),
    ]

    for name, price, description, stock in products:
        cursor.execute(
            """
            INSERT INTO products (name, price, description, stock)
            VALUES (?, ?, ?, ?)
        """,
            (name, price, description, stock),
        )

    conn.commit()
    conn.close()


def get_db():
    """Get database connection"""
    db = getattr(g, "_database", None)
    if db is None:
        db = g._database = sqlite3.connect(DB_PATH)
        db.row_factory = sqlite3.Row
    return db


@app.teardown_appcontext
def close_connection(exception):
    """Close database connection"""
    db = getattr(g, "_database", None)
    if db is not None:
        db.close()


def log_action(user_id, action, details):
    """Log user actions"""
    db = get_db()
    cursor = db.cursor()
    cursor.execute(
        """
        INSERT INTO logs (user_id, action, timestamp, details)
        VALUES (?, ?, ?, ?)
    """,
        (user_id, action, datetime.now().isoformat(), details),
    )
    db.commit()


def weak_auth_required(f):
    """
    Weak authentication decorator - NO PROPER TOKEN VALIDATION
    VULNERABLE: Only checks for presence of Authorization header
    """

    @wraps(f)
    def decorated_function(*args, **kwargs):
        auth = request.headers.get("Authorization")
        if not auth:
            return jsonify({"error": "Missing Authorization header"}), 401

        # VULNERABLE: Just check if header exists, don't validate properly
        if not auth.startswith("Bearer "):
            return jsonify({"error": "Invalid Authorization format"}), 401

        token = auth.split(" ")[1] if len(auth.split(" ")) > 1 else None

        # VULNERABLE: Token validation is trivial
        db = get_db()
        cursor = db.cursor()
        cursor.execute(
            "SELECT id, username, role FROM users WHERE api_key = ?", (token,)
        )
        user = cursor.fetchone()

        if not user:
            # VULNERABLE: Accept any non-empty token as valid
            return jsonify({"error": "Invalid token"}), 401

        g.user_id = user["id"]
        g.username = user["username"]
        g.role = user["role"]

        return f(*args, **kwargs)

    return decorated_function


# ==================== VULNERABLE ENDPOINTS ====================


@app.route("/api/health", methods=["GET"])
def health():
    """Health check endpoint - Information disclosure"""
    return jsonify(
        {
            "status": "healthy",
            "timestamp": datetime.now().isoformat(),
            "version": "1.0.0",
            "database": "SQLite",
            "debug": True,  # VULNERABLE: Debug mode enabled
            "environment": os.environ.copy(),  # VULNERABLE: Exposes env vars
        }
    ), 200


@app.route("/api/login", methods=["POST"])
def login():
    """
    Login endpoint
    VULNERABLE:
    - No rate limiting
    - Weak password hashing (MD5)
    - Timing-safe comparison not used
    """
    data = request.get_json()

    if not data or not data.get("username") or not data.get("password"):
        return jsonify({"error": "Missing username or password"}), 400

    username = data["username"]
    password = data["password"]

    db = get_db()
    cursor = db.cursor()

    # VULNERABLE: MD5 hashing is weak
    password_hash = hashlib.md5(password.encode()).hexdigest()

    cursor.execute(
        "SELECT id, username, role, api_key FROM users WHERE username = ? AND password = ?",
        (username, password_hash),
    )
    user = cursor.fetchone()

    if user:
        log_action(user["id"], "login", f"Successful login for {username}")
        return jsonify(
            {
                "success": True,
                "user_id": user["id"],
                "username": user["username"],
                "role": user["role"],
                "token": user["api_key"],  # VULNERABLE: Token in plain response
                "message": "Login successful",
            }
        ), 200
    else:
        return jsonify({"error": "Invalid credentials"}), 401


@app.route("/api/users", methods=["GET"])
@weak_auth_required
def get_users():
    """
    Get users endpoint
    VULNERABLE: SQL Injection via search parameter
    """
    search = request.args.get("search", "")

    db = get_db()
    cursor = db.cursor()

    # VULNERABLE: SQL Injection - no parameterized query
    query = f"""
        SELECT id, username, email, role 
        FROM users 
        WHERE username LIKE '%{search}%' OR email LIKE '%{search}%'
    """

    try:
        cursor.execute(query)
        users = cursor.fetchall()

        return jsonify(
            {
                "success": True,
                "count": len(users),
                "users": [dict(user) for user in users],
            }
        ), 200
    except Exception as e:
        # VULNERABLE: Error details exposed
        return jsonify({"error": str(e), "query": query}), 500


@app.route("/api/users/<int:user_id>", methods=["GET"])
@weak_auth_required
def get_user(user_id):
    """
    Get specific user endpoint
    VULNERABLE: Insecure Direct Object Reference (IDOR)
    No validation that user can only access their own data
    """
    db = get_db()
    cursor = db.cursor()

    # VULNERABLE: No ownership check - any authenticated user can access any user's data
    cursor.execute(
        "SELECT id, username, email, role FROM users WHERE id = ?", (user_id,)
    )
    user = cursor.fetchone()

    if user:
        log_action(g.user_id, "view_user", f"Viewed user {user_id}")
        return jsonify({"success": True, "user": dict(user)}), 200
    else:
        return jsonify({"error": "User not found"}), 404


@app.route("/api/users/<int:user_id>", methods=["PUT"])
@weak_auth_required
def update_user(user_id):
    """
    Update user endpoint
    VULNERABLE:
    - IDOR: No ownership validation
    - Privilege escalation: Any user can change roles
    """
    data = request.get_json()

    db = get_db()
    cursor = db.cursor()

    # VULNERABLE: No check if user owns this record or is admin
    fields_to_update = []
    values = []

    if "email" in data:
        fields_to_update.append("email = ?")
        values.append(data["email"])

    if "role" in data:
        # VULNERABLE: Any user can change roles to admin
        fields_to_update.append("role = ?")
        values.append(data["role"])

    if "password" in data:
        password_hash = hashlib.md5(data["password"].encode()).hexdigest()
        fields_to_update.append("password = ?")
        values.append(password_hash)

    if not fields_to_update:
        return jsonify({"error": "No fields to update"}), 400

    values.append(user_id)

    query = f"UPDATE users SET {', '.join(fields_to_update)} WHERE id = ?"

    try:
        cursor.execute(query, values)
        db.commit()

        log_action(g.user_id, "update_user", f"Updated user {user_id}")
        return jsonify({"success": True, "message": "User updated"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route("/api/admin/users", methods=["GET"])
def admin_get_all_users():
    """
    Admin endpoint - List all users with sensitive data
    VULNERABLE:
    - NO AUTHENTICATION REQUIRED
    - Returns password hashes
    """
    db = get_db()
    cursor = db.cursor()

    # VULNERABLE: No authentication, returns everything including password hashes
    cursor.execute("SELECT id, username, email, role, password, api_key FROM users")
    users = cursor.fetchall()

    return jsonify(
        {
            "admin": True,
            "total_users": len(users),
            "users": [dict(user) for user in users],
        }
    ), 200


@app.route("/api/admin/logs", methods=["GET"])
def admin_get_logs():
    """
    Admin logs endpoint
    VULNERABLE: NO AUTHENTICATION - anyone can view all activity logs
    """
    db = get_db()
    cursor = db.cursor()

    cursor.execute("SELECT * FROM logs ORDER BY timestamp DESC LIMIT 100")
    logs = cursor.fetchall()

    return jsonify(
        {"admin": True, "total_logs": len(logs), "logs": [dict(log) for log in logs]}
    ), 200


@app.route("/api/products", methods=["GET"])
def get_products():
    """
    Get products endpoint
    VULNERABLE: No pagination, could return excessive data
    """
    db = get_db()
    cursor = db.cursor()

    cursor.execute("SELECT * FROM products")
    products = cursor.fetchall()

    return jsonify(
        {
            "success": True,
            "count": len(products),
            "products": [dict(product) for product in products],
        }
    ), 200


@app.route("/api/products/<int:product_id>", methods=["GET"])
def get_product(product_id):
    """Get specific product"""
    db = get_db()
    cursor = db.cursor()

    cursor.execute("SELECT * FROM products WHERE id = ?", (product_id,))
    product = cursor.fetchone()

    if product:
        return jsonify({"success": True, "product": dict(product)}), 200
    else:
        return jsonify({"error": "Product not found"}), 404


@app.route("/api/products/<int:product_id>/buy", methods=["POST"])
@weak_auth_required
def buy_product(product_id):
    """
    Buy product endpoint
    VULNERABLE:
    - No input validation on quantity
    - No inventory deduction logic
    - Race conditions possible
    """
    data = request.get_json() or {}
    quantity = data.get("quantity", 1)

    # VULNERABLE: No validation on quantity
    if not isinstance(quantity, int) or quantity < 0:
        quantity = 1

    db = get_db()
    cursor = db.cursor()

    cursor.execute("SELECT * FROM products WHERE id = ?", (product_id,))
    product = cursor.fetchone()

    if not product:
        return jsonify({"error": "Product not found"}), 404

    # VULNERABLE: No inventory management or transaction handling
    log_action(g.user_id, "purchase", f"Purchased product {product_id} x{quantity}")

    return jsonify(
        {
            "success": True,
            "product": dict(product),
            "quantity": quantity,
            "total": product["price"] * quantity,
            "message": "Purchase recorded",
        }
    ), 200


@app.route("/api/backup", methods=["GET"])
def backup():
    """
    Backup endpoint
    VULNERABLE:
    - NO AUTHENTICATION
    - Allows downloading entire database
    - Information disclosure
    """
    db = get_db()
    cursor = db.cursor()

    # Export entire database
    cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
    tables = cursor.fetchall()

    backup_data = {}
    for table in tables:
        table_name = table[0]
        cursor.execute(f"SELECT * FROM {table_name}")
        backup_data[table_name] = [dict(row) for row in cursor.fetchall()]

    return jsonify(
        {"backup": True, "timestamp": datetime.now().isoformat(), "data": backup_data}
    ), 200


@app.route("/api/search", methods=["POST"])
def search():
    """
    Search endpoint
    VULNERABLE:
    - Command injection via query parameter
    - No input validation
    """
    data = request.get_json() or {}
    query = data.get("query", "")

    db = get_db()
    cursor = db.cursor()

    # VULNERABLE: SQL Injection in complex query
    search_query = f"""
        SELECT id, username, email FROM users WHERE 
        username LIKE '%{query}%' OR 
        email LIKE '%{query}%'
    """

    try:
        cursor.execute(search_query)
        results = cursor.fetchall()

        return jsonify(
            {
                "success": True,
                "query": query,
                "results": [dict(row) for row in results],
                "count": len(results),
            }
        ), 200
    except Exception as e:
        # VULNERABLE: Detailed error messages
        return jsonify(
            {"error": str(e), "query_attempted": search_query, "query_param": query}
        ), 500


@app.route("/api/debug", methods=["GET"])
def debug():
    """
    Debug endpoint
    VULNERABLE: Exposes internal application state
    """
    return jsonify(
        {
            "debug": True,
            "flask_config": dict(app.config),
            "python_path": os.sys.path,
            "environment": dict(os.environ),
            "request_headers": dict(request.headers),
            "hardcoded_credentials": HARDCODED_USERS,
        }
    ), 200


# Error handlers that leak information
@app.errorhandler(404)
def not_found(error):
    """404 handler - leaks info"""
    return jsonify(
        {
            "error": "Not found",
            "path": request.path,
            "method": request.method,
            "available_endpoints": [str(rule) for rule in app.url_map.iter_rules()],
        }
    ), 404


@app.errorhandler(500)
def internal_error(error):
    """500 handler - leaks stack trace"""
    import traceback

    return jsonify(
        {
            "error": "Internal server error",
            "traceback": traceback.format_exc(),
            "error_message": str(error),
        }
    ), 500


if __name__ == "__main__":
    init_db()
    # VULNERABLE: Debug mode enabled in production
    app.run(host="0.0.0.0", port=5000, debug=True)
