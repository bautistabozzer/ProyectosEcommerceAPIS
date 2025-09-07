# Script para aplicar el commit05 - Componentes base
# Ejecutar en PowerShell desde la raíz del repositorio

Write-Host "Aplicando commit05 - Componentes base..." -ForegroundColor Green

# Crear directorios necesarios
$directories = @("src/components", "src/components/modals")
foreach ($dir in $directories) {
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force
    }
}

# Crear src/components/Layout.jsx
@"
import Header from "./Header"
import Footer from "./Footer"

const Layout = ({ children }) => {
  return (
    <div className="min-h-screen flex flex-col bg-white dark:bg-gray-900 text-gray-900 dark:text-gray-100">
      <Header />
      <main className="flex-1 container mx-auto px-4 py-8">{children}</main>
      <Footer />
    </div>
  )
}

export default Layout
"@ | Out-File -FilePath "src/components/Layout.jsx" -Encoding UTF8

# Crear src/components/Header.jsx
@"
import { Link, useNavigate } from "react-router-dom"
import { useAuth } from "../context/AuthContext"
import { useCart } from "../context/CartContext"
import { ShoppingCart, User, LogOut, Package } from "lucide-react"
import ThemeToggle from "./ThemeToggle"

const Header = () => {
  const { user, logout } = useAuth()
  const { getCartItemsCount } = useCart()
  const navigate = useNavigate()

  const handleLogout = () => {
    logout()
    navigate("/login")
  }

  const cartItemsCount = getCartItemsCount()

  return (
    <header className="bg-white dark:bg-gray-700 shadow-md border-b border-gray-200 dark:border-gray-500">
      <div className="container mx-auto px-4">
        <div className="flex items-center justify-between h-16">
          {/* Logo */}
          <Link to="/" className="text-2xl font-bold text-blue-600 dark:text-blue-400">
            E-Commerce
          </Link>

          {/* Navigation */}
          <nav className="hidden md:flex items-center space-x-6">
            <Link to="/" className="text-gray-700 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400 transition-colors">
              Inicio
            </Link>
            <Link
              to="/dashboard/products"
              className="text-gray-700 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400 transition-colors flex items-center gap-2"
            >
              <Package size={18} />
              Mis Productos
            </Link>
          </nav>

          {/* User actions */}
          <div className="flex items-center space-x-4">
            {/* Theme Toggle */}
            <ThemeToggle />

            {/* Cart */}
            <Link to="/cart" className="relative p-2 text-gray-700 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400 transition-colors">
              <ShoppingCart size={24} />
              {cartItemsCount > 0 && (
                <span className="absolute -top-1 -right-1 bg-red-500 text-white text-xs rounded-full h-5 w-5 flex items-center justify-center">
                  {cartItemsCount}
                </span>
              )}
            </Link>

            {/* User menu */}
            <div className="flex items-center space-x-2">
              <div className="flex items-center space-x-2 text-gray-700 dark:text-gray-300">
                <User size={20} />
                <span className="hidden sm:inline">
                  {user?.firstName} {user?.lastName}
                </span>
              </div>
              <button
                onClick={handleLogout}
                className="p-2 text-gray-700 dark:text-gray-300 hover:text-red-600 dark:hover:text-red-400 transition-colors"
                title="Cerrar sesión"
              >
                <LogOut size={20} />
              </button>
            </div>
          </div>
        </div>

        {/* Mobile navigation */}
        <nav className="md:hidden pb-4">
          <div className="flex space-x-4">
            <Link to="/" className="text-gray-700 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400 transition-colors">
              Inicio
            </Link>
            <Link to="/dashboard/products" className="text-gray-700 dark:text-gray-300 hover:text-blue-600 dark:hover:text-blue-400 transition-colors">
              Mis Productos
            </Link>
          </div>
        </nav>
      </div>
    </header>
  )
}

export default Header
"@ | Out-File -FilePath "src/components/Header.jsx" -Encoding UTF8

# Crear src/components/Footer.jsx
@"
import { useState } from "react"
import AboutUsModal from "./modals/AboutUsModal"
import ContactModal from "./modals/ContactModal"
import TermsModal from "./modals/TermsModal"
import PrivacyModal from "./modals/PrivacyModal"

const Footer = () => {
  const [isAboutUsOpen, setIsAboutUsOpen] = useState(false)
  const [isContactOpen, setIsContactOpen] = useState(false)
  const [isTermsOpen, setIsTermsOpen] = useState(false)
  const [isPrivacyOpen, setIsPrivacyOpen] = useState(false)

  return (
    <>
      <footer className="bg-gray-800 dark:bg-gray-700 text-white py-8">
        <div className="container mx-auto px-4">
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div>
              <h3 className="text-lg font-semibold mb-4">E-Commerce</h3>
              <p className="text-gray-300 dark:text-gray-100">Tu tienda online de confianza para encontrar los mejores productos.</p>
            </div>
            <div>
              <h4 className="text-lg font-semibold mb-4">Enlaces</h4>
              <ul className="space-y-2 text-gray-300 dark:text-gray-100">
                <li>
                  <button 
                    onClick={() => setIsAboutUsOpen(true)}
                    className="hover:text-white transition-colors text-left"
                  >
                    Sobre nosotros
                  </button>
                </li>
                <li>
                  <button 
                    onClick={() => setIsContactOpen(true)}
                    className="hover:text-white transition-colors text-left"
                  >
                    Contacto
                  </button>
                </li>
                <li>
                  <button 
                    onClick={() => setIsTermsOpen(true)}
                    className="hover:text-white transition-colors text-left"
                  >
                    Términos y condiciones
                  </button>
                </li>
                <li>
                  <button 
                    onClick={() => setIsPrivacyOpen(true)}
                    className="hover:text-white transition-colors text-left"
                  >
                    Política de privacidad
                  </button>
                </li>
              </ul>
            </div>
            <div>
              <h4 className="text-lg font-semibold mb-4">Contacto</h4>
              <div className="text-gray-300 dark:text-gray-100 space-y-2">
                <p>Email: info@ecommerce.com</p>
                <p>Teléfono: +1 234 567 890</p>
                <p>Dirección: 123 Calle Principal, Ciudad</p>
              </div>
            </div>
          </div>
          <div className="border-t border-gray-700 dark:border-gray-500 mt-8 pt-8 text-center text-gray-300 dark:text-gray-100">
            <p>&copy; 2024 E-Commerce. Todos los derechos reservados.</p>
          </div>
        </div>
      </footer>

      {/* Modals */}
      <AboutUsModal 
        isOpen={isAboutUsOpen} 
        onClose={() => setIsAboutUsOpen(false)} 
      />
      
      <ContactModal 
        isOpen={isContactOpen} 
        onClose={() => setIsContactOpen(false)} 
      />
      
      <TermsModal 
        isOpen={isTermsOpen} 
        onClose={() => setIsTermsOpen(false)} 
      />
      
      <PrivacyModal 
        isOpen={isPrivacyOpen} 
        onClose={() => setIsPrivacyOpen(false)} 
      />
    </>
  )
}

export default Footer
"@ | Out-File -FilePath "src/components/Footer.jsx" -Encoding UTF8

# Crear src/components/ProductCard.jsx
@"
import { Link } from "react-router-dom"
import { useCart } from "../context/CartContext"
import { useToast } from "../context/ToastContext"
import { formatPrice } from "../utils/formatters"
import { ShoppingCart, Eye } from "lucide-react"

const ProductCard = ({ product }) => {
  const { addToCart } = useCart()
  const { success, error } = useToast()

  const handleAddToCart = (e) => {
    e.preventDefault()
    e.stopPropagation()
    if (product.stock === 0) {
      error("Producto sin stock")
      return
    }
    addToCart(product)
    success(`${product.name} agregado al carrito`)
  }

  const isOutOfStock = product.stock === 0

  return (
    <div className="card overflow-hidden hover:shadow-lg transition-shadow duration-200 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700">
      <Link to={`/product/${product.id}`} className="block">
        {/* Product Image */}
        <div className="relative aspect-square bg-gray-100 dark:bg-gray-700">
          <img
            src={product.images?.[0] || "/placeholder.svg?height=300&width=300"}
            alt={product.name}
            className="w-full h-full object-cover"
            loading="lazy"
          />
          {isOutOfStock && (
            <div className="absolute inset-0 bg-black bg-opacity-50 flex items-center justify-center">
              <span className="bg-red-600 text-white px-3 py-1 rounded-full text-sm font-medium">Sin Stock</span>
            </div>
          )}
          {/* Quick view button */}
          <div className="absolute top-2 right-2 opacity-0 group-hover:opacity-100 transition-opacity">
            <button className="p-2 bg-white dark:bg-gray-600 rounded-full shadow-md hover:bg-gray-50 dark:hover:bg-gray-500">
              <Eye size={16} className="text-gray-600 dark:text-gray-300" />
            </button>
          </div>
        </div>

        {/* Product Info */}
        <div className="p-4">
          <h3 className="font-semibold text-gray-900 dark:text-white mb-1 line-clamp-2">{product.name}</h3>
          <p className="text-sm text-gray-600 dark:text-gray-300 mb-2 line-clamp-2">{product.description}</p>
          <div className="flex items-center justify-between mb-3">
            <span className="text-lg font-bold text-blue-600 dark:text-blue-400">{formatPrice(product.price)}</span>
            <span className={`text-sm ${isOutOfStock ? "text-red-600 dark:text-red-400" : "text-green-600 dark:text-green-400"}`}>
              {isOutOfStock ? "Sin stock" : `${product.stock} disponibles`}
            </span>
          </div>
        </div>
      </Link>

      {/* Add to Cart Button */}
      <div className="px-4 pb-4">
        <button
          onClick={handleAddToCart}
          disabled={isOutOfStock}
          className={`w-full flex items-center justify-center gap-2 py-2 px-4 rounded-md font-medium transition-colors ${
            isOutOfStock
              ? "bg-gray-200 dark:bg-gray-600 text-gray-500 dark:text-gray-400 cursor-not-allowed"
              : "bg-blue-600 dark:bg-blue-500 text-white hover:bg-blue-700 dark:hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500 dark:focus:ring-blue-400 focus:ring-offset-2 dark:focus:ring-offset-gray-800"
          }`}
        >
          <ShoppingCart size={16} />
          {isOutOfStock ? "Sin Stock" : "Agregar al Carrito"}
        </button>
      </div>
    </div>
  )
}

export default ProductCard
"@ | Out-File -FilePath "src/components/ProductCard.jsx" -Encoding UTF8

# Crear src/components/LoadingSpinner.jsx
@"
const LoadingSpinner = ({ size = "md", className = "" }) => {
  const sizeClasses = {
    sm: "h-4 w-4",
    md: "h-8 w-8",
    lg: "h-12 w-12",
  }

  return (
    <div
      className={`animate-spin rounded-full border-2 border-gray-300 border-t-blue-600 ${sizeClasses[size]} ${className}`}
    ></div>
  )
}

export default LoadingSpinner
"@ | Out-File -FilePath "src/components/LoadingSpinner.jsx" -Encoding UTF8

# Crear src/components/EmptyState.jsx
@"
const EmptyState = ({ title, description, action, icon: Icon }) => {
  return (
    <div className="text-center py-12">
      {Icon && (
        <div className="mx-auto h-12 w-12 text-gray-400 mb-4">
          <Icon size={48} />
        </div>
      )}
      <h3 className="mt-2 text-sm font-medium text-gray-900">{title}</h3>
      <p className="mt-1 text-sm text-gray-500">{description}</p>
      {action && <div className="mt-6">{action}</div>}
    </div>
  )
}

export default EmptyState
"@ | Out-File -FilePath "src/components/EmptyState.jsx" -Encoding UTF8

# Crear src/components/ErrorBoundary.jsx
@"
import React from "react"
import { AlertTriangle, RefreshCw } from "lucide-react"

class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props)
    this.state = { hasError: false, error: null, errorInfo: null }
  }

  static getDerivedStateFromError(error) {
    return { hasError: true }
  }

  componentDidCatch(error, errorInfo) {
    this.setState({
      error: error,
      errorInfo: errorInfo,
    })
  }

  handleReload = () => {
    window.location.reload()
  }

  render() {
    if (this.state.hasError) {
      return (
        <div className="min-h-screen flex items-center justify-center bg-gray-50 px-4">
          <div className="max-w-md w-full text-center">
            <div className="mb-6">
              <AlertTriangle className="mx-auto h-16 w-16 text-red-500 mb-4" />
              <h1 className="text-2xl font-bold text-gray-900 mb-2">¡Oops! Algo salió mal</h1>
              <p className="text-gray-600">
                Ha ocurrido un error inesperado. Por favor, recarga la página o contacta al soporte si el problema
                persiste.
              </p>
            </div>
            <div className="space-y-4">
              <button
                onClick={this.handleReload}
                className="btn btn-primary w-full flex items-center justify-center gap-2"
              >
                <RefreshCw size={18} />
                Recargar página
              </button>
              <button
                onClick={() => this.setState({ hasError: false, error: null, errorInfo: null })}
                className="btn btn-secondary w-full"
              >
                Intentar de nuevo
              </button>
            </div>
            {process.env.NODE_ENV === "development" && this.state.error && (
              <details className="mt-6 text-left">
                <summary className="cursor-pointer text-sm text-gray-500 hover:text-gray-700">
                  Detalles del error (desarrollo)
                </summary>
                <div className="mt-2 p-4 bg-red-50 border border-red-200 rounded-md text-xs text-red-800 overflow-auto">
                  <pre>{this.state.error && this.state.error.toString()}</pre>
                  <pre>{this.state.errorInfo.componentStack}</pre>
                </div>
              </details>
            )}
          </div>
        </div>
      )
    }
    return this.props.children
  }
}

export default ErrorBoundary
"@ | Out-File -FilePath "src/components/ErrorBoundary.jsx" -Encoding UTF8

# Crear src/components/ThemeToggle.jsx
@"
import { useTheme } from '../hooks/useTheme'
import { Sun, Moon } from 'lucide-react'

export const ThemeToggle = () => {
  const { theme, toggleTheme } = useTheme()

  return (
    <button
      onClick={toggleTheme}
      className="p-2 rounded-lg bg-gray-100 dark:bg-gray-800 hover:bg-gray-200 dark:hover:bg-gray-700 transition-colors duration-200"
      aria-label={`Cambiar a modo ${theme === 'dark' ? 'claro' : 'oscuro'}`}
      title={`Cambiar a modo ${theme === 'dark' ? 'claro' : 'oscuro'}`}
    >
      {theme === 'dark' ? (
        <Sun className="w-5 h-5 text-yellow-500" />
      ) : (
        <Moon className="w-5 h-5 text-gray-700" />
      )}
    </button>
  )
}

export default ThemeToggle
"@ | Out-File -FilePath "src/components/ThemeToggle.jsx" -Encoding UTF8

Write-Host "✅ Commit05 aplicado exitosamente!" -ForegroundColor Green
Write-Host "Ahora puedes hacer: git add . && git commit -F tpo-commits/commit05/commit-message.txt" -ForegroundColor Yellow
