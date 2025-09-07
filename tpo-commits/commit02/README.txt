🎨 COMMIT 02 - SISTEMA DE ESTILOS Y TEMA
=========================================

📋 DESCRIPCIÓN:
Este commit implementa el sistema completo de estilos y tema de la aplicación:
- Archivo CSS global con variables personalizadas
- Soporte para tema claro y oscuro
- Utilidades de componentes reutilizables (botones, inputs, cards)
- Animaciones y transiciones suaves
- Soporte para accesibilidad y modo de alto contraste
- Estilos responsivos y optimizados
- Utilidades de truncado de texto y efectos hover

⚠️  IMPORTANTE: Este commit debe mergearse ANTES que commit03.

🔧 INSTRUCCIONES DE APLICACIÓN:

1️⃣ PREPARAR EL REPOSITORIO:
   git clone <URL-DEL-REPO>
   cd <nombre-repo>

2️⃣ ACTUALIZAR MASTER:
   git checkout master
   git pull origin master

3️⃣ CREAR RAMA DE TRABAJO:
   git checkout -b feature/commit02-tu-nombre

4️⃣ APLICAR EL COMMIT (Elegir UNA opción):

   📌 OPCIÓN A - SCRIPT AUTOMÁTICO (Recomendado):
   .\tpo-commits\commit02\apply-commit.ps1

   📌 OPCIÓN B - APLICAR PATCH MANUAL:
   patch -p1 < tpo-commits/commit02/changes.diff

5️⃣ HACER COMMIT:
   git add .
   git commit -F tpo-commits/commit02/commit-message.txt

6️⃣ SUBIR RAMA:
   git push -u origin feature/commit02-tu-nombre

7️⃣ CREAR PULL REQUEST:
   - Ir a GitHub/GitLab
   - Crear PR a master
   - Usar el mensaje de commit-message.txt

📁 ARCHIVOS CREADOS:
- src/styles/global.css (estilos globales y tema)

🎯 CARACTERÍSTICAS IMPLEMENTADAS:
- Variables CSS para tema claro/oscuro
- Clases utilitarias (.btn, .input, .card, .toast)
- Animaciones (fadeIn, pulse, hover effects)
- Soporte para accesibilidad
- Estilos de scrollbar personalizados
- Soporte para impresión y alto contraste

✅ VERIFICACIÓN:
Después de aplicar, el archivo CSS debería contener todas las utilidades necesarias para la aplicación.

🔗 SIGUIENTE PASO: Aplicar commit03 después de mergear este PR.