# ========================================
# COMMIT 09 - PAGINACIÓN EN DASHBOARD
# ========================================
# Script automático para aplicar el commit de paginación

Write-Host "🚀 Aplicando Commit 09 - Paginación en Dashboard..." -ForegroundColor Green

# Verificar que estamos en el directorio correcto
if (-not (Test-Path "package.json")) {
    Write-Host "❌ Error: No se encontró package.json. Asegúrate de estar en la raíz del proyecto." -ForegroundColor Red
    exit 1
}

# Crear directorio de componentes si no existe
if (-not (Test-Path "src/components")) {
    New-Item -ItemType Directory -Path "src/components" -Force
    Write-Host "📁 Creado directorio src/components" -ForegroundColor Yellow
}

# Crear componente Pagination
Write-Host "📄 Creando componente Pagination..." -ForegroundColor Cyan
$paginationContent = @'
import { ChevronLeft, ChevronRight, MoreHorizontal } from "lucide-react"

const Pagination = ({ 
  currentPage, 
  totalPages, 
  onPageChange, 
  showInfo = true,
  totalItems = 0,
  itemsPerPage = 10 
}) => {
  // Calcular información de elementos mostrados
  const startItem = totalItems > 0 ? ((currentPage - 1) * itemsPerPage) + 1 : 0
  const endItem = Math.min(currentPage * itemsPerPage, totalItems)

  // Generar números de página a mostrar
  const getPageNumbers = () => {
    const pages = []
    const maxVisiblePages = 5

    if (totalPages <= maxVisiblePages) {
      // Mostrar todas las páginas si son pocas
      for (let i = 1; i <= totalPages; i++) {
        pages.push(i)
      }
    } else {
      // Lógica para mostrar páginas con elipsis
      if (currentPage <= 3) {
        // Páginas iniciales
        for (let i = 1; i <= 4; i++) {
          pages.push(i)
        }
        pages.push('ellipsis')
        pages.push(totalPages)
      } else if (currentPage >= totalPages - 2) {
        // Páginas finales
        pages.push(1)
        pages.push('ellipsis')
        for (let i = totalPages - 3; i <= totalPages; i++) {
          pages.push(i)
        }
      } else {
        // Páginas del medio
        pages.push(1)
        pages.push('ellipsis')
        for (let i = currentPage - 1; i <= currentPage + 1; i++) {
          pages.push(i)
        }
        pages.push('ellipsis')
        pages.push(totalPages)
      }
    }

    return pages
  }

  const pageNumbers = getPageNumbers()

  if (totalPages <= 1) {
    return null
  }

  return (
    <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mt-6">
      {/* Información de elementos */}
      {showInfo && totalItems > 0 && (
        <div className="text-sm text-gray-600 dark:text-gray-300">
          Mostrando {startItem} - {endItem} de {totalItems} productos
        </div>
      )}

      {/* Controles de paginación */}
      <div className="flex items-center space-x-1">
        {/* Botón Anterior */}
        <button
          onClick={() => onPageChange(currentPage - 1)}
          disabled={currentPage === 1}
          className="p-2 rounded-md border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
          title="Página anterior"
        >
          <ChevronLeft size={18} />
        </button>

        {/* Números de página */}
        <div className="flex items-center space-x-1">
          {pageNumbers.map((page, index) => {
            if (page === 'ellipsis') {
              return (
                <span
                  key={`ellipsis-${index}`}
                  className="px-3 py-2 text-gray-500 dark:text-gray-400"
                >
                  <MoreHorizontal size={16} />
                </span>
              )
            }

            const isCurrentPage = page === currentPage
            return (
              <button
                key={page}
                onClick={() => onPageChange(page)}
                className={`px-3 py-2 rounded-md text-sm font-medium transition-colors ${
                  isCurrentPage
                    ? 'bg-blue-600 text-white border border-blue-600'
                    : 'border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700'
                }`}
              >
                {page}
              </button>
            )
          })}
        </div>

        {/* Botón Siguiente */}
        <button
          onClick={() => onPageChange(currentPage + 1)}
          disabled={currentPage === totalPages}
          className="p-2 rounded-md border border-gray-300 dark:border-gray-600 bg-white dark:bg-gray-800 text-gray-600 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
          title="Página siguiente"
        >
          <ChevronRight size={18} />
        </button>
      </div>
    </div>
  )
}

export default Pagination
'@

$paginationContent | Out-File -FilePath "src/components/Pagination.jsx" -Encoding UTF8
Write-Host "✅ Componente Pagination creado" -ForegroundColor Green

# Actualizar DashboardProducts.jsx
Write-Host "📄 Actualizando DashboardProducts.jsx..." -ForegroundColor Cyan

# Leer el archivo actual
$dashboardContent = Get-Content "src/pages/DashboardProducts.jsx" -Raw

# Reemplazar imports
$dashboardContent = $dashboardContent -replace 'import { useState } from "react"', 'import { useState, useEffect } from "react"'
$dashboardContent = $dashboardContent -replace 'import { Plus, Edit, Trash2, Package, Eye, Search } from "lucide-react"', 'import Pagination from "../components/Pagination"`nimport { Plus, Edit, Trash2, Package, Eye, Search } from "lucide-react"'

# Agregar estado de paginación después de isDeleting
$dashboardContent = $dashboardContent -replace '  const \[isDeleting, setIsDeleting\] = useState\(null\)', '  const [isDeleting, setIsDeleting] = useState(null)
  const [currentPage, setCurrentPage] = useState(1)
  const [itemsPerPage, setItemsPerPage] = useState(() => {
    const saved = localStorage.getItem(''dashboardProductsPerPage'')
    return saved ? Number(saved) : 6
  })'

# Agregar lógica de paginación después del filtrado
$paginationLogic = @'

  // Pagination logic
  const totalPages = Math.ceil(filteredProducts.length / itemsPerPage)
  const startIndex = (currentPage - 1) * itemsPerPage
  const endIndex = startIndex + itemsPerPage
  const paginatedProducts = filteredProducts.slice(startIndex, endIndex)

  // Reset to first page when search term changes
  useEffect(() => {
    setCurrentPage(1)
  }, [searchTerm])

  // Save items per page preference
  useEffect(() => {
    localStorage.setItem(''dashboardProductsPerPage'', itemsPerPage.toString())
  }, [itemsPerPage])

  // Handle page change
  const handlePageChange = (page) => {
    setCurrentPage(page)
    // Scroll to top when changing pages
    window.scrollTo({ top: 0, behavior: ''smooth'' })
  }

  // Handle items per page change
  const handleItemsPerPageChange = (newItemsPerPage) => {
    setItemsPerPage(newItemsPerPage)
    setCurrentPage(1) // Reset to first page
  }'@

$dashboardContent = $dashboardContent -replace '  // Filter by search term', "  // Filter by search term$paginationLogic"

# Actualizar estadísticas para mostrar filtrados
$dashboardContent = $dashboardContent -replace '          <span>Sin stock: \{userProducts\.filter\(\(p\) => p\.stock === 0\)\.length\}</span>', '          <span>Sin stock: {userProducts.filter((p) => p.stock === 0).length}</span>
          {searchTerm && (
            <span className="text-blue-600 dark:text-blue-400">
              Filtrados: {filteredProducts.length}
            </span>
          )}'

# Agregar selector de elementos por página
$itemsPerPageSelector = @'

      {/* Items per page selector */}
      {filteredProducts.length > 0 && (
        <div className="flex items-center justify-between mb-4">
          <div className="flex items-center space-x-2">
            <label htmlFor="items-per-page" className="text-sm font-medium text-gray-700 dark:text-gray-300">
              Mostrar:
            </label>
            <select
              id="items-per-page"
              value={itemsPerPage}
              onChange={(e) => handleItemsPerPageChange(Number(e.target.value))}
              className="appearance-none bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md px-3 py-1 pr-8 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
            >
              {[3, 6, 9, 12, 18, 24].map((option) => (
                <option key={option} value={option}>
                  {option} por página
                </option>
              ))}
            </select>
          </div>
        </div>
      )}'@

$dashboardContent = $dashboardContent -replace '      {/* Products List */}', "$itemsPerPageSelector`n      {/* Products List */}"

# Actualizar la lista de productos para usar paginatedProducts
$dashboardContent = $dashboardContent -replace '          \{filteredProducts\.map\(\(product\) => \(', '          {paginatedProducts.map((product) => ('

# Agregar componente Pagination
$paginationComponent = @'

          {/* Pagination */}
          <Pagination
            currentPage={currentPage}
            totalPages={totalPages}
            onPageChange={handlePageChange}
            totalItems={filteredProducts.length}
            itemsPerPage={itemsPerPage}
          />'@

$dashboardContent = $dashboardContent -replace '        </div>', "        </div>$paginationComponent"

# Escribir el archivo actualizado
$dashboardContent | Out-File -FilePath "src/pages/DashboardProducts.jsx" -Encoding UTF8
Write-Host "✅ DashboardProducts.jsx actualizado" -ForegroundColor Green

# Actualizar formatters.js para mejorar validación de fechas
Write-Host "📄 Mejorando validación de fechas en formatters.js..." -ForegroundColor Cyan

$formattersContent = Get-Content "src/utils/formatters.js" -Raw

$newFormatDate = @'
export const formatDate = (dateString) => {
  // Validar que dateString existe y no es null/undefined
  if (!dateString) {
    return "Fecha no disponible"
  }
  
  // Intentar crear la fecha
  const date = new Date(dateString)
  
  // Verificar si la fecha es válida
  if (isNaN(date.getTime())) {
    return "Fecha inválida"
  }
  
  return new Intl.DateTimeFormat("es-ES", {
    year: "numeric",
    month: "long",
    day: "numeric",
  }).format(date)
}'@

$formattersContent = $formattersContent -replace 'export const formatDate = \(dateString\) => \{[\s\S]*?\}', $newFormatDate

$formattersContent | Out-File -FilePath "src/utils/formatters.js" -Encoding UTF8
Write-Host "✅ formatters.js actualizado" -ForegroundColor Green

Write-Host ""
Write-Host "🎉 ¡Commit 09 aplicado exitosamente!" -ForegroundColor Green
Write-Host ""
Write-Host "📋 RESUMEN DE CAMBIOS:" -ForegroundColor Yellow
Write-Host "  ✅ Componente Pagination.jsx creado" -ForegroundColor White
Write-Host "  ✅ DashboardProducts.jsx actualizado con paginación" -ForegroundColor White
Write-Host "  ✅ formatters.js mejorado con validación robusta" -ForegroundColor White
Write-Host ""
Write-Host "🚀 PRÓXIMOS PASOS:" -ForegroundColor Cyan
Write-Host "  1. git add ." -ForegroundColor White
Write-Host "  2. git commit -F tpo-commits/commit09/commit-message.txt" -ForegroundColor White
Write-Host "  3. git push -u origin feature/commit09-tu-nombre" -ForegroundColor White
Write-Host "  4. Crear Pull Request" -ForegroundColor White
Write-Host ""
Write-Host "✨ ¡La paginación está lista para usar!" -ForegroundColor Green
