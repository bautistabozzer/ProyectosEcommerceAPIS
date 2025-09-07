🚀 COMMIT 01 - CONFIGURACIÓN BASE DEL PROYECTO
================================================

📋 DESCRIPCIÓN:
Este commit establece la configuración inicial del proyecto React con Vite, incluyendo:
- Configuración de package.json con todas las dependencias necesarias
- Configuración de Vite para desarrollo
- Configuración de Tailwind CSS con tema personalizado
- Configuración de ESLint para linting
- Configuración de PostCSS
- Archivo HTML base

⚠️  IMPORTANTE: Este commit debe mergearse ANTES que commit02.

🔧 INSTRUCCIONES DE APLICACIÓN:

1️⃣ PREPARAR EL REPOSITORIO:
   git clone <URL-DEL-REPO>
   cd <nombre-repo>

2️⃣ ACTUALIZAR MASTER:
   git checkout master
   git pull origin master

3️⃣ CREAR RAMA DE TRABAJO:
   git checkout -b feature/commit01-tu-nombre

4️⃣ APLICAR EL COMMIT (Elegir UNA opción):

   📌 OPCIÓN A - SCRIPT AUTOMÁTICO (Recomendado):
   .\tpo-commits\commit01\apply-commit.ps1

   📌 OPCIÓN B - APLICAR PATCH MANUAL:
   patch -p1 < tpo-commits/commit01/changes.diff

5️⃣ HACER COMMIT:
   git add .
   git commit -F tpo-commits/commit01/commit-message.txt

6️⃣ SUBIR RAMA:
   git push -u origin feature/commit01-tu-nombre

7️⃣ CREAR PULL REQUEST:
   - Ir a GitHub/GitLab
   - Crear PR a master
   - Usar el mensaje de commit-message.txt

📁 ARCHIVOS CREADOS:
- package.json (dependencias y scripts)
- vite.config.js (configuración de Vite)
- tailwind.config.js (configuración de Tailwind)
- eslint.config.mjs (configuración de ESLint)
- postcss.config.cjs (configuración de PostCSS)
- index.html (archivo HTML base)

✅ VERIFICACIÓN:
Después de aplicar, deberías poder ejecutar:
- npm install
- npm run dev

🔗 SIGUIENTE PASO: Aplicar commit02 después de mergear este PR.