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
    const token = sessionStorage.getItem("auth_token")
    const user = sessionStorage.getItem("auth_user")
    if (token && user) {
      dispatch({
        type: "AUTH_RESTORE",
        payload: {
          token,
          user: JSON.parse(user),
        },
      })
    }
  }, [])
  const login = async (email, password) => {
    dispatch({ type: "AUTH_START" })
    try {
      const response = await api.login(email, password)
      // Save to sessionStorage
      sessionStorage.setItem("auth_token", response.token)
      sessionStorage.setItem("auth_user", JSON.stringify(response.user))
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
  const register = async (userData) => {
    dispatch({ type: "AUTH_START" })
    try {
      const response = await api.register(userData)
      // Save to sessionStorage
      sessionStorage.setItem("auth_token", response.token)
      sessionStorage.setItem("auth_user", JSON.stringify(response.user))
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
