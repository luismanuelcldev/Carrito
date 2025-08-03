import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/producto.dart';

part 'carrito_state.dart';

BuildContext? globalContext;

class CarritoCubit extends Cubit<CarritoState> {
  final SharedPreferences prefs;
  static const String _carritoKey = 'carrito';

  CarritoCubit(this.prefs) : super(CarritoState());

  void agregarProducto(Producto producto, {int cantidad = 1}) {
    if (producto.stock <= 0 || cantidad <= 0) return;

    final nuevoCarrito = List<ItemCarrito>.from(state.items);

    final index = nuevoCarrito.indexWhere(
      (item) => item.producto.id == producto.id,
    );

    if (index >= 0) {
      final nuevaCantidad = nuevoCarrito[index].cantidad + cantidad;

      if (nuevaCantidad <= producto.stock) {
        nuevoCarrito[index] = ItemCarrito(
          producto: producto,

          cantidad: nuevaCantidad,
        );
      }
    } else {
      if (cantidad <= producto.stock) {
        nuevoCarrito.add(ItemCarrito(producto: producto, cantidad: cantidad));
      }
    }

    _guardarCarrito(nuevoCarrito);

    emit(CarritoState(items: nuevoCarrito));
  }

  void eliminarProducto(Producto producto) {
    final nuevoCarrito = List<ItemCarrito>.from(state.items);

    nuevoCarrito.removeWhere((item) => item.producto.id == producto.id);

    _guardarCarrito(nuevoCarrito);

    emit(CarritoState(items: nuevoCarrito));
  }

  void actualizarCantidad(Producto producto, int nuevaCantidad) {
    if (nuevaCantidad <= 0 || nuevaCantidad > producto.stock) return;

    final nuevoCarrito = List<ItemCarrito>.from(state.items);
    final index = nuevoCarrito.indexWhere(
      (item) => item.producto.id == producto.id,
    );

    if (index >= 0) {
      nuevoCarrito[index] = ItemCarrito(
        producto: producto,
        cantidad: nuevaCantidad,
      );
    }

    _guardarCarrito(nuevoCarrito);

    emit(CarritoState(items: nuevoCarrito));
  }

  Future<void> cargarCarrito() async {
    final listaJson = prefs.getStringList(_carritoKey) ?? [];

    final carrito =
        listaJson.map((jsonString) {
          final json = jsonDecode(jsonString);
          return ItemCarrito.fromJson(json);
        }).toList();

    emit(CarritoState(items: carrito));
  }

  Future<void> _guardarCarrito(List<ItemCarrito> carrito) async {
    final listaJson = carrito.map((item) => item.toJson()).toList();
    await prefs.setStringList(
      _carritoKey,

      listaJson.map((json) => json.toString()).toList(),
    );
  }

  void limpiarCarrito() {
    prefs.remove(_carritoKey);

    emit(CarritoState());

    ScaffoldMessenger.of(
      globalContext as BuildContext,
    ).showSnackBar(const SnackBar(content: Text('Carrito vaciado')));
  }
}
