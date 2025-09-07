🔐 COMMIT 06 - AUTENTICACIÓN Y RUTAS PROTEGIDAS
===============================================

📋 DESCRIPCIÓN:
Este commit implementa el sistema completo de autenticación y protección de rutas:
- Páginas de login y registro con validación
- Componente de ruta protegida
- Formularios con validación en tiempo real
- Integración completa con contexto de autenticación
- Manejo de errores de autenticación
- Redirección automática según estado de sesión
- Credenciales de prueba para testing

⚠️  IMPORTANTE: Este commit debe mergearse ANTES que commit07.

🔧 INSTRUCCIONES DE APLICACIÓN:

1️⃣ PREPARAR EL REPOSITORIO:
   git clone <URL-DEL-REPO>
   cd <nombre-repo>

2️⃣ ACTUALIZAR MASTER:
   git checkout master
   git pull origin master

3️⃣ CREAR RAMA DE TRABAJO:
   git checkout -b feature/commit06-tu-nombre

4️⃣ APLICAR EL COMMIT (Elegir UNA opción):

   📌 OPCIÓN A - SCRIPT AUTOMÁTICO (Recomendado):
   .\tpo-commits\commit06\apply-commit.ps1

   📌 OPCIÓN B - APLICAR PATCH MANUAL:
   patch -p1 < tpo-commits/commit06/changes.diff

5️⃣ HACER COMMIT:
   git add .
   git commit -F tpo-commits/commit06/commit-message.txt

6️⃣ SUBIR RAMA:
   git push -u origin feature/commit06-tu-nombre

7️⃣ CREAR PULL REQUEST:
   - Ir a GitHub/GitLab
   - Crear PR a master
   - Usar el mensaje de commit-message.txt

📁 ARCHIVOS CREADOS:
- src/pages/Login.jsx (página de login/registro)
- src/pages/Register.jsx (página de registro)
- src/components/ProtectedRoute.jsx (componente de ruta protegida)

🎯 FUNCIONALIDADES IMPLEMENTADAS:
- Formulario unificado de login/registro
- Validación en tiempo real de campos
- Toggle entre modos de login y registro
- Checkbox "Recordarme" para persistencia
- Validación de email, contraseña y campos requeridos
- Manejo de errores con mensajes específicos
- Redirección automática después de login/registro
- Protección de rutas con redirección a login
- Credenciales de prueba para testing

🔑 CREDENCIALES DE PRUEBA:
- Admin: admin@test.com / admin123
- Usuario: user1@test.com / user123

✅ VERIFICACIÓN:
Después de aplicar, deberías poder hacer login/registro y acceder a rutas protegidas.

🔗 SIGUIENTE PASO: Aplicar commit07 después de mergear este PR.