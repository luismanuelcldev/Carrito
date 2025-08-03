import 'package:examen1/Controllers/productos_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../widgets/producto_item.dart';
import '../widgets/carrito_button.dart';

class ProductosView extends StatelessWidget {
  const ProductosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Productos'),
        actions: const [CarritoButton()],
      ),

      body: BlocBuilder<ProductosCubit, ProductosState>(
        builder: (context, state) {
          if (state is ProductosLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductosError) {
            return Center(child: Text(state.message));
          } else if (state is ProductosLoaded) {
            return ListView.builder(
              itemCount: state.productos.length,
              itemBuilder: (ctx, index) {
                final producto = state.productos[index];
                return ProductoItem(
                  producto: producto,
                  onTap:
                      () => context.go(
                        '/producto/${producto.id}',
                        extra: producto,
                      ),
                );
              },
            );
          }
          return const Center(child: Text('Estado no reconocido'));
        },
      ),
    );
  }
}
