final Map<String, dynamic> TiposPoliza = {
  '0': "Médico",
  '1': "Automovilístico",
  '2': "Seguro de Vida"
};

final Map<String, dynamic> LinksPoliza = {
  '0':
      "https://firebasestorage.googleapis.com/v0/b/mis-seguros-e6e5d.appspot.com/o/files%2Fdocs%2FCERTIFICADO%20ENANO.pdf?alt=media&token=4dedfcd8-1263-487c-b92f-7c04deed7d3d",
  '1':
      "https://firebasestorage.googleapis.com/v0/b/mis-seguros-e6e5d.appspot.com/o/files%2Fdocs%2FP%C3%B3liza%20GB41010684.pdf?alt=media&token=5413982d-e1a8-4825-9506-97f15dfbf833",
  '2':
      "https://firebasestorage.googleapis.com/v0/b/mis-seguros-e6e5d.appspot.com/o/files%2Fdocs%2FPOLIZA%20VIDA.pdf?alt=media&token=5fd7d6dd-abe0-4dca-bbdc-7497f8479911",
};

final Map<String, Set<Map<String, String>>> Polizas = {
  'Médico': {
    {
      'titulo': "Diego Arana Ballesteros",
      'aseguradora': "Aseguradora MAPFRE",
      'descripcion': "Seguro de Gastos Médicos Menores",
      'numero_poliza': "48H9FWHE9FH9"
    },
  },
  'Automovilístico': {
    {
      'titulo': "SEAT Ibiza 2017",
      'aseguradora': "Aseguradora HDI",
      'descripcion': "Seguro de Automóvil",
      'numero_poliza': "4JF094WJF09W"
    },
  },
  'Seguro de Vida': {
    {
      'titulo': "Diego Arana Ballestero",
      'aseguradora': "Aseguradora GNP",
      'descripcion': "Seguro de Vida Menor",
      'numero_poliza': "96JEPRFJ4K"
    }
  }
};

class TiposPolizaClass {
  final String tipo;

  TiposPolizaClass(this.tipo);

  TiposPolizaClass.fromJson(Map<String, dynamic> json) : tipo = json['tipo'];

  Map<String, dynamic> toJson() => {
        'tipo': tipo,
      };
}

final TiposPolizaClass Hogar = TiposPolizaClass("Hogar");
final TiposPolizaClass Medico = TiposPolizaClass("Médico");
final TiposPolizaClass Automovilistico = TiposPolizaClass("Automovilístico");
final TiposPolizaClass SeguroVida = TiposPolizaClass("Seguro de Vida");

class PolizasTest {
  final String tipo;
  final Set<Map<String, String>> polizas;

  PolizasTest(this.tipo, this.polizas);

  PolizasTest.fromJson(Map<String, dynamic> json)
      : tipo = json['tipo'],
        polizas = json['polizas'];

  Map<String, dynamic> toJson() => {
        'tipo': tipo,
        'polizas': polizas,
      };
}

final PolizasTest PolizasSeguroVida = PolizasTest("SeguroVida", {
  {
    'titulo': "Diego Arana Ballesteros",
    'aseguradora': "Aseguradora GNP",
    'descripcion': "Seguro de Vida Menor",
    'numero_poliza': "96JEPRFJ4K"
  }
});

final PolizasTest PolizasAutomovilistico = PolizasTest("Automovilistico", {
  {
    'titulo': "Diego Arana Ballesteros",
    'aseguradora': "Aseguradora GNP",
    'descripcion': "Seguro de Vida Menor",
    'numero_poliza': "96JEPRFJ4K"
  }
});

final PolizasTest PolizasMedico = PolizasTest("Medico", {
  {
    'titulo': "Diego Arana Ballesteros",
    'aseguradora': "Aseguradora MAPFRE",
    'descripcion': "Seguro de Gastos Médicos Menores",
    'numero_poliza': "48H9FWHE9FH9"
  },
});

final PolizasTest PolizasHogar = PolizasTest("Hogar", {
  {
    'titulo': "Casa Parque Metropolitano",
    'aseguradora': "Aseguradora AXA",
    'descripcion': "Seguro de Hogar contra Robo",
    'numero_poliza': "37FA839HF04"
  },
});
