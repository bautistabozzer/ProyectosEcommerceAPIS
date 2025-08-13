const CategoryPill = ({ category, isSelected, onClick }) => {
  return (
    <button
      onClick={onClick}
      className={`w-full text-left px-3 py-2 rounded-md text-sm transition-colors ${
        isSelected ? "bg-blue-100 text-blue-800 font-medium" : "text-gray-700 hover:bg-gray-100"
      }`}
    >
      {category.name}
    </button>
  )
}
export default CategoryPill
