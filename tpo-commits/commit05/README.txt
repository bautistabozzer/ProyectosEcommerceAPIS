🧩 COMMIT 05 - COMPONENTES BASE
===============================

📋 DESCRIPCIÓN:
Este commit implementa los componentes base reutilizables de la aplicación:
- Sistema de layout principal (Header, Footer, Layout)
- Componentes de productos (ProductCard)
- Componentes de UI (LoadingSpinner, EmptyState, ErrorBoundary)
- Toggle de tema con persistencia
- Sistema de navegación responsivo
- Componentes de modales informativos

⚠️  IMPORTANTE: Este commit debe mergearse ANTES que commit06.

🔧 INSTRUCCIONES DE APLICACIÓN:

1️⃣ PREPARAR EL REPOSITORIO:
   git clone <URL-DEL-REPO>
   cd <nombre-repo>

2️⃣ ACTUALIZAR MASTER:
   git checkout master
   git pull origin master

3️⃣ CREAR RAMA DE TRABAJO:
   git checkout -b feature/commit05-tu-nombre

4️⃣ APLICAR EL COMMIT (Elegir UNA opción):

   📌 OPCIÓN A - SCRIPT AUTOMÁTICO (Recomendado):
   .\tpo-commits\commit05\apply-commit.ps1

   📌 OPCIÓN B - APLICAR PATCH MANUAL:
   patch -p1 < tpo-commits/commit05/changes.diff

5️⃣ HACER COMMIT:
   git add .
   git commit -F tpo-commits/commit05/commit-message.txt

6️⃣ SUBIR RAMA:
   git push -u origin feature/commit05-tu-nombre

7️⃣ CREAR PULL REQUEST:
   - Ir a GitHub/GitLab
   - Crear PR a master
   - Usar el mensaje de commit-message.txt

📁 ARCHIVOS CREADOS:
- src/components/Layout.jsx (layout principal)
- src/components/Header.jsx (cabecera con navegación)
- src/components/Footer.jsx (pie de página con modales)
- src/components/ProductCard.jsx (tarjeta de producto)
- src/components/LoadingSpinner.jsx (indicador de carga)
- src/components/EmptyState.jsx (estado vacío)
- src/components/ErrorBoundary.jsx (manejo de errores)
- src/components/ThemeToggle.jsx (toggle de tema)

🎯 FUNCIONALIDADES IMPLEMENTADAS:
- Layout responsivo con header y footer
- Navegación con indicador de carrito
- Tarjetas de productos con hover effects
- Estados de carga y vacío
- Manejo de errores con ErrorBoundary
- Toggle de tema claro/oscuro
- Modales informativos en footer
- Navegación móvil responsive

✅ VERIFICACIÓN:
Después de aplicar, los componentes deberían estar listos para usar en las páginas.

🔗 SIGUIENTE PASO: Aplicar commit06 después de mergear este PR.