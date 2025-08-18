import { useState, useEffect } from "react"
import { api } from "../services/api"
import { useFetch } from "../hooks/useFetch"
import ProductCard from "../components/ProductCard"
import CategoryPill from "../components/CategoryPill"
import LoadingSpinner from "../components/LoadingSpinner"
import EmptyState from "../components/EmptyState"
import SkeletonLoader from "../components/SkeletonLoader"
import { Search, Package } from "lucide-react"
const Home = () => {
  const [searchTerm, setSearchTerm] = useState("")
  const [selectedCategory, setSelectedCategory] = useState(null)
  const [filteredProducts, setFilteredProducts] = useState([])
  // Fetch products and categories
  const {
    data: products,
    loading: productsLoading,
    error: productsError,
    refetch: refetchProducts,
  } = useFetch(
    () => api.getProducts({ search: searchTerm, categoryId: selectedCategory }),
    [searchTerm, selectedCategory],
  )
  const {
    data: categories,
    loading: categoriesLoading,
    error: categoriesError,
  } = useFetch(() => api.getCategories(), [])
  useEffect(() => {
    if (products) {
      setFilteredProducts(products)
    }
  }, [products])
  const handleSearch = (e) => {
    setSearchTerm(e.target.value)
  }
  const handleCategorySelect = (categoryId) => {
    setSelectedCategory(categoryId === selectedCategory ? null : categoryId)
  }
  const clearFilters = () => {
    setSearchTerm("")
    setSelectedCategory(null)
  }
  if (productsLoading && !products) {
    return (
      <div className="space-y-8">
        <div>
          <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">Catálogo de Productos</h1>
          <p className="text-gray-600 dark:text-gray-300">Descubre nuestros productos organizados por categorías</p>
        </div>
        <div className="relative max-w-md">
          <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
            <Search className="h-5 w-5 text-gray-400" />
          </div>
          <input
            type="text"
            placeholder="Buscar productos..."
            className="input pl-10"
            value={searchTerm}
            onChange={handleSearch}
            disabled
          />
        </div>
        <div className="grid grid-cols-1 lg:grid-cols-4 gap-8">
          <div className="lg:col-span-1">
            <div className="card p-6">
              <div className="h-6 bg-gray-200 rounded w-1/2 mb-4 animate-pulse"></div>
              <div className="space-y-2">
                {[...Array(5)].map((_, i) => (
                  <div key={i} className="h-8 bg-gray-200 rounded animate-pulse"></div>
                ))}
              </div>
            </div>
          </div>
          <div className="lg:col-span-3">
            <SkeletonLoader type="card" count={6} />
          </div>
        </div>
      </div>
    )
  }
  if (productsError) {
    return (
      <div className="text-center py-12">
        <p className="text-red-600 mb-4">Error al cargar los productos: {productsError}</p>
        <button onClick={refetchProducts} className="btn btn-primary">
          Reintentar
        </button>
      </div>
    )
  }
  return (
    <div className="space-y-8">
      {/* Header */}
      <div>
        <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">Catálogo de Productos</h1>
        <p className="text-gray-600 dark:text-gray-300">Descubre nuestros productos organizados por categorías</p>
      </div>
      {/* Search Bar */}
      <div className="relative max-w-md">
        <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
          <Search className="h-5 w-5 text-gray-400" />
        </div>
        <input
          type="text"
          placeholder="Buscar productos..."
          className="input pl-10"
          value={searchTerm}
          onChange={handleSearch}
        />
      </div>
      <div className="grid grid-cols-1 lg:grid-cols-4 gap-8">
        {/* Categories Sidebar */}
        <div className="lg:col-span-1">
          <div className="card p-6">
            <h2 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">Categorías</h2>
            {categoriesLoading ? (
              <div className="flex justify-center py-4">
                <LoadingSpinner size="sm" />
              </div>
            ) : categoriesError ? (
              <p className="text-red-600 dark:text-red-400 text-sm">Error al cargar categorías</p>
            ) : (
              <div className="space-y-2">
                <button
                  onClick={clearFilters}
                  className={`w-full text-left px-3 py-2 rounded-md text-sm transition-colors ${
                    !selectedCategory 
                      ? "bg-blue-100 dark:bg-blue-900 text-blue-800 dark:text-blue-200 font-medium" 
                      : "text-gray-700 dark:text-gray-300 hover:bg-gray-100 dark:hover:bg-gray-700"
                  }`}
                >
                  Todas las categorías
                </button>
                {categories?.map((category) => (
                  <CategoryPill
                    key={category.id}
                    category={category}
                    isSelected={selectedCategory === category.id}
                    onClick={() => handleCategorySelect(category.id)}
                  />
                ))}
              </div>
            )}
            {/* Active filters */}
            {(searchTerm || selectedCategory) && (
              <div className="mt-6 pt-4 border-t border-gray-200 dark:border-gray-600">
                <h3 className="text-sm font-medium text-gray-900 dark:text-white mb-2">Filtros activos:</h3>
                <div className="space-y-1">
                  {searchTerm && (
                    <div className="flex items-center justify-between text-sm">
                      <span className="text-gray-600 dark:text-gray-300">Búsqueda: "{searchTerm}"</span>
                      <button onClick={() => setSearchTerm("")} className="text-red-600 dark:text-red-400 hover:text-red-800 dark:hover:text-red-300">
                        ×
                      </button>
                    </div>
                  )}
                  {selectedCategory && (
                    <div className="flex items-center justify-between text-sm">
                      <span className="text-gray-600 dark:text-gray-300">
                        Categoría: {categories?.find((c) => c.id === selectedCategory)?.name}
                      </span>
                      <button onClick={() => setSelectedCategory(null)} className="text-red-600 dark:text-red-400 hover:text-red-800 dark:hover:text-red-300">
                        ×
                      </button>
                    </div>
                  )}
                </div>
                <button onClick={clearFilters} className="mt-2 text-sm text-blue-600 dark:text-blue-400 hover:text-blue-800 dark:hover:text-blue-300">
                  Limpiar todos los filtros
                </button>
              </div>
            )}
          </div>
        </div>
        {/* Products Grid */}
        <div className="lg:col-span-3">
          {productsLoading ? (
            <div className="flex justify-center py-12">
              <LoadingSpinner size="lg" />
            </div>
          ) : filteredProducts?.length === 0 ? (
            <EmptyState
              icon={Package}
              title="No se encontraron productos"
              description={
                searchTerm || selectedCategory
                  ? "Intenta ajustar tus filtros de búsqueda"
                  : "No hay productos disponibles en este momento"
              }
              action={
                (searchTerm || selectedCategory) && (
                  <button onClick={clearFilters} className="btn btn-primary">
                    Limpiar filtros
                  </button>
                )
              }
            />
          ) : (
            <>
              {/* Results count */}
              <div className="mb-6">
                <p className="text-sm text-gray-600 dark:text-gray-300">
                  {filteredProducts?.length} producto{filteredProducts?.length !== 1 ? "s" : ""} encontrado
                  {filteredProducts?.length !== 1 ? "s" : ""}
                  {searchTerm && ` para "${searchTerm}"`}
                  {selectedCategory && ` en ${categories?.find((c) => c.id === selectedCategory)?.name}`}
                </p>
              </div>
              {/* Products grid */}
              <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-6">
                {filteredProducts?.map((product) => (
                  <ProductCard key={product.id} product={product} />
                ))}
              </div>
            </>
          )}
        </div>
      </div>
    </div>
  )
}
export default Home
