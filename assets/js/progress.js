/**
 * Sistema de Progreso para Ethical Hacking 2026
 * Almacena el progreso del usuario en localStorage
 */

(function() {
    'use strict';

    // Clave para localStorage
    const STORAGE_KEY = 'ethical_hacking_2026_progress';

    // Estructura de datos del progreso
    const defaultProgress = {
        completedUnits: [],
        completedLabs: [],
        completedQuizzes: [],
        lastVisited: null,
        startDate: new Date().toISOString(),
        totalVisitTime: 0
    };

    // Inicializar progreso
    function initProgress() {
        let progress = localStorage.getItem(STORAGE_KEY);
        if (!progress) {
            progress = defaultProgress;
            saveProgress(progress);
        } else {
            progress = JSON.parse(progress);
        }
        return progress;
    }

    // Guardar progreso
    function saveProgress(progress) {
        localStorage.setItem(STORAGE_KEY, JSON.stringify(progress));
    }

    // Marcar unidad como completada
    function markUnitCompleted(unitId) {
        const progress = initProgress();
        if (!progress.completedUnits.includes(unitId)) {
            progress.completedUnits.push(unitId);
            progress.lastVisited = unitId;
            saveProgress(progress);
            updateUI();
            console.log(`Unidad ${unitId} marcada como completada`);
        }
    }

    // Marcar lab como completado
    function markLabCompleted(labId) {
        const progress = initProgress();
        if (!progress.completedLabs.includes(labId)) {
            progress.completedLabs.push(labId);
            saveProgress(progress);
            updateUI();
            console.log(`Lab ${labId} marcado como completado`);
        }
    }

    // Marcar quiz como completado
    function markQuizCompleted(quizId) {
        const progress = initProgress();
        if (!progress.completedQuizzes.includes(quizId)) {
            progress.completedQuizzes.push(quizId);
            saveProgress(progress);
            updateUI();
            console.log(`Quiz ${quizId} marcado como completado`);
        }
    }

    // Obtener progreso actual
    function getProgress() {
        return initProgress();
    }

    // Calcular porcentaje de progreso
    function calculateProgress() {
        const progress = getProgress();
        const totalItems = 8 + 8 + 8; // 8 unidades + 8 labs + 8 quizzes
        const completedItems = progress.completedUnits.length +
                              progress.completedLabs.length +
                              progress.completedQuizzes.length;
        return Math.round((completedItems / totalItems) * 100);
    }

    // Actualizar UI del progreso
    function updateUI() {
        const progress = getProgress();
        const percentage = calculateProgress();

        // Actualizar barra de progreso si existe
        const progressBar = document.querySelector('.progress-bar');
        if (progressBar) {
            progressBar.style.width = percentage + '%';
        }

        // Actualizar estadísticas si existen
        const statsContainer = document.querySelector('.progress-stats');
        if (statsContainer) {
            statsContainer.innerHTML = `
                <div class="stat-item">
                    <div class="stat-value">${progress.completedUnits.length}/8</div>
                    <div class="stat-label">Unidades</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value">${progress.completedLabs.length}/8</div>
                    <div class="stat-label">Labs</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value">${progress.completedQuizzes.length}/8</div>
                    <div class="stat-label">Quizzes</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value">${percentage}%</div>
                    <div class="stat-label">Completado</div>
                </div>
            `;
        }

        // Actualizar indicadores de completado en la lista de unidades
        document.querySelectorAll('[data-unit-id]').forEach(element => {
            const unitId = element.getAttribute('data-unit-id');
            if (progress.completedUnits.includes(unitId)) {
                element.classList.add('completed');
                if (!element.querySelector('.completed-badge')) {
                    const badge = document.createElement('span');
                    badge.className = 'completed-badge';
                    badge.textContent = '✓';
                    element.appendChild(badge);
                }
            }
        });
    }

    // Función para agregar botón de completar a cada sección
    function addCompleteButtons() {
        // Buscar contenedores de contenido
        const contentContainers = document.querySelectorAll('.content, main, article');

        contentContainers.forEach(container => {
            // Crear botón de completar
            const completeBtn = document.createElement('button');
            completeBtn.className = 'btn-complete';
            completeBtn.textContent = 'Marcar como completado';
            completeBtn.style.cssText = `
                position: fixed;
                bottom: 20px;
                right: 20px;
                background: #27ae60;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                cursor: pointer;
                z-index: 1000;
                box-shadow: 0 2px 10px rgba(0,0,0,0.3);
            `;

            // Determinar qué tipo de contenido es
            const currentPath = window.location.pathname;
            let contentType = '';
            let contentId = '';

            if (currentPath.includes('/contenido/unidad')) {
                contentType = 'unit';
                contentId = currentPath.match(/unidad(\d+)/)[1];
            } else if (currentPath.includes('/labs/lab-unidad')) {
                contentType = 'lab';
                contentId = currentPath.match(/lab-unidad(\d+)/)[1];
            } else if (currentPath.includes('/quizzes/unidad')) {
                contentType = 'quiz';
                contentId = currentPath.match(/unidad(\d+)/)[1];
            }

            // Agregar evento al botón
            completeBtn.addEventListener('click', function() {
                if (contentType === 'unit') {
                    markUnitCompleted('unidad' + contentId);
                    this.textContent = '✓ Completado';
                    this.style.background = '#27ae60';
                } else if (contentType === 'lab') {
                    markLabCompleted('lab-unidad' + contentId);
                    this.textContent = '✓ Completado';
                    this.style.background = '#27ae60';
                } else if (contentType === 'quiz') {
                    markQuizCompleted('unidad' + contentId);
                    this.textContent = '✓ Completado';
                    this.style.background = '#27ae60';
                }
            });

            // Solo agregar si no existe ya
            if (!document.querySelector('.btn-complete')) {
                document.body.appendChild(completeBtn);
            }
        });
    }

    // Función para crear panel de progreso
    function createProgressPanel() {
        const sidebar = document.querySelector('.sidebar');
        if (!sidebar) return;

        // Crear panel de progreso
        const progressPanel = document.createElement('div');
        progressPanel.className = 'course-progress';
        progressPanel.innerHTML = `
            <h3>📈 Tu Progreso</h3>
            <div class="progress-stats">
                <div class="stat-item">
                    <div class="stat-value" id="units-progress">0/8</div>
                    <div class="stat-label">Unidades</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value" id="labs-progress">0/8</div>
                    <div class="stat-label">Labs</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value" id="quizzes-progress">0/8</div>
                    <div class="stat-label">Quizzes</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value" id="total-progress">0%</div>
                    <div class="stat-label">Completado</div>
                </div>
            </div>
        `;

        // Insertar al inicio de la sidebar
        sidebar.insertBefore(progressPanel, sidebar.firstChild);
    }

    // Inicializar cuando el DOM esté listo
    document.addEventListener('DOMContentLoaded', function() {
        initProgress();
        updateUI();
        addCompleteButtons();
        createProgressPanel();

        // Actualizar cada vez que cambie la URL (SPA)
        window.addEventListener('popstate', function() {
            setTimeout(updateUI, 100);
        });
    });

    // Exponer funciones globalmente para uso en otros scripts
    window.CourseProgress = {
        markUnitCompleted,
        markLabCompleted,
        markQuizCompleted,
        getProgress,
        calculateProgress
    };

    console.log('Sistema de progreso inicializado');
})();