import 'package:flutter/material.dart';

import 'router.dart';

class AppHogar extends StatelessWidget {
  const AppHogar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Bienvenidos a Tiendas RD!',

      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: router,
    );
  }
}
