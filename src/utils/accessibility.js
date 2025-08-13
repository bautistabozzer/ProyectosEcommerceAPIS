export const announceToScreenReader = (message) => {
  const announcement = document.createElement("div")
  announcement.setAttribute("aria-live", "polite")
  announcement.setAttribute("aria-atomic", "true")
  announcement.setAttribute("class", "sr-only")
  announcement.textContent = message
  document.body.appendChild(announcement)
  setTimeout(() => {
    document.body.removeChild(announcement)
  }, 1000)
}
export const trapFocus = (element) => {
  const focusableElements = element.querySelectorAll(
    'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])',
  )
  const firstElement = focusableElements[0]
  const lastElement = focusableElements[focusableElements.length - 1]
  const handleTabKey = (e) => {
    if (e.key === "Tab") {
      if (e.shiftKey) {
        if (document.activeElement === firstElement) {
          lastElement.focus()
          e.preventDefault()
        }
      } else {
        if (document.activeElement === lastElement) {
          firstElement.focus()
          e.preventDefault()
        }
      }
    }
    if (e.key === "Escape") {
      element.querySelector("[data-close]")?.click()
    }
  }
  element.addEventListener("keydown", handleTabKey)
  firstElement?.focus()
  return () => {
    element.removeEventListener("keydown", handleTabKey)
  }
}
export const getAriaLabel = (action, item) => {
  const labels = {
    edit: `Editar ${item}`,
    delete: `Eliminar ${item}`,
    view: `Ver detalles de ${item}`,
    add: `Agregar ${item} al carrito`,
    remove: `Eliminar ${item} del carrito`,
    increase: `Aumentar cantidad de ${item}`,
    decrease: `Disminuir cantidad de ${item}`,
  }
  return labels[action] || `${action} ${item}`
}
