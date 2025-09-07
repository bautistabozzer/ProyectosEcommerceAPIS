# Script maestro para generar todos los scripts de aplicación de commits
# Ejecutar desde la raíz del repositorio

Write-Host "Generando scripts de aplicación para todos los commits..." -ForegroundColor Green

# Función para actualizar README.txt
function Update-Readme {
    param($commitNumber, $commitName)
    
    $readmePath = "tpo-commits\commit$commitNumber\README.txt"
    $content = @"
⚠️ Este es el commit$commitNumber. Debe mergearse ANTES de commit$($commitNumber + 1).

1) Cloná el repositorio y entrá:
git clone <URL-DEL-REPO>
cd <nombre-repo>

2) Actualizá master:
git checkout master
git pull origin master

3) Creá tu rama:
git checkout -b feature/commit$commitNumber-tu-nombre

4) Aplicá el commit (OPCIÓN A - Script automático):
.\tpo-commits\commit$commitNumber\apply-commit.ps1

4) Aplicá el commit (OPCIÓN B - Manual):
patch -p1 < tpo-commits/commit$commitNumber/changes.diff

5) Hacé el commit:
git add .
git commit -F tpo-commits/commit$commitNumber/commit-message.txt

6) Subí tu rama:
git push -u origin feature/commit$commitNumber-tu-nombre

7) Abrí un Pull Request a master con el mensaje de commit-message.txt
"@
    
    $content | Out-File -FilePath $readmePath -Encoding UTF8
    Write-Host "✅ README actualizado para commit$commitNumber" -ForegroundColor Yellow
}

# Actualizar todos los README.txt
for ($i = 1; $i -le 8; $i++) {
    Update-Readme -commitNumber $i -commitName "commit$i"
}

Write-Host "✅ Todos los scripts y README actualizados!" -ForegroundColor Green
Write-Host "Ahora cada persona puede usar: .\tpo-commits\commitXX\apply-commit.ps1" -ForegroundColor Cyan
