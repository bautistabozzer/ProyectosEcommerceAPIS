# Script para limpiar la rama y dejar solo tpo-commits/
Write-Host "🧹 Limpiando rama para dejar solo tpo-commits/..." -ForegroundColor Yellow

# Listar archivos y carpetas a eliminar (excluyendo tpo-commits/)
$itemsToRemove = @(
    "src/",
    "public/",
    "dist/",
    "node_modules/",
    "package.json",
    "package-lock.json",
    "vite.config.js",
    "tailwind.config.js",
    "postcss.config.cjs",
    "eslint.config.mjs",
    "index.html",
    "db.json",
    "README.md",
    "README-JSON-SERVER.md",
    "cleanup-tpo-only.ps1"
)

# Eliminar cada item
foreach ($item in $itemsToRemove) {
    if (Test-Path $item) {
        if (Get-Item $item -ErrorAction SilentlyContinue | Where-Object {$_.PSIsContainer}) {
            Write-Host "📁 Eliminando directorio: $item" -ForegroundColor Red
            Remove-Item -Recurse -Force $item
        } else {
            Write-Host "📄 Eliminando archivo: $item" -ForegroundColor Red
            Remove-Item -Force $item
        }
    }
}

Write-Host "✅ Limpieza completada. Solo queda tpo-commits/" -ForegroundColor Green
Write-Host "📋 Contenido actual:" -ForegroundColor Cyan
Get-ChildItem | Format-Table Name, Mode, Length
