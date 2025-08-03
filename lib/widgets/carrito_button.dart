import 'package:examen1/Controllers/carrito_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CarritoButton extends StatelessWidget {
  const CarritoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarritoCubit, CarritoState>(
      builder: (context, state) {
        if (state.items.isEmpty) return const SizedBox.shrink();

        return IconButton(
          icon: Badge(
            label: Text(state.items.length.toString()),

            child: const Icon(Icons.shopping_cart),
          ),

          onPressed: () => context.go('/carrito'),
        );
      },
    );
  }
}

extension on Object {}
