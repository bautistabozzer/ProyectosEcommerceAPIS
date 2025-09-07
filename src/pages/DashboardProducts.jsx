import { useState } from "react"
import { Link } from "react-router-dom"
import { useAuth } from "../context/AuthContext"
import { useToast } from "../context/ToastContext"
import { useFetch } from "../hooks/useFetch"
import { api } from "../services/api"
import { formatPrice, formatDate } from "../utils/formatters"
import LoadingSpinner from "../components/LoadingSpinner"
import EmptyState from "../components/EmptyState"
import SkeletonLoader from "../components/SkeletonLoader"
import { Plus, Edit, Trash2, Package, Eye, Search } from "lucide-react"
const DashboardProducts = () => {
  const { user } = useAuth()
  const { success, error } = useToast()
  const [searchTerm, setSearchTerm] = useState("")
  const [isDeleting, setIsDeleting] = useState(null)
  const { data: allProducts, loading, error: fetchError, refetch } = useFetch(() => api.getProducts(), [])
  
  // Debug logging
  console.log('DashboardProducts - Current user:', user)
  console.log('DashboardProducts - All products:', allProducts)
  console.log('DashboardProducts - User ID:', user?.id, 'Type:', typeof user?.id)
  
  // Filter products by current user (compare as strings to handle both numeric and string IDs)
  const userProducts = allProducts?.filter((product) => {
    const productOwnerId = String(product.ownerUserId)
    const userId = String(user?.id)
    const matches = productOwnerId === userId && productOwnerId !== 'null' && productOwnerId !== 'undefined'
    console.log(`Product ${product.id}: ownerUserId=${product.ownerUserId} (${typeof product.ownerUserId}) -> ${productOwnerId}, user.id=${user?.id} (${typeof user?.id}) -> ${userId}, matches=${matches}`)
    return matches
  }) || []
  
  console.log('DashboardProducts - Filtered user products:', userProducts)
  // Filter by search term
  const filteredProducts = userProducts.filter((product) =>
    product.name.toLowerCase().includes(searchTerm.toLowerCase()),
  )
  const handleDelete = async (productId, productName) => {
    if (!window.confirm(`¿Estás seguro de que quieres eliminar "${productName}"?`)) {
      return
    }
    setIsDeleting(productId)
    try {
      await api.deleteProduct(productId)
      success(`${productName} eliminado exitosamente`)
      refetch()
    } catch (err) {
      error("Error al eliminar el producto: " + err.message)
    } finally {
      setIsDeleting(null)
    }
  }
  if (loading) {
    return (
      <div className="space-y-6">
        <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
                  <div>
          <h1 className="text-3xl font-bold text-gray-900 dark:text-white">Mis Productos</h1>
          <p className="text-gray-600 dark:text-gray-300 mt-1">Gestiona tu inventario de productos</p>
        </div>
          <div className="h-10 bg-gray-200 rounded w-32 animate-pulse"></div>
        </div>
        <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
          <div className="relative max-w-md">
            <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
              <Search className="h-5 w-5 text-gray-400" />
            </div>
            <input type="text" placeholder="Buscar productos..." className="input pl-10" disabled />
          </div>
          <div className="flex items-center gap-4 text-sm text-gray-400">
            <span>Cargando estadísticas...</span>
          </div>
        </div>
        <SkeletonLoader type="list" count={4} />
      </div>
    )
  }
  if (fetchError) {
    return (
      <div className="text-center py-12">
        <p className="text-red-600 mb-4">Error al cargar los productos: {fetchError}</p>
        <button onClick={refetch} className="btn btn-primary">
          Reintentar
        </button>
      </div>
    )
  }
  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-3xl font-bold text-gray-900 dark:text-white">Mis Productos</h1>
          <p className="text-gray-600 dark:text-gray-300 mt-1">Gestiona tu inventario de productos</p>
        </div>
        <Link to="/dashboard/products/new" className="btn btn-primary inline-flex items-center gap-2">
          <Plus size={18} />
          Nuevo Producto
        </Link>
      </div>
      {/* Search and Stats */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        {/* Search */}
        <div className="relative max-w-md">
          <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
            <Search className="h-5 w-5 text-gray-400" />
          </div>
          <input
            type="text"
            placeholder="Buscar productos..."
            className="input pl-10"
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
          />
        </div>
        {/* Stats */}
        <div className="flex items-center gap-4 text-sm text-gray-600 dark:text-gray-300">
          <span>Total: {userProducts.length} productos</span>
          <span>En stock: {userProducts.filter((p) => p.stock > 0).length}</span>
          <span>Sin stock: {userProducts.filter((p) => p.stock === 0).length}</span>
        </div>
      </div>
      {/* Products List */}
      {filteredProducts.length === 0 ? (
        <EmptyState
          icon={Package}
          title={searchTerm ? "No se encontraron productos" : "No tienes productos"}
          description={searchTerm ? "Intenta ajustar tu búsqueda" : "Comienza creando tu primer producto para vender"}
          action={
            !searchTerm && (
              <Link to="/dashboard/products/new" className="btn btn-primary">
                Crear primer producto
              </Link>
            )
          }
        />
      ) : (
        <div className="space-y-4">
          {filteredProducts.map((product) => (
            <ProductRow
              key={product.id}
              product={product}
              onDelete={handleDelete}
              isDeleting={isDeleting === product.id}
            />
          ))}
        </div>
      )}
    </div>
  )
}
const ProductRow = ({ product, onDelete, isDeleting }) => {
  const isOutOfStock = product.stock === 0
  return (
    <div className="card p-6">
      <div className="flex items-center space-x-4">
        {/* Product Image */}
        <div className="flex-shrink-0">
          <img
            src={product.images?.[0] || "/placeholder.svg?height=80&width=80"}
            alt={product.name}
            className="w-20 h-20 object-cover rounded-md"
          />
        </div>
        {/* Product Info */}
        <div className="flex-1 min-w-0">
          <div className="flex items-start justify-between">
            <div>
              <h3 className="text-lg font-semibold text-gray-900 dark:text-white">{product.name}</h3>
              <p className="text-sm text-gray-600 dark:text-gray-300 mt-1 line-clamp-2">{product.description}</p>
              <div className="flex items-center gap-4 mt-2">
                <span className="text-lg font-bold text-blue-600 dark:text-blue-400">{formatPrice(product.price)}</span>
                <span className={`text-sm font-medium ${isOutOfStock ? "text-red-600 dark:text-red-400" : "text-green-600 dark:text-green-400"}`}>
                  {isOutOfStock ? "Sin stock" : `${product.stock} en stock`}
                </span>
                <span className="text-sm text-gray-500 dark:text-gray-400">Creado: {formatDate(product.createdAt)}</span>
              </div>
            </div>
            {/* Actions */}
            <div className="flex items-center space-x-2">
              <Link
                to={`/product/${product.id}`}
                className="p-2 text-gray-600 dark:text-gray-400 hover:text-blue-600 dark:hover:text-blue-400 hover:bg-blue-50 dark:hover:bg-blue-900/20 rounded-md transition-colors"
                title="Ver producto"
              >
                <Eye size={18} />
              </Link>
              <Link
                to={`/dashboard/products/${product.id}/edit`}
                className="p-2 text-gray-600 dark:text-gray-400 hover:text-blue-600 dark:hover:text-blue-400 hover:bg-blue-50 dark:hover:bg-blue-900/20 rounded-md transition-colors"
                title="Editar producto"
              >
                <Edit size={18} />
              </Link>
              <button
                onClick={() => onDelete(product.id, product.name)}
                disabled={isDeleting}
                className="p-2 text-gray-600 dark:text-gray-400 hover:text-red-600 dark:hover:text-red-400 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-md transition-colors disabled:opacity-50"
                title="Eliminar producto"
              >
                {isDeleting ? <LoadingSpinner size="sm" /> : <Trash2 size={18} />}
              </button>
            </div>
          </div>
        </div>
      </div>
      {/* Stock Warning */}
      {product.stock <= 5 && product.stock > 0 && (
        <div className="mt-4 p-3 bg-yellow-50 dark:bg-yellow-900/20 border border-yellow-200 dark:border-yellow-700 rounded-md">
          <p className="text-sm text-yellow-800 dark:text-yellow-200">⚠️ Stock bajo: Solo quedan {product.stock} unidades</p>
        </div>
      )}
    </div>
  )
}
export default DashboardProducts
