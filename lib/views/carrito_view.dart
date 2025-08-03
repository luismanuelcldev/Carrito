import 'package:examen1/Controllers/carrito_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarritoView extends StatelessWidget {
  const CarritoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Vaciar Carrito'),
                      content: const Text(
                        '¿Esta seguro que desea vaciar el carrito?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),

                        TextButton(
                          onPressed: () {
                            context.read<CarritoCubit>().limpiarCarrito();
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Carrito vaciado')),
                            );
                          },
                          child: const Text('Vaciar'),
                        ),
                      ],
                    ),
              );
            },
          ),
        ],
      ),

      body: BlocBuilder<CarritoCubit, CarritoState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const Center(child: Text('El carrito está vacío'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (ctx, index) {
                    final item = state.items[index];
                    return Dismissible(
                      key: Key(item.producto.id),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),

                      onDismissed: (direction) {
                        context.read<CarritoCubit>().eliminarProducto(
                          item.producto,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item.producto.nombre} eliminado'),
                            action: SnackBarAction(
                              label: 'Deshacer',
                              onPressed: () {
                                context.read<CarritoCubit>().agregarProducto(
                                  item.producto,
                                );
                              },
                            ),
                          ),
                        );
                      },

                      child: ListTile(
                        leading: Image.network(
                          item.producto.imagenUrl,
                          width: 50,
                          height: 50,
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                        ),
                        title: Text(item.producto.nombre),
                        subtitle: Text(
                          'Cantidad: ${item.cantidad} - \$${(item.producto.precio * item.cantidad).toStringAsFixed(2)}',
                        ),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                if (item.cantidad > 1) {
                                  context
                                      .read<CarritoCubit>()
                                      .actualizarCantidad(
                                        item.producto,
                                        item.cantidad - 1,
                                      );
                                } else {
                                  context.read<CarritoCubit>().eliminarProducto(
                                    item.producto,
                                  );
                                }
                              },
                            ),

                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed:
                                  item.cantidad < item.producto.stock
                                      ? () {
                                        context
                                            .read<CarritoCubit>()
                                            .actualizarCantidad(
                                              item.producto,
                                              item.cantidad + 1,
                                            );
                                      }
                                      : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(
                      'Total:',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      '\$${state.total.toStringAsFixed(2)}',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
