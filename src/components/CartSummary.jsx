import { useCart } from "../context/CartContext"
import { formatPrice } from "../utils/formatters"
const CartSummary = ({ showDetails = false }) => {
  const { items, total } = useCart()
  if (items.length === 0) {
    return null
  }
  return (
    <div className="bg-gray-50 p-4 rounded-lg">
      <h3 className="font-semibold text-gray-900 mb-3">Resumen del carrito</h3>
      {showDetails && (
        <div className="space-y-2 mb-4">
          {items.map((item) => (
            <div key={item.id} className="flex justify-between text-sm">
              <span className="text-gray-600">
                {item.name} × {item.quantity}
              </span>
              <span className="text-gray-900">{formatPrice(item.price * item.quantity)}</span>
            </div>
          ))}
        </div>
      )}
      <div className="border-t border-gray-200 pt-3">
        <div className="flex justify-between font-semibold">
          <span>Total ({items.length} productos)</span>
          <span className="text-blue-600">{formatPrice(total)}</span>
        </div>
      </div>
    </div>
  )
}
export default CartSummary
