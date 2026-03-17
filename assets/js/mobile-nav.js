/**
 * Navegación Móvil para Ethical Hacking 2026
 * Mejora la experiencia en dispositivos móviles
 */

(function() {
    'use strict';

    // Configuración
    const MOBILE_BREAKPOINT = 768;
    let isMobile = window.innerWidth <= MOBILE_BREAKPOINT;

    // Inicializar navegación móvil
    function initMobileNav() {
        // Crear botón de menú hamburguesa
        const menuBtn = document.createElement('button');
        menuBtn.className = 'mobile-menu-btn';
        menuBtn.innerHTML = `
            <span></span>
            <span></span>
            <span></span>
        `;
        menuBtn.setAttribute('aria-label', 'Abrir menú de navegación');
        menuBtn.setAttribute('aria-expanded', 'false');

        // Estilos del botón
        menuBtn.style.cssText = `
            display: none;
            flex-direction: column;
            justify-content: space-around;
            width: 30px;
            height: 25px;
            background: transparent;
            border: none;
            cursor: pointer;
            padding: 0;
            z-index: 1002;
            position: fixed;
            top: 15px;
            left: 15px;
        `;

        // Líneas del botón hamburguesa
        menuBtn.querySelectorAll('span').forEach(span => {
            span.style.cssText = `
                display: block;
                height: 3px;
                width: 100%;
                background-color: #ecf0f1;
                border-radius: 2px;
                transition: all 0.3s ease;
            `;
        });

        // Crear overlay
        const overlay = document.createElement('div');
        overlay.className = 'sidebar-overlay';
        overlay.style.cssText = `
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 999;
        `;

        // Agregar al DOM
        document.body.appendChild(menuBtn);
        document.body.appendChild(overlay);

        // Obtener sidebar
        const sidebar = document.querySelector('.sidebar');

        // Función para abrir/cerrar menú
        function toggleMenu() {
            const isOpen = sidebar.classList.contains('open');

            if (isOpen) {
                sidebar.classList.remove('open');
                overlay.classList.remove('active');
                menuBtn.setAttribute('aria-expanded', 'false');
                document.body.style.overflow = '';
            } else {
                sidebar.classList.add('open');
                overlay.classList.add('active');
                menuBtn.setAttribute('aria-expanded', 'true');
                document.body.style.overflow = 'hidden';
            }
        }

        // Event listeners
        menuBtn.addEventListener('click', toggleMenu);
        overlay.addEventListener('click', toggleMenu);

        // Cerrar con tecla Escape
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Escape' && sidebar.classList.contains('open')) {
                toggleMenu();
            }
        });

        // Mostrar/ocultar botón según tamaño de pantalla
        function updateMenuButton() {
            isMobile = window.innerWidth <= MOBILE_BREAKPOINT;
            menuBtn.style.display = isMobile ? 'flex' : 'none';

            if (!isMobile) {
                sidebar.classList.remove('open');
                overlay.classList.remove('active');
                document.body.style.overflow = '';
            }
        }

        window.addEventListener('resize', updateMenuButton);
        updateMenuButton();

        // Agregar swipe gestures para móvil
        let touchStartX = 0;
        let touchEndX = 0;

        document.addEventListener('touchstart', function(e) {
            touchStartX = e.changedTouches[0].screenX;
        });

        document.addEventListener('touchend', function(e) {
            touchEndX = e.changedTouches[0].screenX;
            handleSwipe();
        });

        function handleSwipe() {
            const swipeThreshold = 50;
            const diff = touchStartX - touchEndX;

            // Swipe izquierdo (cerrar menú)
            if (diff > swipeThreshold && sidebar.classList.contains('open')) {
                toggleMenu();
            }

            // Swipe derecho (abrir menú)
            if (diff < -swipeThreshold && !sidebar.classList.contains('open') && touchStartX < 50) {
                toggleMenu();
            }
        }

        console.log('Navegación móvil inicializada');
    }

    // Función para mejorar scroll en móvil
    function improveMobileScroll() {
        // Agregar indicador de scroll horizontal para tablas
        const tables = document.querySelectorAll('table');
        tables.forEach(table => {
            const wrapper = document.createElement('div');
            wrapper.style.overflowX = 'auto';
            wrapper.style.webkitOverflowScrolling = 'touch';
            table.parentNode.insertBefore(wrapper, table);
            wrapper.appendChild(table);
        });

        // Suavizar scroll en móvil
        if ('ontouchstart' in window) {
            document.documentElement.style.scrollBehavior = 'smooth';
        }
    }

    // Función para optimizar tap targets en móvil
    function optimizeTapTargets() {
        // Aumentar tamaño de enlaces y botones en móvil
        const style = document.createElement('style');
        style.textContent = `
            @media (max-width: 768px) {
                a, button {
                    min-height: 44px;
                    min-width: 44px;
                }

                .sidebar a {
                    padding: 15px 20px;
                    display: block;
                }

                .btn-complete {
                    bottom: 10px !important;
                    right: 10px !important;
                    padding: 12px 24px !important;
                }
            }
        `;
        document.head.appendChild(style);
    }

    // Inicializar cuando el DOM esté listo
    document.addEventListener('DOMContentLoaded', function() {
        initMobileNav();
        improveMobileScroll();
        optimizeTapTargets();
    });

    // Exponer funciones globalmente
    window.MobileNav = {
        init: initMobileNav,
        toggle: function() {
            const sidebar = document.querySelector('.sidebar');
            const overlay = document.querySelector('.sidebar-overlay');
            if (sidebar && overlay) {
                sidebar.classList.toggle('open');
                overlay.classList.toggle('active');
            }
        }
    };

    console.log('Mejoras móviles inicializadas');
})();