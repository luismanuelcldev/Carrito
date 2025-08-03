# 🛒 App Carrito de Compras Flutter 

## Objetivo de la aplicacion:
Desarrollar una aplicación móvil multiplataforma utilizando Flutter para la gestión eficiente de un carrito de compras virtual. La aplicación permite a los usuarios explorar productos de hogar, agregar artículos al carrito, gestionar cantidades y realizar compras con una interfaz intuitiva y moderna.

> [!NOTE]
> Proyecto desarrollado con Flutter 3.7.2+ y arquitectura BLoC para gestión de estado reactivo

## Funcionalidades Principales:

- **Catálogo de Productos:** Exploración de productos para el hogar con información detallada (nombre, descripción, precio, imagen, stock, categoría).

- **Carrito de Compras Inteligente:** Agregado automático de productos con validación de stock, gestión de cantidades y actualización en tiempo real.

- **Gestión de Inventario:** Control automático de stock disponible con validaciones para evitar sobreventa.

- **Persistencia de Datos:** Almacenamiento local del carrito de compras usando SharedPreferences para mantener el estado entre sesiones.

- **Integración API Múltiple:** Sincronización con JSONPlaceholder y FakeStoreAPI para obtener productos combinados con datos localizados al español.

- **Interfaz Adaptativa:** Diseño responsive con Material Design para una experiencia visual consistente.

- **Navegación Declarativa:** Enrutamiento moderno con GoRouter para transiciones fluidas entre pantallas.

- **Gestión de Estado Reactiva:** Implementación robusta del patrón BLoC para manejo eficiente del estado de la aplicación.

- **Multiplataforma:** Compatibilidad completa con Android, iOS, Web, Windows, macOS y Linux.

- **Validaciones en Tiempo Real:** Control de stock y cantidades con retroalimentación inmediata al usuario.

## Desarrollador:

- [Luis Manuel De La Cruz Ledesma - Desarrollador](https://github.com/luismanuelcldev)

## Enlaces:

**Repositorio:** [GitHub Repository - Carrito](https://github.com/luismanuelcldev/Carrito)

## Capturas de Pantalla

>[!NOTE]
>Aquí se muestra un listado de todas las pantallas desarrolladas.

| Pantalla Principal (Home) | Listado de Productos |
|-----------|-----------|
| ![Home]() | ![Productos]() |

| Detalle de Producto | Carrito de Compras |
|-----------|-----------|
| ![Detalle]() | ![Carrito]() |

## Arquitectura Técnica

### Stack Tecnológico
- **Framework:** Flutter 3.7.2+
- **Lenguaje:** Dart ^3.7.2
- **Arquitectura:** BLoC Pattern (flutter_bloc ^9.1.1)
- **Navegación:** GoRouter ^15.1.2
- **HTTP Client:** Dio ^5.8.0+1
- **Persistencia:** SharedPreferences ^2.5.3
- **Icons:** Cupertino Icons ^1.0.8

### Estructura del Proyecto
```
lib/
├── app/                    # Configuración de la aplicación
│   ├── app.dart           # Widget principal de la aplicación
│   └── router.dart        # Configuración de rutas
├── Controllers/           # Gestión de estado (BLoC/Cubit)
│   ├── carrito_cubit.dart # Lógica del carrito de compras
│   ├── carrito_state.dart # Estados del carrito
│   ├── productos_cubit.dart # Lógica de productos
│   └── productos_state.dart # Estados de productos
├── models/                # Modelos de datos
│   └── producto.dart      # Modelo de producto
├── repositories/          # Capa de datos
│   └── producto_repository.dart # Repositorio de productos
├── views/                 # Interfaces de usuario
│   ├── home_view.dart     # Pantalla principal
│   ├── productos_view.dart # Lista de productos
│   ├── detalle_producto_view.dart # Detalle del producto
│   └── carrito_view.dart  # Carrito de compras
├── widgets/               # Componentes reutilizables
│   ├── producto_item.dart # Item de producto
│   └── carrito_button.dart # Botón del carrito
└── main.dart              # Punto de entrada
```

## Inicialización del Proyecto Flutter

Este archivo describe los pasos necesarios para inicializar el proyecto Flutter después de clonarlo o descargarlo.

### Requisitos Previos

- [Flutter](https://flutter.dev/docs/get-started/install) debe estar instalado en tu equipo (versión 3.7.2 o superior).
- Asegurate de tener todas las dependencias necesarias instaladas. Puedes ejecutar el siguiente comando:

  ```bash
  flutter doctor
  ```
  Asegurate de solucionar cualquier problema identificado por flutter doctor antes de continuar.

### Pasos de Inicialización

**Descargar el Proyecto:**
Clona el repositorio o descarga el proyecto desde GitHub.

```bash
git clone https://github.com/luismanuelcldev/Carrito.git
cd carritocompras
```

### Limpiar el Proyecto:
Ejecuta el siguiente comando para limpiar el proyecto.
```bash
flutter clean
```

### Obtener Dependencias:
Ejecuta el siguiente comando para obtener todas las dependencias del proyecto.
```bash
flutter pub get
```
Esto descargará todas las dependencias definidas en el archivo **pubspec.yaml.**

### Configuración Adicional (En caso de ser necesario):
Realiza cualquier configuración adicional necesaria según las instrucciones del proyecto.

## Ejecutar la Aplicación
Una vez completados los pasos anteriores, puedes ejecutar la aplicación Flutter con el siguiente comando que proporcionare:

```bash
# Para Web (recomendado)
flutter run -d chrome

# Para Android
flutter run -d android

# Para Windows
flutter run -d windows

# Para iOS (solo en macOS)
flutter run -d ios
```

Esto iniciará la aplicación en el emulador, dispositivo conectado o navegador web.

## Características Técnicas Implementadas

### Gestión de Estado con BLoC
- **Patrón BLoC/Cubit:** Implementación robusta para manejo de estado reactivo
- **Estado Inmutable:** Uso de copyWith para actualizaciones seguras
- **Separación de Responsabilidades:** Cubit separado de la UI
- **Manejo de Eventos:** Emisión de estados específicos para cada acción

### Persistencia de Datos
- **Almacenamiento Local:** SharedPreferences para persistir el carrito
- **Serialización JSON:** Modelos con toJson() y fromJson()
- **Gestión Automática:** Carga y guardado automático del carrito

### Integración con APIs Externas
- **Múltiples Fuentes:** Combinación de JSONPlaceholder y FakeStoreAPI
- **Localización:** Traducción automática de contenido al español
- **Manejo de Errores:** Try-catch robusto con mensajes informativos
- **Timeout Configuration:** Configuración de timeouts para requests HTTP

### Funcionalidades del Carrito
- **Validación de Stock:** Control automático de inventario disponible
- **Gestión de Cantidades:** Incremento/decremento con límites dinámicos
- **Eliminación Intuitiva:** Swipe-to-delete con confirmación
- **Cálculo Automático:** Total y subtotales en tiempo real

### Navegación y UX
- **Enrutamiento Declarativo:** GoRouter para navegación type-safe
- **Parámetros Dinámicos:** Paso de objetos entre pantallas
- **Feedback Visual:** SnackBars y diálogos de confirmación
- **Responsive Design:** Adaptación a diferentes tamaños de pantalla

## Modelos de Datos

### Producto
```dart
class Producto {
  final String id;
  final String nombre;
  final String descripcion;
  final double precio;
  final String imagenUrl;
  final int stock;
  final String categoria;
}
```

### ItemCarrito
```dart
class ItemCarrito {
  final Producto producto;
  final int cantidad;
  
  double get total => producto.precio * cantidad;
}
```

## Estados de la Aplicación

### Estados del Carrito
- **CarritoState:** Estado principal con lista de items y métodos de cálculo
- **Items Management:** Agregado, eliminación y modificación de productos
- **Persistent Storage:** Guardado automático en SharedPreferences

### Estados de Productos
- **ProductosInitial:** Estado inicial
- **ProductosLoading:** Cargando productos desde APIs
- **ProductosLoaded:** Productos cargados exitosamente
- **ProductosError:** Error en la carga con mensaje descriptivo

## Repositorio de Datos

### ProductoRepository
- **APIs Integradas:** JSONPlaceholder y FakeStoreAPI
- **Datos Localizados:** Nombres y descripciones en español
- **Imágenes Curadas:** URLs específicas de Picsum para cada categoría
- **Manejo de Errores:** Exception handling robusto
- **Combinación Inteligente:** Merge de múltiples fuentes de datos

## Funcionalidades por Pantalla

### HomeView
- ✅ Pantalla de bienvenida con branding
- ✅ Navegación directa al catálogo
- ✅ Interfaz minimalista y clara

### ProductosView
- ✅ Lista scrollable de productos
- ✅ Información clave visible (nombre, precio, imagen)
- ✅ Acceso rápido al carrito
- ✅ Navegación al detalle de producto

### DetalleProductoView
- ✅ Información completa del producto
- ✅ Selector de cantidad con validación de stock
- ✅ Agregado al carrito con feedback visual
- ✅ Manejo de stock agotado

### CarritoView
- ✅ Lista de productos agregados
- ✅ Modificación de cantidades
- ✅ Eliminación por swipe con deshacer
- ✅ Cálculo automático de totales
- ✅ Vaciado completo del carrito
- ✅ Persistencia entre sesiones

## Validaciones Implementadas

### Control de Inventario
- ✅ Verificación de stock disponible
- ✅ Límites dinámicos en selectores de cantidad
- ✅ Prevención de agregado si stock insuficiente

### Experiencia de Usuario
- ✅ Feedback inmediato en todas las acciones
- ✅ Confirmaciones para acciones destructivas
- ✅ Estados de carga con indicadores visuales
- ✅ Manejo graceful de errores de conexión

### Persistencia de Datos
- ✅ Guardado automático del carrito
- ✅ Carga automática al iniciar la app
- ✅ Sincronización entre sesiones

---

## Configuración Técnica

### Dependencies (pubspec.yaml)
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  flutter_bloc: ^9.1.1        # Gestión de estado
  go_router: ^15.1.2          # Navegación
  shared_preferences: ^2.5.3  # Persistencia local
  dio: ^5.8.0+1               # Cliente HTTP
```

### Configuración de Dio
```dart
final dio = Dio(
  BaseOptions(
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  ),
);
```

### MultiBlocProvider Setup
```dart
MultiBlocProvider(
  providers: [
    BlocProvider(create: (context) => CarritoCubit(prefs)..cargarCarrito()),
    BlocProvider(create: (context) => ProductosCubit(repository)..cargarProductos()),
  ],
  child: const AppHogar(),
)
```

---


