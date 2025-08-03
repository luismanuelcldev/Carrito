import 'package:examen1/models/producto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/producto_repository.dart';

part 'productos_state.dart';

class ProductosCubit extends Cubit<ProductosState> {
  final ProductoRepository repository;

  ProductosCubit(this.repository) : super(const ProductosInitial());

  Future<void> cargarProductos() async {
    emit(const ProductosLoading());
    try {
      final productos = await repository.obtenerProductosCombinados();
      emit(ProductosLoaded(productos: productos));
    } catch (e) {
      emit(ProductosError(message: e.toString()));
    }
  }
}
