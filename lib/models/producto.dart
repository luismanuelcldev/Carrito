class Producto {
  final String id;
  final String nombre;
  final String descripcion;
  final double precio;
  final String imagenUrl;
  final int stock;
  final String categoria;

  Producto({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.imagenUrl,
    required this.stock,
    required this.categoria,
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id']?.toString() ?? '0',
      nombre: json['title'] ?? json['nombre'] ?? 'Sin nombre',
      descripcion: json['body'] ?? json['descripcion'] ?? 'Sin descripcion',
      precio: (json['price'] ?? json['precio'] ?? 0.0).toDouble(),
      imagenUrl:
          json['imageUrl'] ??
          json['imagenUrl'] ??
          'https://picsum.photos/200/300',
      stock: json['stock']?.toInt() ?? 10,
      categoria: json['category'] ?? json['categoria'] ?? 'General',
    );
  }

  Producto copyWith({
    String? id,

    String? nombre,

    String? descripcion,

    double? precio,
    String? imagenUrl,
    int? stock,

    String? categoria,
  }) {
    return Producto(
      id: id ?? this.id,

      nombre: nombre ?? this.nombre,

      descripcion: descripcion ?? this.descripcion,
      precio: precio ?? this.precio,
      imagenUrl: imagenUrl ?? this.imagenUrl,

      stock: stock ?? this.stock,

      categoria: categoria ?? this.categoria,
    );
  }

  // En producto.dart
  Map<String, dynamic> toJson() {
    return {
      'id': id,

      'nombre': nombre,
      'descripcion': descripcion,

      'precio': precio,
      'imagenUrl': imagenUrl,
      'stock': stock,

      'categoria': categoria,
    };
  }
}
