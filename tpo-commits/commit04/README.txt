🏗️ COMMIT 04 - CONTEXTOS DE ESTADO
===================================

📋 DESCRIPCIÓN:
Este commit implementa el sistema de manejo de estado global de la aplicación:
- Contexto de autenticación con persistencia en localStorage/sessionStorage
- Contexto de carrito de compras con persistencia local
- Contexto de notificaciones toast
- Reducers para manejo de estado complejo
- Persistencia automática de sesiones y carrito
- Manejo de tokens y sesiones de usuario

⚠️  IMPORTANTE: Este commit debe mergearse ANTES que commit05.

🔧 INSTRUCCIONES DE APLICACIÓN:

1️⃣ PREPARAR EL REPOSITORIO:
   git clone <URL-DEL-REPO>
   cd <nombre-repo>

2️⃣ ACTUALIZAR MASTER:
   git checkout master
   git pull origin master

3️⃣ CREAR RAMA DE TRABAJO:
   git checkout -b feature/commit04-tu-nombre

4️⃣ APLICAR EL COMMIT (Elegir UNA opción):

   📌 OPCIÓN A - SCRIPT AUTOMÁTICO (Recomendado):
   .\tpo-commits\commit04\apply-commit.ps1

   📌 OPCIÓN B - APLICAR PATCH MANUAL:
   patch -p1 < tpo-commits/commit04/changes.diff

5️⃣ HACER COMMIT:
   git add .
   git commit -F tpo-commits/commit04/commit-message.txt

6️⃣ SUBIR RAMA:
   git push -u origin feature/commit04-tu-nombre

7️⃣ CREAR PULL REQUEST:
   - Ir a GitHub/GitLab
   - Crear PR a master
   - Usar el mensaje de commit-message.txt

📁 ARCHIVOS CREADOS:
- src/reducers/authReducer.js (reducer para autenticación)
- src/reducers/cartReducer.js (reducer para carrito)
- src/context/AuthContext.jsx (contexto de autenticación)
- src/context/CartContext.jsx (contexto de carrito)
- src/context/ToastContext.jsx (contexto de notificaciones)

🎯 FUNCIONALIDADES IMPLEMENTADAS:
- Login/logout con persistencia
- Registro de usuarios
- Manejo de "Recordarme" (localStorage vs sessionStorage)
- Carrito de compras con persistencia
- Notificaciones toast automáticas
- Restauración automática de sesión al cargar la app
- Validación de tokens y datos de usuario
- Manejo de errores de autenticación

✅ VERIFICACIÓN:
Después de aplicar, los contextos deberían estar disponibles para usar en componentes.

🔗 SIGUIENTE PASO: Aplicar commit05 después de mergear este PR.