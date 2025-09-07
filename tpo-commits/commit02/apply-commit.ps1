# Script para aplicar el commit02 - Sistema de estilos y tema
# Ejecutar en PowerShell desde la raíz del repositorio

Write-Host "Aplicando commit02 - Sistema de estilos y tema..." -ForegroundColor Green

# Crear directorio src/styles si no existe
if (!(Test-Path "src")) {
    New-Item -ItemType Directory -Path "src" -Force
}
if (!(Test-Path "src/styles")) {
    New-Item -ItemType Directory -Path "src/styles" -Force
}

# Crear src/styles/global.css
@"
@import "tailwindcss/base";
@import "tailwindcss/components";
@import "tailwindcss/utilities";

:root {
  --primary: #2563eb;
  --primary-foreground: #ffffff;
  --background: #ffffff;
  --foreground: #0f172a;
  --border: #e2e8f0;
  --input: #e2e8f0;
  --ring: #2563eb;
  --destructive: #dc2626;
  --destructive-foreground: #ffffff;
}

.dark {
  --primary: #3b82f6;
  --primary-foreground: #ffffff;
  --background: #0f172a;
  --foreground: #ffffff;
  --border: #334155;
  --input: #334155;
  --ring: #3b82f6;
  --destructive: #ef4444;
  --destructive-foreground: #ffffff;
}

* {
  box-sizing: border-box;
  transition: transform 0.2s ease, box-shadow 0.2s ease, opacity 0.2s ease;
}

body {
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Roboto", "Oxygen", "Ubuntu", "Cantarell", "Fira Sans",
    "Droid Sans", "Helvetica Neue", sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  background-color: var(--background);
  color: var(--foreground);
  transition: background-color 0.3s ease, color 0.3s ease;
}

.btn {
  @apply px-4 py-2 rounded-md font-medium transition-colors focus:outline-none focus:ring-2 focus:ring-offset-2;
}

.btn-primary {
  @apply bg-blue-600 dark:bg-blue-500 text-white hover:bg-blue-700 dark:hover:bg-blue-600 focus:ring-blue-500 dark:focus:ring-blue-400 focus:ring-offset-2 dark:focus:ring-offset-gray-800;
}

.btn-secondary {
  @apply bg-gray-200 dark:bg-gray-600 text-gray-900 dark:text-white hover:bg-gray-300 dark:hover:bg-gray-500 focus:ring-gray-500 dark:focus:ring-gray-400 focus:ring-offset-2 dark:focus:ring-offset-gray-800;
}

.btn-destructive {
  @apply bg-red-600 dark:bg-red-500 text-white hover:bg-red-700 dark:hover:bg-red-600 focus:ring-red-500 dark:focus:ring-red-400 focus:ring-offset-2 dark:focus:ring-offset-gray-800;
}

.input {
  @apply w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 focus:border-transparent bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100;
}

/* Input with icon - override padding when pl-10 is used */
.input.pl-10 {
  padding-left: 2.5rem; /* 40px - equivalent to pl-10 */
  padding-right: 0.75rem; /* 12px - equivalent to pr-3 */
}

.card {
  @apply bg-white dark:bg-gray-800 rounded-lg shadow-md border border-gray-200 dark:border-gray-700;
}

.toast {
  @apply fixed top-4 right-4 z-50 p-4 rounded-md shadow-lg max-w-sm;
}

.toast-success {
  @apply bg-green-100 text-green-800 border border-green-200;
}

.toast-error {
  @apply bg-red-100 text-red-800 border border-red-200;
}

.toast-info {
  @apply bg-blue-100 text-blue-800 border border-blue-200;
}

/* Added line-clamp utilities for text truncation */
.line-clamp-1 {
  overflow: hidden;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 1;
}

.line-clamp-2 {
  overflow: hidden;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 2;
}

.line-clamp-3 {
  overflow: hidden;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 3;
}

/* Added group hover utilities */
.group:hover .group-hover\:opacity-100 {
  opacity: 1;
}

.group:hover .group-hover\:opacity-0 {
  opacity: 0;
}

/* Improved animations */
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.animate-fade-in {
  animation: fadeIn 0.3s ease-out;
}

/* Improved focus styles for accessibility */
.focus-visible:focus {
  outline: 2px solid var(--ring);
  outline-offset: 2px;
}

/* Button and card hover effects */
.btn:hover {
  transform: translateY(-1px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
}

.card:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
}

/* Loading animation improvements */
@keyframes pulse {
  0%,
  100% {
    opacity: 1;
  }
  50% {
    opacity: 0.5;
  }
}

.animate-pulse {
  animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
}

/* Better scrollbar styling */
::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}

::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 4px;
}

::-webkit-scrollbar-thumb {
  background: #c1c1c1;
  border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
  background: #a8a8a8;
}

/* Print styles */
@media print {
  .no-print {
    display: none !important;
  }

  .card {
    box-shadow: none;
    border: 1px solid #ddd;
  }
}

/* High contrast mode support */
@media (prefers-contrast: high) {
  .btn {
    border: 2px solid currentColor;
  }

  .card {
    border: 2px solid #000;
  }
}

/* Reduced motion support */
@media (prefers-reduced-motion: reduce) {
  * {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
  }
}
"@ | Out-File -FilePath "src/styles/global.css" -Encoding UTF8

Write-Host "✅ Commit02 aplicado exitosamente!" -ForegroundColor Green
Write-Host "Ahora puedes hacer: git add . && git commit -F tpo-commits/commit02/commit-message.txt" -ForegroundColor Yellow