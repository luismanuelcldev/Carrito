part of 'carrito_cubit.dart';

class CarritoState {
  final List<ItemCarrito> items;

  final bool isEditing;

  CarritoState({this.items = const [], this.isEditing = false});

  double get total => items.fold(
    0,
    (total, item) => total + (item.producto.precio * item.cantidad),
  );

  CarritoState copyWith({List<ItemCarrito>? items, bool? isEditing}) {
    return CarritoState(
      items: items ?? this.items,
      isEditing: isEditing ?? this.isEditing,
    );
  }
}

class ItemCarrito {
  final Producto producto;
  int cantidad;

  ItemCarrito({required this.producto, required this.cantidad});

  Map<String, dynamic> toJson() {
    return {'producto': producto.toJson(), 'cantidad': cantidad};
  }

  factory ItemCarrito.fromJson(Map<String, dynamic> json) {
    return ItemCarrito(
      producto: Producto.fromJson(json['producto']),
      cantidad: json['cantidad'],
    );
  }
}
