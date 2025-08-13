import { getData, saveData } from "../mocks/db"
import { API_DELAY, ERROR_MESSAGES, TOKEN_PREFIX } from "../constants"

// Simulate network delay
const delay = (ms = API_DELAY) => new Promise((resolve) => setTimeout(resolve, ms))
// Simulate API responses
export const api = {
  // Auth endpoints
  async login(email, password) {
    await delay()
    const data = getData()
    const user = data.users.find((u) => u.email === email && u.password === password)
    if (!user) {
      throw new Error(ERROR_MESSAGES.INVALID_CREDENTIALS)
    }
    const token = `${TOKEN_PREFIX}${user.id}_${Date.now()}`
    return { user: { ...user, password: undefined }, token }
  },
  async register(userData) {
    await delay()
    const data = getData()
    // Check if email already exists
    if (data.users.find((u) => u.email === userData.email)) {
      throw new Error(ERROR_MESSAGES.EMAIL_EXISTS)
    }
    // Check if username already exists
    if (data.users.find((u) => u.username === userData.username)) {
      throw new Error(ERROR_MESSAGES.USERNAME_EXISTS)
    }
    const newUser = {
      id: Math.max(...data.users.map((u) => u.id)) + 1,
      ...userData,
      role: "user",
    }
    data.users.push(newUser)
    saveData(data)
    const token = `${TOKEN_PREFIX}${newUser.id}_${Date.now()}`
    return { user: { ...newUser, password: undefined }, token }
  },
  // Products endpoints
  async getProducts(filters = {}) {
    await delay()
    const data = getData()
    let products = [...data.products]
    // Filter by category
    if (filters.categoryId) {
      products = products.filter((p) => p.categoryId === Number.parseInt(filters.categoryId))
    }
    // Search by name
    if (filters.search) {
      products = products.filter((p) => p.name.toLowerCase().includes(filters.search.toLowerCase()))
    }
    // Sort alphabetically
    products.sort((a, b) => a.name.localeCompare(b.name))
    return products
  },
  async getProduct(id) {
    await delay()
    const data = getData()
    const product = data.products.find((p) => p.id === Number.parseInt(id))
    if (!product) {
      throw new Error(ERROR_MESSAGES.PRODUCT_NOT_FOUND)
    }
    return product
  },
  async createProduct(productData) {
    await delay()
    const data = getData()
    const newProduct = {
      id: Math.max(...data.products.map((p) => p.id)) + 1,
      ...productData,
      createdAt: new Date().toISOString(),
    }
    data.products.push(newProduct)
    saveData(data)
    return newProduct
  },
  async updateProduct(id, productData) {
    await delay()
    const data = getData()
    const index = data.products.findIndex((p) => p.id === Number.parseInt(id))
    if (index === -1) {
      throw new Error(ERROR_MESSAGES.PRODUCT_NOT_FOUND)
    }
    data.products[index] = { ...data.products[index], ...productData }
    saveData(data)
    return data.products[index]
  },
  async deleteProduct(id) {
    await delay()
    const data = getData()
    const index = data.products.findIndex((p) => p.id === Number.parseInt(id))
    if (index === -1) {
      throw new Error(ERROR_MESSAGES.PRODUCT_NOT_FOUND)
    }
    data.products.splice(index, 1)
    saveData(data)
    return true
  },
  // Categories endpoints
  async getCategories() {
    await delay()
    const data = getData()
    return data.categories
  },
  // Update product stock (for checkout)
  async updateProductStock(productId, newStock) {
    await delay()
    const data = getData()
    const product = data.products.find((p) => p.id === Number.parseInt(productId))
    if (!product) {
      throw new Error(ERROR_MESSAGES.PRODUCT_NOT_FOUND)
    }
    product.stock = newStock
    saveData(data)
    return product
  },
}
