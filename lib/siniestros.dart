import 'dart:convert';

import 'package:flutter/material.dart';
import 'testing.dart';

class Siniestros extends StatefulWidget {
  Siniestros({Key? key}) : super(key: key);

  @override
  State<Siniestros> createState() => _SiniestrosState();
}

class _SiniestrosState extends State<Siniestros> {
  String dropdownValue = Hogar.tipo;
  Set<Map<String, String>>? polizas = Polizas.values.elementAt(0);

  // List<Polizas> arregloPolizas = [
  //   PolizasSeguroVida,
  //   PolizasAutomovilistico,
  //   PolizasHogar,
  //   PolizasMedico
  // ];
  // Map<String, dynamic> listValues = jsonDecode(Polizas["Polizas"]["Hogar"]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reporte de Siniestro",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: ListView(padding: const EdgeInsets.all(25), children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "¿Que tipo de Reporte deseas hacer?",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          Row(children: [
            Expanded(
              child: DropdownButton<String>(
                isExpanded: true,
                value: dropdownValue,
                icon: const Icon(Icons.arrow_drop_down_circle),
                elevation: 16,
                style: TextStyle(fontSize: 20, color: Colors.black),
                underline: Container(
                  height: 3,
                  color: Colors.blue,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    polizas = Polizas[newValue];
                    // print(listValues);
                  });
                },
                items: <String>[
                  Hogar.tipo,
                  Medico.tipo,
                  Automovilistico.tipo,
                  SeguroVida.tipo,
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ]),
          SizedBox(height: 50),
          Text(
            "Seleccione el Producto Asociado",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 10),
          Container(
            height: 3,
            color: Colors.grey,
          ),
          SizedBox(height: 15),
          ListView.separated(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: polizas!.length,
            itemBuilder: (BuildContext context, int index) {
              var value = polizas!.elementAt(index);
              print(value);

              return GestureDetector(
                child: Container(
                  height: 50,
                  // color: Colors.purple,
                  child: Row(children: [
                    Expanded(
                      flex: 2,
                      child: Image.network(
                          "https://wnscom-bucket.s3.amazonaws.com/S3_5/Images/CapabilitiesHeader/HeaderImage/16512/8/insurance-banner.png"),
                    ),
                    Expanded(
                      flex: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value["titulo"].toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            value["descripcion"].toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
          SizedBox(height: 10),
          Container(
            height: 3,
            color: Colors.grey,
          ),
          SizedBox(height: 15),
        ]),
      ]),
    );
  }
}
