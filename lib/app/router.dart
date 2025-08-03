import 'package:examen1/models/producto.dart';

import 'package:go_router/go_router.dart';

import '../views/home_view.dart';

import '../views/productos_view.dart';
import '../views/detalle_producto_view.dart';
import '../views/carrito_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',

      builder: (context, state) => const HomeView(),

      routes: [
        GoRoute(
          path: 'productos',

          builder: (context, state) => ProductosView(),
        ),

        GoRoute(
          path: 'producto/:id',

          builder: (context, state) {
            final producto = state.extra as Producto;
            return DetalleProductoView(producto: producto);
          },
        ),

        GoRoute(
          path: 'carrito',

          builder: (context, state) => const CarritoView(),
        ),
      ],
    ),
  ],
);
