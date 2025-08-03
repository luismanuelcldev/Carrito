import 'package:examen1/Controllers/carrito_cubit.dart';
import 'package:examen1/Controllers/productos_cubit.dart';
import 'package:examen1/repositories/producto_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';
import 'package:dio/dio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  final productoRepository = ProductoRepository(dio: dio);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CarritoCubit(prefs)..cargarCarrito()),
        BlocProvider(
          create:
              (context) =>
                  ProductosCubit(productoRepository)..cargarProductos(),
        ),
      ],

      child: const AppHogar(),
    ),
  );
}
