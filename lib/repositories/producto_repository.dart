import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/producto.dart';

class ProductoRepository {
  final Dio dio;

  ProductoRepository({required this.dio});

  Future<List<Producto>> obtenerProductosCombinados() async {
    try {
      final nombresEspanol = [
        'Sofa de cuero',
        'Mesa de centro',
        'Lampara moderna',
        'Silla ergonómica',
        'Estantería',
        'Cama king size',
        'Escritorio',
        'Armario',
        'Espejo decorativo',
        'Alfombra persa',
      ];

      final descripcionesEspanol = [
        'Sofa de cuero genuino, comodo y duradero',
        'Mesa de centro de madera maciza con diseño moderno',
        'Lampara contemporanea con luz regulable',
        'Silla de oficina ergonomica con soporte lumbar',
        'Estanteria modular de 5 niveles en color nogal',
        'Cama tamaño king con colchon ortopedico incluido',
        'Escritorio ejecutivo con cajonera incorporada',
        'Armario de 3 puertas con espejo y cajones',
        'Espejo decorativo para sala con marco dorado',
        'Alfombra persa autentica, 100% lana',
      ];

      final imagenesPorProducto = [
        'https://picsum.photos/id/694/200/300',

        'https://picsum.photos/id/322/200/300',

        'https://picsum.photos/id/356/200/300',

        'https://picsum.photos/id/66/200/300',
        'https://picsum.photos/id/27/200/300',

        'https://picsum.photos/id/685/200/300',
        'https://picsum.photos/id/232/200/300',

        'https://picsum.photos/id/245/200/300',

        'https://picsum.photos/id/240/200/300',
        'https://picsum.photos/id/222/200/300',
      ];

      // Primera API implementada: JSONPlaceholder (posts)
      final response1 = await dio.get(
        'https://jsonplaceholder.typicode.com/posts',
      );
      final productosApi1 =
          (response1.data as List)
              .map((json) => Producto.fromJson(json))
              .take(10)
              .toList();

      // Segunda API implementada: FakeStoreAPI (productos de e-commerce)
      final response2 = await dio.get('https://fakestoreapi.com/products');

      final productosApi2 =
          (response2.data as List)
              .map((json) => Producto.fromJson(json))
              .take(10)
              .toList();

      final productosCombinados = [...productosApi1, ...productosApi2];

      for (var i = 0; i < productosCombinados.length; i++) {
        final index = i % nombresEspanol.length;

        final precioBase = 50.0 + (i * 10.0);

        productosCombinados[i] = productosCombinados[i].copyWith(
          nombre: nombresEspanol[index],

          descripcion: descripcionesEspanol[index],
          precio: precioBase,

          imagenUrl: imagenesPorProducto[index],
          stock: (i % 5) + 5,

          categoria: _obtenerCategoria(index),
        );
      }

      return productosCombinados;
    } catch (e) {
      throw Exception('Error al cargar productos: ${e.toString()}');
    }
  }

  String _obtenerCategoria(int index) {
    final categorias = [
      'Salas',

      'Muebles',

      'Iluminación',

      'Oficina',

      'Dormitorio',
    ];
    return categorias[index % categorias.length];
  }
}

class PrecioWidget extends StatelessWidget {
  final Producto producto;

  const PrecioWidget({super.key, required this.producto});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Precio: \$${producto.precio.toStringAsFixed(2)}',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        color: Colors.green,

        fontWeight: FontWeight.bold,
      ),
    );
  }
}
