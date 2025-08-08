#!/bin/bash

# Script para ejecutar todos los tests del proyecto Flutter Base

echo "🧪 Ejecutando tests de Flutter Base..."
echo "=================================="

# Limpiar builds previos
echo "🧹 Limpiando builds previos..."
flutter clean
flutter pub get

echo ""
echo "📋 Tests disponibles:"
echo "1. Tests unitarios"
echo "2. Tests de widgets"
echo "3. Tests de integración (simulados)"
echo "4. Todos los tests"
echo ""

# Función para ejecutar tests unitarios
run_unit_tests() {
    echo "🔬 Ejecutando tests unitarios..."
    flutter test test/unit/ --reporter=expanded
}

# Función para ejecutar tests de widgets
run_widget_tests() {
    echo "🎨 Ejecutando tests de widgets..."
    flutter test test/widget/ --reporter=expanded
}

# Función para ejecutar tests de integración
run_integration_tests() {
    echo "🌐 Ejecutando tests de integración..."
    flutter test test/integration/ --reporter=expanded
}

# Función para ejecutar todos los tests
run_all_tests() {
    echo "🚀 Ejecutando todos los tests..."
    flutter test --reporter=expanded
}

# Si no se proporciona argumento, preguntar al usuario
if [ $# -eq 0 ]; then
    echo "Selecciona una opción (1-4):"
    read -r choice
else
    choice=$1
fi

case $choice in
    1)
        run_unit_tests
        ;;
    2)
        run_widget_tests
        ;;
    3)
        run_integration_tests
        ;;
    4)
        run_all_tests
        ;;
    *)
        echo "❌ Opción inválida. Usa 1, 2, 3 o 4"
        exit 1
        ;;
esac

echo ""
echo "✅ Tests completados!"
