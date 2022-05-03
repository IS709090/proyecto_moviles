import 'package:flutter/material.dart';
import 'testing.dart';

class Siniestros extends StatefulWidget {
  Siniestros({Key? key}) : super(key: key);

  @override
  State<Siniestros> createState() => _SiniestrosState();
}

class _SiniestrosState extends State<Siniestros> {
  String dropdownValue = TiposPoliza["Coche"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reporte de Siniestro",
          style: TextStyle(fontSize: 30),
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
                  });
                },
                items: <String>[
                  TiposPoliza["Coche"],
                  TiposPoliza["Hogar"],
                  TiposPoliza["Medico"],
                  TiposPoliza["Vida"],
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ]),
          SizedBox(height: 10),
          Text(
            "Seleccione el Producto Asociado",
            style: TextStyle(fontSize: 20),
          ),
        ]),
      ]),
    );
  }
}
