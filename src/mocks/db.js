import { DEFAULT_USER_IDS, USER_ROLES, STORAGE_KEY } from "../constants"

const initialData = {
  users: [
    {
      id: DEFAULT_USER_IDS.ADMIN,
      username: "admin",
      email: "admin@test.com",
      password: "admin123",
      firstName: "Admin",
      lastName: "User",
      role: USER_ROLES.USER,
    },
    {
      id: DEFAULT_USER_IDS.USER1,
      username: "user1",
      email: "user1@test.com",
      password: "user123",
      firstName: "Juan",
      lastName: "Pérez",
      role: USER_ROLES.USER,
    },
  ],
  categories: [
    { id: 1, name: "Electrónicos" },
    { id: 2, name: "Ropa" },
    { id: 3, name: "Hogar" },
    { id: 4, name: "Deportes" },
    { id: 5, name: "Libros" },
  ],
  products: [
    {
      id: 1,
      name: "iPhone 15",
      description: "El último iPhone con tecnología avanzada",
      price: 999.99,
      stock: 10,
      images: ["/iphone-15-hands.png"],
      categoryId: 1,
      ownerUserId: 1,
      createdAt: new Date().toISOString(),
    },
    {
      id: 2,
      name: "Camiseta Nike",
      description: "Camiseta deportiva de alta calidad",
      price: 49.99,
      stock: 25,
      images: ["/placeholder-3vo7e.png"],
      categoryId: 2,
      ownerUserId: 1,
      createdAt: new Date().toISOString(),
    },
    {
      id: 3,
      name: "Lámpara LED",
      description: "Lámpara LED moderna para el hogar",
      price: 79.99,
      stock: 0,
      images: ["/led-lamp.png"],
      categoryId: 3,
      ownerUserId: 2,
      createdAt: new Date().toISOString(),
    },
    {
      id: 4,
      name: "Balón de Fútbol",
      description: "Balón oficial de fútbol profesional",
      price: 29.99,
      stock: 15,
      images: ["/classic-soccer-ball.png"],
      categoryId: 4,
      ownerUserId: 1,
      createdAt: new Date().toISOString(),
    },
    {
      id: 5,
      name: "El Quijote",
      description: "Clásico de la literatura española",
      price: 19.99,
      stock: 8,
      images: ["/don-quixote-book.png"],
      categoryId: 5,
      ownerUserId: 2,
      createdAt: new Date().toISOString(),
    },
  ],
}
// Load data from localStorage or use initial data
export const loadData = () => {
  const stored = localStorage.getItem(STORAGE_KEY)
  if (stored) {
    return JSON.parse(stored)
  }
  saveData(initialData)
  return initialData
}
// Save data to localStorage
export const saveData = (data) => {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(data))
}
// Get current data
export const getData = () => loadData()
