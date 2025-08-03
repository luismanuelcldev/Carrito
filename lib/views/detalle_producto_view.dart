import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../Controllers/carrito_cubit.dart';
import '../models/producto.dart';

class DetalleProductoView extends StatefulWidget {
  final Producto producto;

  const DetalleProductoView({super.key, required this.producto});

  @override
  State<DetalleProductoView> createState() => _DetalleProductoViewState();
}

class _DetalleProductoViewState extends State<DetalleProductoView> {
  int cantidad = 1;
  bool actualizando = false;
  bool errorStock = false;

  Future<void> _agregarAlCarrito() async {
    setState(() {
      actualizando = true;
      errorStock = false;
    });

    try {
      if (cantidad > widget.producto.stock) {
        setState(() => errorStock = true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Solo ${widget.producto.stock} disponibles'),
            duration: const Duration(seconds: 2),
          ),
        );
        return;
      }

      context.read<CarritoCubit>().agregarProducto(
        widget.producto,
        cantidad: cantidad,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.producto.nombre} agregado al carrito'),
          action: SnackBarAction(
            label: 'Ver Carrito',
            onPressed: () => context.go('/carrito'),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          duration: const Duration(seconds: 2),
        ),
      );
    } finally {
      setState(() => actualizando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Detalles del producto'),
            Text(
              widget.producto.nombre,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                widget.producto.imagenUrl,
                height: 250,
                errorBuilder:
                    (context, error, stackTrace) =>
                        const Icon(Icons.error, size: 100),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              widget.producto.nombre,
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 10),

            Text(
              'Precio: \$${widget.producto.precio.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),
            Text(
              'Categoría: ${widget.producto.categoria}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const SizedBox(height: 10),
            Text(
              'Disponibles: ${widget.producto.stock}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color:
                    errorStock
                        ? Colors.red
                        : widget.producto.stock > 0
                        ? Colors.green
                        : Colors.red,
              ),
            ),

            if (errorStock)
              Text(
                'Cantidad seleccionada excede el stock',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.red),
              ),

            const SizedBox(height: 20),

            Text(
              'Descripción:',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            Text(widget.producto.descripcion),
            const Spacer(),

            if (widget.producto.stock > 0) ...[
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed:
                        cantidad > 1 && !actualizando
                            ? () => setState(() => cantidad--)
                            : null,
                  ),

                  Text(
                    cantidad.toString(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed:
                        cantidad < widget.producto.stock && !actualizando
                            ? () => setState(() => cantidad++)
                            : null,
                  ),

                  const Spacer(),

                  ElevatedButton.icon(
                    onPressed: actualizando ? null : _agregarAlCarrito,
                    icon:
                        actualizando
                            ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                            : const Icon(Icons.add_shopping_cart),
                    label:
                        actualizando
                            ? const Text('Procesando...')
                            : const Text('Agregar al Carrito'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
