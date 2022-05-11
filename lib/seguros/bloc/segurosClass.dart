class Seguros {
  Seguros(
      {required this.docs,
      required this.polizas,
      required this.tarjetas,
      required this.email,
      required this.nombre});

  Seguros.fromJson(Map<String, Object?> json)
      : this(
            docs: json['docs']! as Map<String, dynamic>,
            polizas: json['polizas']! as Map<String, dynamic>,
            tarjetas: json['tarjetas']! as Map<String, dynamic>,
            email: json['email']! as String,
            nombre: json['nombre']! as String);

  final Map<String, dynamic> docs;
  final Map<String, dynamic> polizas;

  final Map<String, dynamic> tarjetas;
  final String email;
  final String nombre;

  Map<String, Object?> toJson() {
    return {
      'docs': docs,
      'polizas': polizas,
      'tarjetas': tarjetas,
      'email': email,
      'nombre': nombre,
    };
  }
}
