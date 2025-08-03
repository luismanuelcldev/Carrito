import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Articulos para el Hogar')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bienvenido a Tiendas RD !',
              style: TextStyle(fontSize: 24),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/productos'),
              child: const Text('Ver Productos'),
            ),
          ],
        ),
      ),
    );
  }
}
