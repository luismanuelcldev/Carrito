part of 'productos_cubit.dart';

abstract class ProductosState {
  const ProductosState();
}

class ProductosInitial extends ProductosState {
  const ProductosInitial();
}

class ProductosLoading extends ProductosState {
  const ProductosLoading();
}

class ProductosLoaded extends ProductosState {
  final List<Producto> productos;

  const ProductosLoaded({required this.productos});
}

class ProductosError extends ProductosState {
  final String message;

  const ProductosError({required this.message});
}
