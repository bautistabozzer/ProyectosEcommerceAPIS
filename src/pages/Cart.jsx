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
          <h1 className="text-3xl font-bold text-gray-900">Carrito de Compras</h1>
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
          <h1 className="text-3xl font-bold text-gray-900">Carrito de Compras</h1>
          <p className="text-gray-600 mt-1">
            {items.length} producto{items.length !== 1 ? "s" : ""} en tu carrito
          </p>
        </div>
        <Link to="/" className="inline-flex items-center text-blue-600 hover:text-blue-800 transition-colors">
          <ArrowLeft size={16} className="mr-1" />
          Seguir comprando
        </Link>
      </div>
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
        {/* Cart Items */}
        <div className="lg:col-span-2 space-y-4">
          {/* Clear cart button */}
          <div className="flex justify-end">
            <button onClick={handleClearCart} className="text-sm text-red-600 hover:text-red-800 transition-colors">
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
            <h2 className="text-lg font-semibold text-gray-900 mb-4">Resumen del pedido</h2>
            <div className="space-y-3 mb-6">
              {items.map((item) => (
                <div key={item.id} className="flex justify-between text-sm">
                  <span className="text-gray-600">
                    {item.name} × {item.quantity}
                  </span>
                  <span className="text-gray-900">{formatPrice(item.price * item.quantity)}</span>
                </div>
              ))}
            </div>
            <div className="border-t border-gray-200 pt-4 mb-6">
              <div className="flex justify-between text-lg font-semibold">
                <span>Total</span>
                <span className="text-blue-600">{formatPrice(total)}</span>
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
            <p className="text-xs text-gray-500 text-center mt-3">
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
            <h3 className="text-lg font-medium text-gray-900 hover:text-blue-600 transition-colors">{item.name}</h3>
          </Link>
          <p className="text-sm text-gray-600 mt-1 line-clamp-2">{item.description}</p>
          <p className="text-lg font-semibold text-blue-600 mt-2">{formatPrice(item.price)}</p>
        </div>
        {/* Quantity Controls */}
        <div className="flex items-center space-x-3">
          <div className="flex items-center border border-gray-300 rounded-md">
            <button
              onClick={() => onQuantityChange(item.id, item.quantity - 1)}
              className="p-1 hover:bg-gray-100 transition-colors"
              aria-label="Disminuir cantidad"
            >
              <Minus size={16} />
            </button>
            <span className="px-3 py-1 text-center min-w-12">{item.quantity}</span>
            <button
              onClick={() => onQuantityChange(item.id, item.quantity + 1)}
              className="p-1 hover:bg-gray-100 transition-colors"
              aria-label="Aumentar cantidad"
            >
              <Plus size={16} />
            </button>
          </div>
          {/* Remove Button */}
          <button
            onClick={() => onRemove(item.id, item.name)}
            className="p-2 text-red-600 hover:text-red-800 hover:bg-red-50 rounded-md transition-colors"
            aria-label="Eliminar producto"
          >
            <Trash2 size={18} />
          </button>
        </div>
      </div>
      {/* Item Total */}
      <div className="mt-4 pt-4 border-t border-gray-200">
        <div className="flex justify-between items-center">
          <span className="text-sm text-gray-600">Subtotal:</span>
          <span className="text-lg font-semibold text-gray-900">{formatPrice(item.price * item.quantity)}</span>
        </div>
      </div>
    </div>
  )
}
export default Cart
