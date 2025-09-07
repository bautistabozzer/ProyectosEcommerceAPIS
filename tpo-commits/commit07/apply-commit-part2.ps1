# Script adicional para aplicar el commit07 - Páginas restantes
# Ejecutar en PowerShell desde la raíz del repositorio

Write-Host "Aplicando commit07 parte 2 - Páginas restantes..." -ForegroundColor Green

# Crear src/pages/ProductDetail.jsx
@"
import { useState } from "react"
import { useParams, Link } from "react-router-dom"
import { useFetch } from "../hooks/useFetch"
import { useCart } from "../context/CartContext"
import { useToast } from "../context/ToastContext"
import { api } from "../services/api"
import { formatPrice } from "../utils/formatters"
import LoadingSpinner from "../components/LoadingSpinner"
import ProductCard from "../components/ProductCard"
import { ArrowLeft, ShoppingCart, Package, Star } from "lucide-react"

const ProductDetail = () => {
  const { id } = useParams()
  const [selectedImageIndex, setSelectedImageIndex] = useState(0)
  const { addToCart } = useCart()
  const { success, error } = useToast()

  const { data: product, loading, error: fetchError } = useFetch(() => api.getProduct(id), [id])
  
  // Fetch related products (same category, excluding current product)
  const { data: relatedProducts } = useFetch(
    () => product ? api.getProducts({ categoryId: product.categoryId }) : Promise.resolve([]),
    [product?.categoryId]
  )

  const handleAddToCart = () => {
    if (!product) return
    if (product.stock === 0) {
      error("Producto sin stock")
      return
    }
    addToCart(product)
    success(`${product.name} agregado al carrito`)
  }

  if (loading) {
    return (
      <div className="flex justify-center items-center min-h-64">
        <LoadingSpinner size="lg" />
      </div>
    )
  }

  if (fetchError || !product) {
    return (
      <div className="text-center py-12">
        <Package className="mx-auto h-12 w-12 text-gray-400 mb-4" />
        <h3 className="text-lg font-medium text-gray-900 mb-2">Producto no encontrado</h3>
        <p className="text-gray-600 mb-4">El producto que buscas no existe o ha sido eliminado.</p>
        <Link to="/" className="btn btn-primary">
          Volver al catálogo
        </Link>
      </div>
    )
  }

  const isOutOfStock = product.stock === 0
  const images = product.images || ["/placeholder.svg?height=500&width=500"]
  
  // Filter related products (exclude current product and limit to 4)
  const filteredRelatedProducts = relatedProducts
    ?.filter(p => p.id !== product.id)
    ?.slice(0, 4) || []

  return (
    <div className="max-w-6xl mx-auto">
      {/* Breadcrumb */}
      <nav className="mb-6">
        <Link to="/" className="inline-flex items-center text-blue-600 hover:text-blue-800 transition-colors">
          <ArrowLeft size={16} className="mr-1" />
          Volver al catálogo
        </Link>
      </nav>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
        {/* Product Images */}
        <div className="space-y-4">
          {/* Main Image */}
          <div className="relative aspect-square bg-gray-100 rounded-lg overflow-hidden">
            <img
              src={images[selectedImageIndex] || "/placeholder.svg"}
              alt={product.name}
              className="w-full h-full object-cover"
            />
            {isOutOfStock && (
              <div className="absolute inset-0 bg-black bg-opacity-50 flex items-center justify-center">
                <span className="bg-red-600 text-white px-4 py-2 rounded-full text-lg font-medium">Sin Stock</span>
              </div>
            )}
          </div>
          {/* Thumbnail Images */}
          {images.length > 1 && (
            <div className="flex space-x-2 overflow-x-auto">
              {images.map((image, index) => (
                <button
                  key={index}
                  onClick={() => setSelectedImageIndex(index)}
                  className={`flex-shrink-0 w-20 h-20 rounded-md overflow-hidden border-2 transition-colors ${
                    selectedImageIndex === index ? "border-blue-600 dark:border-blue-400" : "border-gray-200 dark:border-gray-600 hover:border-gray-300 dark:hover:border-gray-500"
                  }`}
                >
                  <img
                    src={image || "/placeholder.svg"}
                    alt={`${product.name} ${index + 1}`}
                    className="w-full h-full object-cover"
                  />
                </button>
              ))}
            </div>
          )}
        </div>

        {/* Product Info */}
        <div className="space-y-6">
          <div>
            <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">{product.name}</h1>
            {/* Rating placeholder */}
            <div className="flex items-center mb-4">
              <div className="flex items-center">
                {[...Array(5)].map((_, i) => (
                  <Star key={i} size={16} className={`${i < 4 ? "text-yellow-400 fill-current" : "text-gray-300 dark:text-gray-600"}`} />
                ))}
              </div>
              <span className="ml-2 text-sm text-gray-600 dark:text-gray-400">(4.0) • 24 reseñas</span>
            </div>
          </div>

          {/* Price and Stock */}
          <div className="border-t border-b border-gray-200 dark:border-gray-600 py-6">
            <div className="flex items-center justify-between mb-4">
              <span className="text-3xl font-bold text-blue-600 dark:text-blue-400">{formatPrice(product.price)}</span>
              <span className={`text-lg font-medium ${isOutOfStock ? "text-red-600 dark:text-red-400" : "text-green-600 dark:text-green-400"}`}>
                {isOutOfStock ? "Sin stock" : `${product.stock} disponibles`}
              </span>
            </div>
            {/* Stock indicator */}
            <div className="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2">
              <div
                className={`h-2 rounded-full ${
                  product.stock > 10 ? "bg-green-500" : product.stock > 5 ? "bg-yellow-500" : "bg-red-500"
                }`}
                style={{ width: `${Math.min((product.stock / 20) * 100, 100)}%` }}
              ></div>
            </div>
            <p className="text-sm text-gray-600 dark:text-gray-400 mt-1">
              {product.stock > 10 ? "En stock" : product.stock > 0 ? "Pocas unidades" : "Agotado"}
            </p>
          </div>

          {/* Description */}
          <div>
            <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-2">Descripción</h3>
            <p className="text-gray-700 dark:text-gray-300 leading-relaxed">{product.description}</p>
          </div>

          {/* Add to Cart */}
          <div className="space-y-4">
            <button
              onClick={handleAddToCart}
              disabled={isOutOfStock}
              className={`w-full flex items-center justify-center gap-3 py-3 px-6 rounded-lg font-medium text-lg transition-colors ${
                isOutOfStock
                  ? "bg-gray-200 dark:bg-gray-600 text-gray-500 dark:text-gray-400 cursor-not-allowed"
                  : "bg-blue-600 text-white hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 dark:focus:ring-offset-gray-800"
              }`}
            >
              <ShoppingCart size={20} />
              {isOutOfStock ? "Producto Agotado" : "Agregar al Carrito"}
            </button>
            {!isOutOfStock && (
              <p className="text-sm text-gray-600 dark:text-gray-400 text-center">Envío gratis en pedidos superiores a €50</p>
            )}
          </div>

          {/* Product Details */}
          <div className="border-t border-gray-200 dark:border-gray-600 pt-6">
            <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">Detalles del producto</h3>
            <dl className="space-y-2">
              <div className="flex justify-between">
                <dt className="text-gray-600 dark:text-gray-400">SKU:</dt>
                <dd className="text-gray-900 dark:text-gray-100">#{product.id.toString().padStart(6, "0")}</dd>
              </div>
              <div className="flex justify-between">
                <dt className="text-gray-600 dark:text-gray-400">Disponibilidad:</dt>
                <dd className={isOutOfStock ? "text-red-600 dark:text-red-400" : "text-green-600 dark:text-green-400"}>
                  {isOutOfStock ? "Agotado" : "En stock"}
                </dd>
              </div>
              <div className="flex justify-between">
                <dt className="text-gray-600 dark:text-gray-400">Categoría:</dt>
                <dd className="text-gray-900 dark:text-gray-100">Categoría #{product.categoryId}</dd>
              </div>
            </dl>
          </div>
        </div>
      </div>
      
      {/* Related Products */}
      {filteredRelatedProducts.length > 0 && (
        <div className="mt-16">
          <div className="border-t border-gray-200 dark:border-gray-600 pt-8">
            <h2 className="text-2xl font-bold text-gray-900 dark:text-white mb-6">Productos Relacionados</h2>
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
              {filteredRelatedProducts.map((relatedProduct) => (
                <ProductCard key={relatedProduct.id} product={relatedProduct} />
              ))}
            </div>
          </div>
        </div>
      )}
    </div>
  )
}

export default ProductDetail
"@ | Out-File -FilePath "src/pages/ProductDetail.jsx" -Encoding UTF8

# Crear src/pages/Cart.jsx
@"
import { useState } from "react"
import { Link } from "react-router-dom"
import { useCart } from "../context/CartContext"
import { useToast } from "../context/ToastContext"
import { api } from "../services/api"
import { formatPrice } from "../utils/formatters"
import EmptyState from "../components/EmptyState"
import LoadingSpinner from "../components/LoadingSpinner"
import { ShoppingCart, Minus, Plus, Trash2, ArrowLeft, CreditCard } from "lucide-react"

const Cart = () => {
  const { items, total, updateQuantity, removeFromCart, clearCart } = useCart()
  const { success, error } = useToast()
  const [isCheckingOut, setIsCheckingOut] = useState(false)

  const handleQuantityChange = (productId, newQuantity) => {
    if (newQuantity < 1) {
      removeFromCart(productId)
      return
    }
    updateQuantity(productId, newQuantity)
  }

  const handleRemoveItem = (productId, productName) => {
    removeFromCart(productId)
    success(`${productName} eliminado del carrito`)
  }

  const handleClearCart = () => {
    if (window.confirm("¿Estás seguro de que quieres vaciar el carrito?")) {
      clearCart()
      success("Carrito vaciado")
    }
  }

  const validateStock = async () => {
    const stockErrors = []
    for (const item of items) {
      try {
        const product = await api.getProduct(item.id)
        if (product.stock < item.quantity) {
          stockErrors.push({
            name: item.name,
            available: product.stock,
            requested: item.quantity,
          })
        }
      } catch (err) {
        stockErrors.push({
          name: item.name,
          error: "Producto no encontrado",
        })
      }
    }
    return stockErrors
  }

  const handleCheckout = async () => {
    if (items.length === 0) {
      error("El carrito está vacío")
      return
    }

    setIsCheckingOut(true)
    try {
      // Validate stock for all items
      const stockErrors = await validateStock()
      if (stockErrors.length > 0) {
        const errorMessages = stockErrors.map((err) => {
          if (err.error) {
            return `${err.name}: ${err.error}`
          }
          return `${err.name}: Solo ${err.available} disponibles (solicitaste ${err.requested})`
        })
        error(`Stock insuficiente:\n${errorMessages.join("\n")}`)
        setIsCheckingOut(false)
        return
      }

      // Update stock for each item
      for (const item of items) {
        const product = await api.getProduct(item.id)
        const newStock = product.stock - item.quantity
        await api.updateProductStock(item.id, newStock)
      }

      // Clear cart and show success
      clearCart()
      success("¡Compra realizada exitosamente! El stock ha sido actualizado.")
    } catch (err) {
      error("Error al procesar la compra: " + err.message)
    } finally {
      setIsCheckingOut(false)
    }
  }

  if (items.length === 0) {
    return (
      <div>
        <div className="flex items-center justify-between mb-8">
          <h1 className="text-3xl font-bold text-gray-900 dark:text-white">Carrito de Compras</h1>
        </div>
        <EmptyState
          icon={ShoppingCart}
          title="Tu carrito está vacío"
          description="Agrega algunos productos para comenzar tu compra"
          action={
            <Link to="/" className="btn btn-primary">
              Explorar productos
            </Link>
          }
        />
      </div>
    )
  }

  return (
    <div className="max-w-4xl mx-auto">
      {/* Header */}
      <div className="flex items-center justify-between mb-8">
        <div>
          <h1 className="text-3xl font-bold text-gray-900 dark:text-white">Carrito de Compras</h1>
          <p className="text-gray-600 dark:text-gray-300 mt-1">
            {items.length} producto{items.length !== 1 ? "s" : ""} en tu carrito
          </p>
        </div>
        <Link to="/" className="inline-flex items-center text-blue-600 dark:text-blue-400 hover:text-blue-800 dark:hover:text-blue-300 transition-colors">
          <ArrowLeft size={16} className="mr-1" />
          Seguir comprando
        </Link>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
        {/* Cart Items */}
        <div className="lg:col-span-2 space-y-4">
          {/* Clear cart button */}
          <div className="flex justify-end">
            <button onClick={handleClearCart} className="text-sm text-red-600 dark:text-red-400 hover:text-red-800 dark:hover:text-red-300 transition-colors">
              Vaciar carrito
            </button>
          </div>
          {/* Items list */}
          <div className="space-y-4">
            {items.map((item) => (
              <CartItem key={item.id} item={item} onQuantityChange={handleQuantityChange} onRemove={handleRemoveItem} />
            ))}
          </div>
        </div>

        {/* Order Summary */}
        <div className="lg:col-span-1">
          <div className="card p-6 sticky top-4">
            <h2 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">Resumen del pedido</h2>
            <div className="space-y-3 mb-6">
              {items.map((item) => (
                <div key={item.id} className="flex justify-between text-sm">
                  <span className="text-gray-600 dark:text-gray-300">
                    {item.name} × {item.quantity}
                  </span>
                  <span className="text-gray-900 dark:text-white">{formatPrice(item.price * item.quantity)}</span>
                </div>
              ))}
            </div>
            <div className="border-t border-gray-200 dark:border-gray-600 pt-4 mb-6">
              <div className="flex justify-between text-lg font-semibold">
                <span className="text-gray-900 dark:text-white">Total</span>
                <span className="text-blue-600 dark:text-blue-400">{formatPrice(total)}</span>
              </div>
            </div>
            <button
              onClick={handleCheckout}
              disabled={isCheckingOut}
              className="w-full flex items-center justify-center gap-2 py-3 px-4 bg-blue-600 text-white rounded-lg font-medium hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
            >
              {isCheckingOut ? (
                <>
                  <LoadingSpinner size="sm" className="border-white border-t-transparent" />
                  Procesando...
                </>
              ) : (
                <>
                  <CreditCard size={18} />
                  Proceder al checkout
                </>
              )}
            </button>
            <p className="text-xs text-gray-500 dark:text-gray-400 text-center mt-3">
              Al hacer clic en "Proceder al checkout", se validará el stock y se actualizará automáticamente.
            </p>
          </div>
        </div>
      </div>
    </div>
  )
}

const CartItem = ({ item, onQuantityChange, onRemove }) => {
  return (
    <div className="card p-4">
      <div className="flex items-center space-x-4">
        {/* Product Image */}
        <div className="flex-shrink-0">
          <img
            src={item.images?.[0] || "/placeholder.svg?height=80&width=80"}
            alt={item.name}
            className="w-20 h-20 object-cover rounded-md"
          />
        </div>
        {/* Product Info */}
        <div className="flex-1 min-w-0">
          <Link to={`/product/${item.id}`} className="block">
            <h3 className="text-lg font-medium text-gray-900 dark:text-white hover:text-blue-600 dark:hover:text-blue-400 transition-colors">{item.name}</h3>
          </Link>
          <p className="text-sm text-gray-600 dark:text-gray-300 mt-1 line-clamp-2">{item.description}</p>
          <p className="text-lg font-semibold text-blue-600 dark:text-blue-400 mt-2">{formatPrice(item.price)}</p>
        </div>
        {/* Quantity Controls */}
        <div className="flex items-center space-x-3">
          <div className="flex items-center border border-gray-300 dark:border-gray-600 rounded-md bg-white dark:bg-gray-800">
            <button
              onClick={() => onQuantityChange(item.id, item.quantity - 1)}
              className="p-1 hover:bg-gray-100 dark:hover:bg-gray-700 transition-colors text-gray-700 dark:text-white"
              aria-label="Disminuir cantidad"
            >
              <Minus size={16} />
            </button>
            <span className="px-3 py-1 text-center min-w-12 text-gray-900 dark:text-white">{item.quantity}</span>
            <button
              onClick={() => onQuantityChange(item.id, item.quantity + 1)}
              className="p-1 hover:bg-gray-100 dark:hover:bg-gray-700 transition-colors text-gray-700 dark:text-white"
              aria-label="Aumentar cantidad"
            >
              <Plus size={16} />
            </button>
          </div>
          {/* Remove Button */}
          <button
            onClick={() => onRemove(item.id, item.name)}
            className="p-2 text-red-600 dark:text-red-400 hover:text-red-800 dark:hover:text-red-300 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-md transition-colors"
            aria-label="Eliminar producto"
          >
            <Trash2 size={18} />
          </button>
        </div>
      </div>
      {/* Item Total */}
      <div className="mt-4 pt-4 border-t border-gray-200 dark:border-gray-600">
        <div className="flex justify-between items-center">
          <span className="text-sm text-gray-600 dark:text-gray-300">Subtotal:</span>
          <span className="text-lg font-semibold text-gray-900 dark:text-white">{formatPrice(item.price * item.quantity)}</span>
        </div>
      </div>
    </div>
  )
}

export default Cart
"@ | Out-File -FilePath "src/pages/Cart.jsx" -Encoding UTF8

Write-Host "✅ Commit07 parte 2 aplicada exitosamente!" -ForegroundColor Green
Write-Host "Ahora puedes hacer: git add . && git commit -F tpo-commits/commit07/commit-message.txt" -ForegroundColor Yellow
