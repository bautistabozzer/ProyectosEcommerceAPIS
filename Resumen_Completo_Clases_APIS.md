# Resumen Completo y Pedagógico - Curso de APIs y Desarrollo Web

## Índice
1. [Clase 1: Fundamentos Web - HTML5 y CSS3](#clase-1)
2. [Clase 2: JavaScript y Herramientas de Desarrollo](#clase-2)
3. [Clase 3: JavaScript Avanzado y Control de Versiones](#clase-3)
4. [Clase 4: Introducción a React](#clase-4)
5. [Clase 5: React Hooks y Componentes](#clase-5)
6. [Clase 6: React Router y APIs](#clase-6)
7. [Estructura de Proyectos](#estructura)

---

## Clase 1: Fundamentos Web - HTML5 y CSS3 {#clase-1}

### 🎯 Objetivo
Establecer las bases del desarrollo web moderno con HTML5 semántico y CSS3, comprendiendo el flujo completo de una solicitud web.

### 📚 Contenido Teórico

#### HTML5 - Estructura y Semántica
**¿Qué es HTML?**
- Lenguaje de marcado (no de programación) creado por Tim Berners-Lee
- Utiliza etiquetas (tags) para estructurar contenido web
- Base fundamental junto con CSS y JavaScript

**HTML Semántico - La Evolución**
- **Propósito**: Describir el significado del contenido, no solo su apariencia
- **Ventajas**:
  - Mejor accesibilidad para lectores de pantalla
  - SEO optimizado para motores de búsqueda
  - Código más mantenible y legible
  - Mejor interoperabilidad

**Etiquetas Semánticas Clave**:
```html
<header>    <!-- Cabecera de sección o página -->
<nav>       <!-- Navegación -->
<main>      <!-- Contenido principal -->
<article>   <!-- Contenido independiente -->
<section>   <!-- Sección temática -->
<aside>     <!-- Contenido relacionado -->
<footer>    <!-- Pie de página -->
```

#### CSS3 - Estilos y Diseño
**¿Qué es CSS?**
- Lenguaje de estilos basado en reglas
- Controla la presentación visual de elementos HTML
- Trabaja en "cascada" (herencia y especificidad)

**Conceptos Fundamentales**:
- **Cascada**: Los estilos se aplican según prioridad (inline > interno > externo)
- **Herencia**: Los elementos heredan propiedades de sus padres
- **Especificidad**: ID > clase > etiqueta

**Unidades de Medida**:
- **em**: Relativo al font-size del elemento padre
- **rem**: Relativo al font-size del elemento root (html)

**Posicionamiento**:
- `static`: Flujo normal (por defecto)
- `relative`: Relativo a su posición original
- `fixed`: Relativo al viewport
- `absolute`: Relativo al ancestro posicionado más cercano
- `sticky`: Híbrido entre relative y fixed

**Display**:
- `inline`: Solo el espacio necesario
- `block`: Ocupa todo el ancho disponible
- `inline-block`: En línea pero con ancho/alto definible
- `flex`: Modelo de caja flexible
- `grid`: Modelo de cuadrícula bidimensional

#### Flexbox - Diseño Flexible
**Propiedades del Contenedor**:
```css
.container {
  display: flex;
  flex-direction: row|column;     /* Dirección de los elementos */
  flex-wrap: wrap|nowrap;         /* Ajuste de línea */
  justify-content: center;        /* Alineación horizontal */
  align-items: center;           /* Alineación vertical */
}
```

### 🔧 Herramientas y Recursos
- **Google Fonts**: Tipografías web
- **Font Awesome**: Iconos vectoriales
- **Animate.css**: Animaciones predefinidas
- **Media Queries**: Diseño responsivo

### 🌐 Flujo de Solicitud Web
1. **Usuario introduce URL** en el navegador
2. **Resolución DNS**: Traducción de dominio a IP
3. **Conexión TCP/IP**: Establecimiento de comunicación
4. **Solicitud HTTP**: Request con headers
5. **Procesamiento del servidor**: Respuesta con datos
6. **Renderizado**: Procesamiento HTML, CSS, JS
7. **Interacción**: Usuario puede interactuar

---

## Clase 2: JavaScript y Herramientas de Desarrollo {#clase-2}

### 🎯 Objetivo
Introducir JavaScript en el navegador, manipulación del DOM, eventos y herramientas modernas de desarrollo.

### 📚 Contenido Teórico

#### JavaScript en el Navegador
**¿Para qué sirve JavaScript?**
- Agrega comportamiento dinámico e interactividad
- Permite manipulación del DOM
- Ejecuta lógica compleja y validaciones
- Responde a eventos del usuario
- Consume APIs y actualiza contenido sin recargar

**Inclusión de JavaScript**:
```html
<!-- Inline -->
<script>console.log("Hola");</script>

<!-- Externo -->
<script src="archivo.js"></script>
```

#### Variables y Tipos de Datos
**Declaración de Variables**:
```javascript
var nombre;           // Obsoleta, tiene hoisting
let edad = 25;        // Mutable, scope de bloque
const PI = 3.14159;   // Inmutable, scope de bloque
```

**Tipos de Datos**:
- Números, cadenas, booleanos
- `null`, `undefined`
- Arrays y objetos

#### Manipulación del DOM
**¿Qué es el DOM?**
Representación en árbol de los elementos HTML que puede ser accedida y modificada con JavaScript.

**Selección de Elementos**:
```javascript
// Por ID
document.getElementById('miId');

// Por selector CSS
document.querySelector('.miClase');
document.querySelectorAll('p');
```

**Modificación del DOM**:
```javascript
element.innerHTML = '<p>Nuevo contenido</p>';
element.textContent = 'Solo texto';
element.appendChild(nuevoElemento);
```

#### Eventos y Formularios
**Tipos de Eventos**:
- Clic del mouse
- Carga de página
- Movimiento del mouse
- Cambio en campos de entrada
- Envío de formularios
- Teclas presionadas

**Manejo de Eventos**:
```javascript
// addEventListener (recomendado)
element.addEventListener('click', function() {
  console.log('Elemento clickeado');
});

// Múltiples manejadores
element.addEventListener('click', funcion1);
element.addEventListener('click', funcion2);
```

### 🛠️ Herramientas de Desarrollo
#### GitHub Copilot + Agente IA
- **Autocompletado inteligente**
- **Chat inline** (Ctrl+I)
- **Chat general** (Ctrl+Alt+I)
- **Comandos** con `/`
- **Contexto** con `#` y `@`

#### Visual Studio Code
- **Live Server**: Servidor de desarrollo
- **Debugging**: Configuración con launch.json
- **Extensiones**: Mejoran la productividad

---

## Clase 3: JavaScript Avanzado y Control de Versiones {#clase-3}

### 🎯 Objetivo
Profundizar en JavaScript asíncrono, consumo de APIs y control de versiones con Git.

### 📚 Contenido Teórico

#### Asincronía en JavaScript
**¿Qué es la Asincronía?**
Capacidad de ejecutar tareas que tardan tiempo sin bloquear el resto del código.

**Callbacks**:
```javascript
setTimeout(() => {
  console.log('Después de 2 segundos');
}, 2000);
```

**Promises (ES6)**:
```javascript
const promesa = new Promise((resolve, reject) => {
  // Operación asíncrona
  if (exito) {
    resolve(resultado);
  } else {
    reject(error);
  }
});

promesa
  .then(resultado => console.log(resultado))
  .catch(error => console.error(error));
```

**Async/Await (ES2017)**:
```javascript
async function obtenerDatos() {
  try {
    const response = await fetch('https://api.ejemplo.com/datos');
    const data = await response.json();
    return data;
  } catch (error) {
    console.error('Error:', error);
  }
}
```

#### Consumo de APIs
**Fetch API**:
```javascript
fetch('https://jsonplaceholder.typicode.com/users')
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error(error));
```

**Diferencia API vs Endpoint**:
- **API**: Conjunto de funcionalidades (ej: MercadoLibre)
- **Endpoint**: URL específica para una acción (ej: `/api/products`)

### 🔄 Control de Versiones con Git

#### ¿Qué es Git?
Sistema de control de versiones distribuido creado por Linus Torvalds (2005).

**Tipos de Sistemas de Control**:
1. **Local**: Copias manuales
2. **Centralizado (CVCS)**: Servidor central (SVN)
3. **Distribuido (DVCS)**: Cada desarrollador tiene copia completa (Git)

#### Áreas de Git
**En tu PC**:
- **Working Directory**: Donde trabajas
- **Staging Area**: Donde preparas cambios
- **Repository**: Historial completo

**Comandos Básicos**:
```bash
git init                    # Inicializar repositorio
git status                 # Ver estado
git add archivo.txt        # Agregar al staging
git add .                  # Agregar todos los cambios
git commit -m "Mensaje"    # Confirmar cambios
git log                    # Ver historial
```

#### Trabajo con Repositorios Remotos
```bash
# Vincular repositorio remoto
git remote add origin https://github.com/usuario/repo.git

# Subir cambios
git push -u origin master

# Clonar repositorio
git clone https://github.com/usuario/repo.git

# Traer cambios
git pull origin master
```

#### Ramas (Branches)
```bash
# Crear rama
git branch feature/nueva-funcionalidad

# Cambiar de rama
git checkout feature/nueva-funcionalidad
# o
git switch feature/nueva-funcionalidad

# Fusionar ramas
git merge feature/nueva-funcionalidad

# Eliminar rama
git branch -d feature/nueva-funcionalidad
```

---

## Clase 4: Introducción a React {#clase-4}

### 🎯 Objetivo
Introducir React como librería para construir interfaces de usuario modernas y componentes reutilizables.

### 📚 Contenido Teórico

#### ¿Por qué React?
**Problemas con HTML/CSS/JS tradicional**:
- Mantenimiento difícil en aplicaciones complejas
- Gestión manual del estado
- Bajo rendimiento al actualizar DOM
- Código no reutilizable

**Ventajas de React**:
- **Componentización**: Piezas reutilizables e independientes
- **Rendimiento optimizado**: Virtual DOM
- **Manejo del estado**: Gestión automática de datos dinámicos

#### Herramientas Necesarias
**Node.js y npm**:
```bash
# Verificar instalación
npm -v
node -v

# Si hay error de script en PowerShell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**Vite** (Herramienta de construcción moderna):
```bash
# Crear proyecto React
npm create vite@latest mi-proyecto
cd mi-proyecto
npm install
npm run dev
```

#### Conceptos Fundamentales

**JSX (JavaScript XML)**:
```jsx
const elemento = <h1>Hola, {nombre}!</h1>;
// Se transpila a:
const elemento = React.createElement("h1", null, "Hola, " + nombre + "!");
```

**Componentes**:
```jsx
function MiComponente() {
  return <h1>Hola desde mi componente</h1>;
}

// Uso
<MiComponente />
```

**Props (Propiedades)**:
```jsx
function Card({ titulo, descripcion, children }) {
  return (
    <div className="card">
      <h2>{titulo}</h2>
      <p>{descripcion}</p>
      {children}
    </div>
  );
}

// Uso
<Card titulo="Mi Título" descripcion="Mi descripción">
  <button>Acción</button>
</Card>
```

**useState Hook**:
```jsx
import { useState } from 'react';

function Contador() {
  const [count, setCount] = useState(0);
  
  return (
    <div>
      <p>Contador: {count}</p>
      <button onClick={() => setCount(count + 1)}>
        Incrementar
      </button>
    </div>
  );
}
```

#### Virtual DOM
- React mantiene una representación virtual del DOM
- Solo actualiza las partes que realmente cambiaron
- Mejora significativamente el rendimiento

#### HMR (Hot Module Replacement)
- Actualización en tiempo real durante desarrollo
- Mantiene el estado de la aplicación
- Acelera el flujo de desarrollo

### 📦 package.json
**Dependencias principales**:
- `react`: Biblioteca central
- `react-dom`: Renderizado en el navegador
- `vite`: Herramienta de construcción
- `eslint`: Linter para código limpio

---

## Clase 5: React Hooks y Componentes {#clase-5}

### 🎯 Objetivo
Profundizar en los Hooks de React y el manejo avanzado de componentes.

### 📚 Contenido Teórico

#### Hooks - Funcionalidades de React
Los Hooks son funciones especiales que permiten "engancharse" a las funcionalidades de React en componentes funcionales.

**useState**:
```jsx
const [estado, setEstado] = useState(valorInicial);
```
- Variable de estado y función para actualizarla
- Cada componente tiene su propio estado
- Cambios de estado disparan re-renderizado

**useEffect**:
```jsx
useEffect(() => {
  // Efectos secundarios (APIs, timers, etc.)
  return () => {
    // Limpieza (opcional)
  };
}, [dependencias]);
```

**useContext**:
```jsx
const valor = useContext(MiContexto);
```
- Acceso a valores de contexto
- Evita prop drilling
- Ideal para datos globales

#### Paradigmas de Programación

**Declarativo vs Imperativo**:
- **Declarativo**: Describe "qué" debe pasar
- **Imperativo**: Describe "cómo" hacerlo

```jsx
// Declarativo (React)
{isLoggedIn ? <Dashboard /> : <Login />}

// Imperativo (JavaScript tradicional)
if (isLoggedIn) {
  document.getElementById('app').innerHTML = '<Dashboard />';
} else {
  document.getElementById('app').innerHTML = '<Login />';
}
```

#### Ventajas de React
1. **Reutilización de Código**: Componentes reutilizables
2. **Encapsulamiento**: Cada componente maneja su estado
3. **Rendimiento Optimizado**: Virtual DOM
4. **Desarrollo Multiplataforma**: Web, móvil, escritorio
5. **Flujo de Datos Predictivo**: Unidireccional
6. **JSX**: HTML + JavaScript en un lugar

#### Librería vs Framework
**Librería (React)**:
- Conjunto de funciones que controlas
- No impone estructura
- Como herramientas sueltas

**Framework (Angular)**:
- Define estructura y metodología
- Controla el flujo (Inversión de Control)
- Como un kit completo con instrucciones

---

## Clase 6: React Router y APIs {#clase-6}

### 🎯 Objetivo
Implementar navegación en React y consumo de APIs para aplicaciones completas.

### 📚 Contenido Teórico

#### React Router
**¿Por qué no usar `<a>` tradicional?**
- Recarga toda la página (rompe SPA)
- Reinicia el estado de la aplicación
- Descarga assets innecesariamente

**Ventajas de React Router**:
- Navegación sin recarga
- Mantiene estado global
- Historial del navegador funcional
- URLs limpias y semánticas

**Instalación y Configuración**:
```bash
npm install react-router-dom
```

**Componentes Principales**:
```jsx
import { BrowserRouter, Routes, Route, Link } from 'react-router-dom';

function App() {
  return (
    <BrowserRouter>
      <nav>
        <Link to="/">Inicio</Link>
        <Link to="/productos">Productos</Link>
      </nav>
      
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/productos" element={<Productos />} />
        <Route path="/producto/:id" element={<ProductoDetalle />} />
      </Routes>
    </BrowserRouter>
  );
}
```

**Hooks de Navegación**:
```jsx
import { useParams, useNavigate } from 'react-router-dom';

function ProductoDetalle() {
  const { id } = useParams();
  const navigate = useNavigate();
  
  const handleComprar = () => {
    // Lógica de compra
    navigate('/carrito');
  };
}
```

#### Renderizado Condicional
**Operadores Lógicos**:
```jsx
// && (mostrar si es verdadero)
{isLoggedIn && <Dashboard />}

// || (valor alternativo)
{nombre || 'Usuario anónimo'}
```

**Operador Ternario**:
```jsx
{isLoading ? <Spinner /> : <Contenido />}
```

**Renderizado de Listas**:
```jsx
{productos.map(producto => (
  <ProductCard key={producto.id} producto={producto} />
))}
```

#### Consumo de APIs

**Fetch API**:
```jsx
useEffect(() => {
  fetch('https://jsonplaceholder.typicode.com/posts')
    .then(response => response.json())
    .then(data => setPosts(data))
    .catch(error => console.error(error));
}, []);
```

**Axios**:
```bash
npm install axios
```

```jsx
import axios from 'axios';

useEffect(() => {
  axios.get('https://jsonplaceholder.typicode.com/posts')
    .then(response => setPosts(response.data))
    .catch(error => console.error(error));
}, []);
```

**Ventajas de Axios**:
- Transformación automática de JSON
- Interceptores para requests/responses
- Mejor manejo de errores

#### JSON Server
**Simulación de API**:
```bash
npm install json-server
npx json-server db.json
```

**Estructura de db.json**:
```json
{
  "products": [
    { "id": 1, "name": "Producto 1", "price": 100 },
    { "id": 2, "name": "Producto 2", "price": 200 }
  ]
}
```

#### APIs REST
**Conceptos**:
- **API**: Conjunto de reglas para comunicación entre programas
- **REST**: Arquitectura para APIs web
- **Endpoint**: URL específica para un recurso
- **Métodos HTTP**: GET, POST, PUT, DELETE

**Características REST**:
- Sin estado (stateless)
- URLs semánticas
- Uso correcto de métodos HTTP
- Formato JSON

---

## Estructura de Proyectos {#estructura}

### 🏗️ Arquitectura Recomendada

```
src/
├── features/              # Características principales
│   ├── products/         # Gestión de productos
│   │   ├── components/   # ProductCard, ProductList
│   │   ├── services/     # productService.js
│   │   ├── hooks/        # useProducts.js
│   │   └── context/      # ProductContext.jsx
│   ├── cart/            # Carrito de compras
│   ├── auth/            # Autenticación
│   └── profile/         # Perfil de usuario
├── shared/              # Componentes compartidos
│   ├── components/      # Button, Modal, Card
│   ├── hooks/          # useModal.js, useForm.js
│   └── utils/          # formatters.js, validators.js
├── assets/             # Recursos estáticos
└── app/               # Configuración principal
    ├── routes/        # PublicRoutes, PrivateRoutes
    └── App.jsx
```

### 📋 Buenas Prácticas

**Nomenclatura**:
- **PascalCase**: Componentes React (UserDetail)
- **camelCase**: Funciones JavaScript (getUserByName)
- **snake_case**: Base de datos
- **kebab-case**: CSS

**Organización**:
- Un componente por archivo
- Separación de responsabilidades
- Hooks personalizados para lógica reutilizable
- Context para estado global

**Git**:
- Commits atómicos y descriptivos
- Ramas por funcionalidad
- Revisión de código antes de merge
- Archivo .gitignore actualizado

---

## 🎓 Conclusión

Este curso proporciona una base sólida para el desarrollo web moderno, desde los fundamentos de HTML/CSS hasta aplicaciones React completas con consumo de APIs. La progresión pedagógica permite:

1. **Comprender** los fundamentos web
2. **Aplicar** JavaScript moderno
3. **Implementar** control de versiones
4. **Desarrollar** aplicaciones React
5. **Integrar** APIs y navegación

La combinación de teoría y práctica, junto con herramientas modernas como Vite, Git y React Router, prepara a los estudiantes para enfrentar proyectos reales de desarrollo web.

---

*Este resumen está diseñado para ser una guía completa y pedagógica que puede ser utilizada como referencia durante el curso y como material de estudio para exámenes o proyectos futuros.*
