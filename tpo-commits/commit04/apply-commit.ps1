# Script para aplicar el commit04 - Contextos de estado
# Ejecutar en PowerShell desde la raíz del repositorio

Write-Host "Aplicando commit04 - Contextos de estado..." -ForegroundColor Green

# Crear directorios necesarios
$directories = @("src/reducers", "src/context")
foreach ($dir in $directories) {
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force
    }
}

# Crear src/reducers/authReducer.js
@"
export const authInitialState = {
  user: null,
  token: null,
  isAuthenticated: false,
  loading: false,
  error: null,
  storageType: null, // 'localStorage' or 'sessionStorage'
}

export const authReducer = (state, action) => {
  switch (action.type) {
    case "AUTH_START":
      return {
        ...state,
        loading: true,
        error: null,
      }
    case "AUTH_SUCCESS":
      return {
        ...state,
        loading: false,
        user: action.payload.user,
        token: action.payload.token,
        isAuthenticated: true,
        error: null,
      }
    case "AUTH_ERROR":
      return {
        ...state,
        loading: false,
        error: action.payload,
        user: null,
        token: null,
        isAuthenticated: false,
      }
    case "AUTH_LOGOUT":
      return {
        ...authInitialState,
      }
    case "AUTH_RESTORE":
      return {
        ...state,
        user: action.payload.user,
        token: action.payload.token,
        isAuthenticated: true,
        storageType: action.payload.storageType,
      }
    default:
      return state
  }
}
"@ | Out-File -FilePath "src/reducers/authReducer.js" -Encoding UTF8

# Crear src/reducers/cartReducer.js
@"
export const cartInitialState = {
  items: [],
  total: 0,
}

export const cartReducer = (state, action) => {
  switch (action.type) {
    case "ADD_TO_CART": {
      const existingItem = state.items.find((item) => item.id === action.payload.id)
      if (existingItem) {
        const updatedItems = state.items.map((item) =>
          item.id === action.payload.id ? { ...item, quantity: item.quantity + 1 } : item,
        )
        return {
          ...state,
          items: updatedItems,
          total: calculateTotal(updatedItems),
        }
      } else {
        const newItems = [...state.items, { ...action.payload, quantity: 1 }]
        return {
          ...state,
          items: newItems,
          total: calculateTotal(newItems),
        }
      }
    }
    case "REMOVE_FROM_CART": {
      const updatedItems = state.items.filter((item) => item.id !== action.payload)
      return {
        ...state,
        items: updatedItems,
        total: calculateTotal(updatedItems),
      }
    }
    case "UPDATE_QUANTITY": {
      const updatedItems = state.items
        .map((item) => (item.id === action.payload.id ? { ...item, quantity: action.payload.quantity } : item))
        .filter((item) => item.quantity > 0)
      return {
        ...state,
        items: updatedItems,
        total: calculateTotal(updatedItems),
      }
    }
    case "CLEAR_CART":
      return cartInitialState
    case "RESTORE_CART":
      return {
        items: action.payload,
        total: calculateTotal(action.payload),
      }
    default:
      return state
  }
}

const calculateTotal = (items) => {
  return items.reduce((total, item) => total + item.price * item.quantity, 0)
}
"@ | Out-File -FilePath "src/reducers/cartReducer.js" -Encoding UTF8

# Crear src/context/AuthContext.jsx
@"
import { createContext, useContext, useReducer, useEffect } from "react"
import { authReducer, authInitialState } from "../reducers/authReducer"
import { api } from "../services/api"

const AuthContext = createContext()

export const useAuth = () => {
  const context = useContext(AuthContext)
  if (!context) {
    throw new Error("useAuth must be used within an AuthProvider")
  }
  return context
}

export const AuthProvider = ({ children }) => {
  const [state, dispatch] = useReducer(authReducer, authInitialState)
  
  // Restore session on app load
  useEffect(() => {
    const restoreSession = () => {
      try {
        // Try localStorage first (remember me), then sessionStorage
        let token = localStorage.getItem("auth_token")
        let user = localStorage.getItem("auth_user")
        let storageType = "localStorage"
        
        // If no localStorage, try sessionStorage
        if (!token || !user) {
          token = sessionStorage.getItem("auth_token")
          user = sessionStorage.getItem("auth_user")
          storageType = "sessionStorage"
        }
        
        if (token && user) {
          try {
            const userData = JSON.parse(user)
            
            // Simple validation - check if user has required fields
            if (userData && userData.id && userData.email) {
              // Create a completely new object with explicit properties
              const userCopy = {
                id: userData.id,
                username: userData.username,
                email: userData.email,
                firstName: userData.firstName,
                lastName: userData.lastName,
                role: userData.role || 'user'
              }
              
              dispatch({
                type: "AUTH_RESTORE",
                payload: {
                  token: token,
                  user: userCopy,
                  storageType: storageType,
                },
              })
            } else {
              clearAllStorage()
            }
          } catch (parseError) {
            clearAllStorage()
          }
        }
      } catch (error) {
        clearAllStorage()
      }
    }
    
    const clearAllStorage = () => {
      localStorage.removeItem("auth_token")
      localStorage.removeItem("auth_user")
      sessionStorage.removeItem("auth_token")
      sessionStorage.removeItem("auth_user")
    }
    
    restoreSession()
  }, [])

  const login = async (email, password, rememberMe = false) => {
    dispatch({ type: "AUTH_START" })
    try {
      const response = await api.login(email, password)
      
      // Choose storage based on rememberMe option
      const storage = rememberMe ? localStorage : sessionStorage
      
      // Save to chosen storage
      storage.setItem("auth_token", response.token)
      storage.setItem("auth_user", JSON.stringify(response.user))
      
      // Clear the other storage to avoid conflicts
      if (rememberMe) {
        sessionStorage.removeItem("auth_token")
        sessionStorage.removeItem("auth_user")
      } else {
        localStorage.removeItem("auth_token")
        localStorage.removeItem("auth_user")
      }
      
      dispatch({
        type: "AUTH_SUCCESS",
        payload: response,
      })
      return response
    } catch (error) {
      dispatch({
        type: "AUTH_ERROR",
        payload: error.message,
      })
      throw error
    }
  }

  const register = async (userData, rememberMe = false) => {
    dispatch({ type: "AUTH_START" })
    try {
      const response = await api.register(userData)
      
      // Choose storage based on rememberMe option
      const storage = rememberMe ? localStorage : sessionStorage
      
      // Save to chosen storage
      storage.setItem("auth_token", response.token)
      storage.setItem("auth_user", JSON.stringify(response.user))
      
      // Clear the other storage to avoid conflicts
      if (rememberMe) {
        sessionStorage.removeItem("auth_token")
        sessionStorage.removeItem("auth_user")
      } else {
        localStorage.removeItem("auth_token")
        localStorage.removeItem("auth_user")
      }
      
      dispatch({
        type: "AUTH_SUCCESS",
        payload: response,
      })
      return response
    } catch (error) {
      dispatch({
        type: "AUTH_ERROR",
        payload: error.message,
      })
      throw error
    }
  }

  const logout = () => {
    // Clear both storages to ensure complete logout
    localStorage.removeItem("auth_token")
    localStorage.removeItem("auth_user")
    sessionStorage.removeItem("auth_token")
    sessionStorage.removeItem("auth_user")
    dispatch({ type: "AUTH_LOGOUT" })
  }

  const value = {
    ...state,
    login,
    register,
    logout,
  }

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>
}
"@ | Out-File -FilePath "src/context/AuthContext.jsx" -Encoding UTF8

# Crear src/context/CartContext.jsx
@"
import { createContext, useContext, useReducer, useEffect } from "react"
import { cartReducer, cartInitialState } from "../reducers/cartReducer"

const CartContext = createContext()

export const useCart = () => {
  const context = useContext(CartContext)
  if (!context) {
    throw new Error("useCart must be used within a CartProvider")
  }
  return context
}

export const CartProvider = ({ children }) => {
  const [state, dispatch] = useReducer(cartReducer, cartInitialState)

  // Restore cart from localStorage on app load
  useEffect(() => {
    const savedCart = localStorage.getItem("cart_items")
    if (savedCart) {
      dispatch({
        type: "RESTORE_CART",
        payload: JSON.parse(savedCart),
      })
    }
  }, [])

  // Save cart to localStorage whenever it changes
  useEffect(() => {
    localStorage.setItem("cart_items", JSON.stringify(state.items))
  }, [state.items])

  const addToCart = (product) => {
    dispatch({
      type: "ADD_TO_CART",
      payload: product,
    })
  }

  const removeFromCart = (productId) => {
    dispatch({
      type: "REMOVE_FROM_CART",
      payload: productId,
    })
  }

  const updateQuantity = (productId, quantity) => {
    dispatch({
      type: "UPDATE_QUANTITY",
      payload: { id: productId, quantity },
    })
  }

  const clearCart = () => {
    dispatch({ type: "CLEAR_CART" })
  }

  const getCartItemsCount = () => {
    return state.items.reduce((total, item) => total + item.quantity, 0)
  }

  const value = {
    ...state,
    addToCart,
    removeFromCart,
    updateQuantity,
    clearCart,
    getCartItemsCount,
  }

  return <CartContext.Provider value={value}>{children}</CartContext.Provider>
}
"@ | Out-File -FilePath "src/context/CartContext.jsx" -Encoding UTF8

# Crear src/context/ToastContext.jsx
@"
import { createContext, useContext, useState } from "react"

const ToastContext = createContext()

export const useToast = () => {
  const context = useContext(ToastContext)
  if (!context) {
    throw new Error("useToast must be used within a ToastProvider")
  }
  return context
}

export const ToastProvider = ({ children }) => {
  const [toasts, setToasts] = useState([])

  const addToast = (message, type = "info") => {
    const id = Date.now()
    const toast = { id, message, type }
    setToasts((prev) => [...prev, toast])
    // Auto remove after 3 seconds
    setTimeout(() => {
      removeToast(id)
    }, 3000)
  }

  const removeToast = (id) => {
    setToasts((prev) => prev.filter((toast) => toast.id !== id))
  }

  const value = {
    toasts,
    addToast,
    removeToast,
    success: (message) => addToast(message, "success"),
    error: (message) => addToast(message, "error"),
    info: (message) => addToast(message, "info"),
  }

  return (
    <ToastContext.Provider value={value}>
      {children}
      <ToastContainer toasts={toasts} onRemove={removeToast} />
    </ToastContext.Provider>
  )
}

const ToastContainer = ({ toasts, onRemove }) => {
  if (toasts.length === 0) return null

  return (
    <div className="fixed top-4 right-4 z-50 space-y-2">
      {toasts.map((toast) => (
        <div key={toast.id} className={`toast toast-${toast.type} flex items-center justify-between min-w-80`}>
          <span>{toast.message}</span>
          <button onClick={() => onRemove(toast.id)} className="ml-4 text-lg font-bold opacity-70 hover:opacity-100">
            ×
          </button>
        </div>
      ))}
    </div>
  )
}
"@ | Out-File -FilePath "src/context/ToastContext.jsx" -Encoding UTF8

Write-Host "✅ Commit04 aplicado exitosamente!" -ForegroundColor Green
Write-Host "Ahora puedes hacer: git add . && git commit -F tpo-commits/commit04/commit-message.txt" -ForegroundColor Yellow
