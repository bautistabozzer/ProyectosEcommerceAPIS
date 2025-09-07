# Script para aplicar el commit03 - Servicios API y utilidades
# Ejecutar en PowerShell desde la raíz del repositorio

Write-Host "Aplicando commit03 - Servicios API y utilidades..." -ForegroundColor Green

# Crear directorios necesarios
$directories = @("src/constants", "src/services", "src/hooks", "src/utils")
foreach ($dir in $directories) {
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force
    }
}

# Crear src/constants/index.js
@"
// API Constants
export const API_BASE_URL = "http://localhost:3001";

// User Roles
export const USER_ROLES = {
  USER: "user",
  ADMIN: "admin",
};

// Default User IDs
export const DEFAULT_USER_IDS = {
  ADMIN: 1,
  USER1: 2,
};

// Category IDs
export const CATEGORY_IDS = {
  ELECTRONICS: 1,
  CLOTHING: 2,
  HOME: 3,
  SPORTS: 4,
  BOOKS: 5,
};

// Product Defaults
export const PRODUCT_DEFAULTS = {
  MIN_STOCK: 0,
  MIN_PRICE: 0,
};

// Error Messages
export const ERROR_MESSAGES = {
  INVALID_CREDENTIALS: "Credenciales inválidas",
  EMAIL_EXISTS: "El email ya está registrado",
  USERNAME_EXISTS: "El nombre de usuario ya está en uso",
  PRODUCT_NOT_FOUND: "Producto no encontrado",
  USER_NOT_FOUND: "Usuario no encontrado",
};

// Token Format
export const TOKEN_PREFIX = "token_";
"@ | Out-File -FilePath "src/constants/index.js" -Encoding UTF8

# Crear src/services/api.js
@"
import { ERROR_MESSAGES, TOKEN_PREFIX } from "../constants"

// Base URL for JSON Server
const API_BASE_URL = "http://localhost:3001"

// Helper function to make HTTP requests
const request = async (endpoint, options = {}) => {
  const url = `${API_BASE_URL}${endpoint}`
  const config = {
    headers: {
      'Content-Type': 'application/json',
      ...options.headers,
    },
    ...options,
  }

  try {
    const response = await fetch(url, config)
    
    if (!response.ok) {
      const errorData = await response.json().catch(() => ({}))
      throw new Error(errorData.message || `HTTP error! status: ${response.status}`)
    }
    
    return await response.json()
  } catch (error) {
    if (error.name === 'TypeError' && error.message.includes('fetch')) {
      throw new Error('No se puede conectar con el servidor. Asegúrate de que JSON Server esté ejecutándose.')
    }
    throw error
  }
}

export const api = {
  // Auth endpoints
  async login(email, password) {
    const users = await request('/users')
    const user = users.find((u) => u.email === email && u.password === password)
    if (!user) {
      throw new Error(ERROR_MESSAGES.INVALID_CREDENTIALS)
    }
    const token = `${TOKEN_PREFIX}${user.id}_${Date.now()}`
    return { user: { ...user, password: undefined }, token }
  },
  
  async register(userData) {
    // Check if email already exists
    const users = await request('/users')
    if (users.find((u) => u.email === userData.email)) {
      throw new Error(ERROR_MESSAGES.EMAIL_EXISTS)
    }
    // Check if username already exists
    if (users.find((u) => u.username === userData.username)) {
      throw new Error(ERROR_MESSAGES.USERNAME_EXISTS)
    }
    
    const newUser = {
      ...userData,
      role: "user",
    }
    
    const createdUser = await request('/users', {
      method: 'POST',
      body: JSON.stringify(newUser),
    })
    
    const token = `${TOKEN_PREFIX}${createdUser.id}_${Date.now()}`
    return { user: { ...createdUser, password: undefined }, token }
  },
  
  // Products endpoints
  async getProducts(filters = {}) {
    let endpoint = '/products'
    const queryParams = new URLSearchParams()
    
    if (filters.categoryId) {
      queryParams.append('categoryId', filters.categoryId)
    }
    
    if (filters.search) {
      queryParams.append('q', filters.search)
    }
    
    if (queryParams.toString()) {
      endpoint += `?${queryParams.toString()}`
    }
    
    let products = await request(endpoint)
    
    // JSON Server doesn't have built-in text search, so we filter manually
    if (filters.search) {
      products = products.filter((p) => 
        p.name.toLowerCase().includes(filters.search.toLowerCase()) ||
        p.description.toLowerCase().includes(filters.search.toLowerCase())
      )
    }
    
    // Sort alphabetically
    products.sort((a, b) => a.name.localeCompare(b.name))
    return products
  },
  
  async getProduct(id) {
    try {
      return await request(`/products/${id}`)
    } catch (error) {
      if (error.message.includes('404')) {
        throw new Error(ERROR_MESSAGES.PRODUCT_NOT_FOUND)
      }
      throw error
    }
  },
  
  async createProduct(productData) {
    const newProduct = {
      ...productData,
      createdAt: new Date().toISOString(),
    }
    return await request('/products', {
      method: 'POST',
      body: JSON.stringify(newProduct),
    })
  },
  
  async updateProduct(id, productData) {
    try {
      return await request(`/products/${id}`, {
        method: 'PUT',
        body: JSON.stringify(productData),
      })
    } catch (error) {
      if (error.message.includes('404')) {
        throw new Error(ERROR_MESSAGES.PRODUCT_NOT_FOUND)
      }
      throw error
    }
  },
  
  async deleteProduct(id) {
    try {
      await request(`/products/${id}`, {
        method: 'DELETE',
      })
      return true
    } catch (error) {
      if (error.message.includes('404')) {
        throw new Error(ERROR_MESSAGES.PRODUCT_NOT_FOUND)
      }
      throw error
    }
  },
  
  // Categories endpoints
  async getCategories() {
    return await request('/categories')
  },
  
  // Update product stock (for checkout)
  async updateProductStock(productId, newStock) {
    try {
      const product = await request(`/products/${productId}`)
      return await request(`/products/${productId}`, {
        method: 'PUT',
        body: JSON.stringify({ ...product, stock: newStock }),
      })
    } catch (error) {
      if (error.message.includes('404')) {
        throw new Error(ERROR_MESSAGES.PRODUCT_NOT_FOUND)
      }
      throw error
    }
  },
}
"@ | Out-File -FilePath "src/services/api.js" -Encoding UTF8

# Crear src/hooks/useFetch.js
@"
import { useState, useEffect } from "react"

export const useFetch = (fetchFunction, dependencies = []) => {
  const [data, setData] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState(null)

  useEffect(() => {
    const fetchData = async () => {
      try {
        setLoading(true)
        setError(null)
        const result = await fetchFunction()
        setData(result)
      } catch (err) {
        setError(err.message)
      } finally {
        setLoading(false)
      }
    }
    fetchData()
  }, dependencies)

  const refetch = async () => {
    try {
      setLoading(true)
      setError(null)
      const result = await fetchFunction()
      setData(result)
    } catch (err) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  return { data, loading, error, refetch }
}
"@ | Out-File -FilePath "src/hooks/useFetch.js" -Encoding UTF8

# Crear src/hooks/useTheme.js
@"
import { useState, useEffect } from "react"

export const useTheme = () => {
  const [theme, setTheme] = useState(() => {
    const saved = localStorage.getItem('theme')
    return saved || 'light'
  })

  useEffect(() => {
    const root = document.documentElement
    if (theme === 'dark') {
      root.classList.add('dark')
    } else {
      root.classList.remove('dark')
    }
    localStorage.setItem('theme', theme)
  }, [theme])

  const toggleTheme = () => {
    setTheme(prev => prev === 'light' ? 'dark' : 'light')
  }

  return { theme, toggleTheme }
}
"@ | Out-File -FilePath "src/hooks/useTheme.js" -Encoding UTF8

# Crear src/utils/formatters.js
@"
export const formatPrice = (price) => {
  return new Intl.NumberFormat("es-ES", {
    style: "currency",
    currency: "EUR",
  }).format(price)
}

export const formatDate = (dateString) => {
  return new Intl.DateTimeFormat("es-ES", {
    year: "numeric",
    month: "long",
    day: "numeric",
  }).format(new Date(dateString))
}

export const truncateText = (text, maxLength = 100) => {
  if (text.length <= maxLength) return text
  return text.substring(0, maxLength) + "..."
}
"@ | Out-File -FilePath "src/utils/formatters.js" -Encoding UTF8

# Crear src/utils/validators.js
@"
export const validateEmail = (email) => {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  return emailRegex.test(email)
}

export const validatePassword = (password) => {
  return password && password.length >= 6
}

export const validateRequired = (value) => {
  return value && value.toString().trim().length > 0
}

export const validatePrice = (price) => {
  const numPrice = Number.parseFloat(price)
  return !isNaN(numPrice) && numPrice > 0
}

export const validateStock = (stock) => {
  const numStock = Number.parseInt(stock)
  return !isNaN(numStock) && numStock >= 0
}

export const getValidationErrors = (formData, rules) => {
  const errors = {}
  Object.keys(rules).forEach((field) => {
    const value = formData[field]
    const fieldRules = rules[field]
    fieldRules.forEach((rule) => {
      if (typeof rule === "function") {
        if (!rule(value)) {
          errors[field] = errors[field] || []
          errors[field].push(`${field} es inválido`)
        }
      } else if (rule.validator && !rule.validator(value)) {
        errors[field] = errors[field] || []
        errors[field].push(rule.message)
      }
    })
  })
  return errors
}
"@ | Out-File -FilePath "src/utils/validators.js" -Encoding UTF8

Write-Host "✅ Commit03 aplicado exitosamente!" -ForegroundColor Green
Write-Host "Ahora puedes hacer: git add . && git commit -F tpo-commits/commit03/commit-message.txt" -ForegroundColor Yellow
