🔧 COMMIT 03 - SERVICIOS API Y UTILIDADES
=========================================

📋 DESCRIPCIÓN:
Este commit implementa la capa de servicios y utilidades de la aplicación:
- Servicio API completo para comunicación con JSON Server
- Constantes de configuración y mensajes de error
- Hooks personalizados para manejo de estado (useFetch, useTheme)
- Utilidades de formateo (precios, fechas, texto)
- Validadores para formularios
- Manejo centralizado de errores

⚠️  IMPORTANTE: Este commit debe mergearse ANTES que commit04.

🔧 INSTRUCCIONES DE APLICACIÓN:

1️⃣ PREPARAR EL REPOSITORIO:
   git clone <URL-DEL-REPO>
   cd <nombre-repo>

2️⃣ ACTUALIZAR MASTER:
   git checkout master
   git pull origin master

3️⃣ CREAR RAMA DE TRABAJO:
   git checkout -b feature/commit03-tu-nombre

4️⃣ APLICAR EL COMMIT (Elegir UNA opción):

   📌 OPCIÓN A - SCRIPT AUTOMÁTICO (Recomendado):
   .\tpo-commits\commit03\apply-commit.ps1

   📌 OPCIÓN B - APLICAR PATCH MANUAL:
   patch -p1 < tpo-commits/commit03/changes.diff

5️⃣ HACER COMMIT:
   git add .
   git commit -F tpo-commits/commit03/commit-message.txt

6️⃣ SUBIR RAMA:
   git push -u origin feature/commit03-tu-nombre

7️⃣ CREAR PULL REQUEST:
   - Ir a GitHub/GitLab
   - Crear PR a master
   - Usar el mensaje de commit-message.txt

📁 ARCHIVOS CREADOS:
- src/constants/index.js (constantes y configuración)
- src/services/api.js (servicio API completo)
- src/hooks/useFetch.js (hook para peticiones HTTP)
- src/hooks/useTheme.js (hook para manejo de tema)
- src/utils/formatters.js (utilidades de formateo)
- src/utils/validators.js (validadores de formularios)

🎯 FUNCIONALIDADES IMPLEMENTADAS:
- API completa para productos, usuarios y categorías
- Autenticación y registro de usuarios
- Búsqueda y filtrado de productos
- Manejo de stock y actualizaciones
- Hooks para estado de carga y errores
- Formateo de precios en euros
- Validación de formularios
- Manejo de errores centralizado

✅ VERIFICACIÓN:
Después de aplicar, deberías poder importar y usar las utilidades en otros componentes.

🔗 SIGUIENTE PASO: Aplicar commit04 después de mergear este PR.