# 🚀 SISTEMA DE COMMITS TPO - E-COMMERCE

## 📋 Descripción General

Este repositorio contiene un sistema de commits estructurado para desarrollar una aplicación **E-Commerce completa** con React, Vite y Tailwind CSS. Cada commit representa una funcionalidad específica que se puede aplicar de forma independiente.

## 🎯 Objetivo

Permitir que múltiples desarrolladores trabajen en diferentes funcionalidades de la aplicación de manera paralela, aplicando commits específicos según su asignación.

## 📁 Estructura del Proyecto

```
tpo-commits/
├── commit01/          # Configuración base del proyecto
├── commit02/          # Sistema de estilos y tema
├── commit03/          # Servicios API y utilidades
├── commit04/          # Contextos de estado
├── commit05/          # Componentes base
├── commit06/          # Autenticación y rutas protegidas
├── commit07/          # Catálogo y productos
├── commit08/          # Panel de administración
├── commit09/          # Paginación en dashboard
└── generate-scripts.ps1
```

## 🔄 Flujo de Trabajo

### 1️⃣ **Asignación de Commits**
- Cada desarrollador recibe un commit específico para trabajar
- Los commits deben aplicarse **EN ORDEN** (commit01 → commit02 → ... → commit08)
- Cada commit tiene dependencias del anterior

### 2️⃣ **Aplicación de Commits**
Cada carpeta de commit contiene:
- `apply-commit.ps1` - Script automático para aplicar el commit
- `changes.diff` - Archivo de diferencias (aplicación manual)
- `commit-message.txt` - Mensaje de commit predefinido
- `README.txt` - Instrucciones detalladas del commit

### 3️⃣ **Proceso Estándar**

```powershell
# 1. Clonar y preparar repositorio
git clone <URL-DEL-REPO>
cd <nombre-repo>

# 2. Actualizar master
git checkout master
git pull origin master

# 3. Crear rama para tu commit
git checkout -b feature/commitXX-tu-nombre

# 4. Aplicar el commit (ELEGIR UNA OPCIÓN)
# Opción A - Script automático (Recomendado)
.\tpo-commits\commitXX\apply-commit.ps1

# Opción B - Aplicar patch manual
patch -p1 < tpo-commits/commitXX/changes.diff

# 5. Hacer commit
git add .
git commit -F tpo-commits/commitXX/commit-message.txt

# 6. Subir rama
git push -u origin feature/commitXX-tu-nombre

# 7. Crear Pull Request
# Ir a GitHub/GitLab y crear PR a master
```

## 📋 Lista de Commits

| Commit | Funcionalidad | Dependencias | Archivos Principales |
|--------|---------------|--------------|---------------------|
| **01** | 🏗️ Configuración base | Ninguna | package.json, vite.config.js, tailwind.config.js |
| **02** | 🎨 Sistema de estilos | commit01 | src/styles/global.css |
| **03** | 🔧 Servicios API | commit02 | src/services/, src/hooks/, src/utils/ |
| **04** | 🏗️ Contextos de estado | commit03 | src/context/, src/reducers/ |
| **05** | 🧩 Componentes base | commit04 | src/components/ |
| **06** | 🔐 Autenticación | commit05 | src/pages/Login.jsx, src/pages/Register.jsx |
| **07** | 🛍️ Catálogo y productos | commit06 | src/pages/Home.jsx, src/pages/ProductDetail.jsx |
| **08** | ⚙️ Panel de administración | commit07 | src/pages/DashboardProducts.jsx, src/App.jsx |
| **09** | 📄 Paginación en dashboard | commit08 | src/components/Pagination.jsx, src/pages/DashboardProducts.jsx |

## 🛠️ Tecnologías Utilizadas

- **Frontend**: React 18 + Vite
- **Estilos**: Tailwind CSS + CSS personalizado
- **Estado**: React Context + useReducer
- **Routing**: React Router DOM
- **API**: JSON Server (simulado)
- **Iconos**: Lucide React
- **Linting**: ESLint

## 🚀 Aplicación Final

Después de aplicar todos los commits, tendrás una aplicación E-Commerce completa con:

### ✨ Funcionalidades
- 🔐 **Autenticación** (login/registro con persistencia)
- 🛍️ **Catálogo de productos** (búsqueda, filtros, paginación)
- 🛒 **Carrito de compras** (gestión de cantidades, checkout)
- ⚙️ **Panel de administración** (CRUD de productos con paginación)
- 🎨 **Tema claro/oscuro** (toggle con persistencia)
- 📱 **Diseño responsivo** (mobile-first)
- 🔔 **Sistema de notificaciones** (toast messages)
- 📄 **Paginación avanzada** (navegación inteligente, elipsis, persistencia)

### 🎯 Características Técnicas
- **Estado global** con Context API
- **Persistencia** en localStorage/sessionStorage
- **Validación** de formularios en tiempo real
- **Manejo de errores** centralizado
- **Loading states** y estados vacíos
- **Optimización** de imágenes y lazy loading

## 📖 Instrucciones por Commit

### 🔍 **Para ver instrucciones detalladas de cada commit:**
```bash
# Leer README específico de cada commit
cat tpo-commits/commit01/README.txt
cat tpo-commits/commit02/README.txt
# ... etc
```

### 🎯 **Para aplicar un commit específico:**
```powershell
# Ejemplo: aplicar commit03
.\tpo-commits\commit03\apply-commit.ps1
```

## ⚠️ Importante

1. **ORDEN OBLIGATORIO**: Los commits deben aplicarse en secuencia (01→02→03...)
2. **DEPENDENCIAS**: Cada commit depende del anterior
3. **RAMAS SEPARADAS**: Cada desarrollador debe crear su propia rama
4. **PULL REQUESTS**: Crear PR individual para cada commit
5. **TESTING**: Verificar que cada commit funciona antes del siguiente

## 🐛 Solución de Problemas

### ❌ **Error al aplicar script:**
```powershell
# Verificar permisos de ejecución
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Ejecutar script
.\tpo-commits\commitXX\apply-commit.ps1
```

### ❌ **Error al aplicar patch:**
```bash
# Aplicar patch manualmente
patch -p1 < tpo-commits/commitXX/changes.diff
```

### ❌ **Conflicto de dependencias:**
- Verificar que el commit anterior esté aplicado
- Revisar el README del commit para dependencias

## 📞 Soporte

Si tienes problemas:
1. Revisar el README específico del commit
2. Verificar que las dependencias estén aplicadas
3. Consultar con el equipo de desarrollo

---

## 🎉 ¡Éxito!

Después de aplicar todos los commits tendrás una aplicación E-Commerce completamente funcional y lista para producción.

**¡Happy Coding! 🚀**
