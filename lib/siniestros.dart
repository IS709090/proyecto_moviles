import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proyecto_moviles/home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'loadingScreed.dart';
import 'testing.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Siniestros extends StatefulWidget {
  Siniestros({Key? key}) : super(key: key);

  @override
  State<Siniestros> createState() => _SiniestrosState();
}

class _SiniestrosState extends State<Siniestros> {
  String dropdownValue = Hogar.tipo;
  final Uri _url = Uri.parse('tel://3316689586');
  Set<Map<String, String>>? polizas = Polizas.values.elementAt(0);
  Map<String, String> polizaIndividual = Polizas.values.elementAt(0).first;
  String numeroPoliza = "";

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => loading()));
          },
        ),
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
                    numeroPoliza = "";
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
          SizedBox(height: 20),
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

              return GestureDetector(
                onTap: () {
                  setState(() {
                    numeroPoliza = value["numero_poliza"].toString();
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: .7,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                      color: Color.fromARGB(255, 220, 223, 252),
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Row(children: [
                    Expanded(
                      flex: 2,
                      child: Image.network(
                          "https://wnscom-bucket.s3.amazonaws.com/S3_5/Images/CapabilitiesHeader/HeaderImage/16512/8/insurance-banner.png"),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value["titulo"].toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
                const Divider(color: Colors.grey),
          ),
          SizedBox(height: 10),
          Container(
            height: 3,
            color: Colors.grey,
          ),
          SizedBox(height: 15),
          Container(
            height: MediaQuery.of(context).size.height * .6,
            child: Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    padding: EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: .1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 11.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: .1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white70,
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                            "Durante la llamada le solicitarán la siguiente información:",
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify),
                        Text("Número de Póliza:",
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify),
                        Text(numeroPoliza,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.justify),
                        Text("\nUbicación:",
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify),
                        Text(_center.toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.justify)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    launchUrl(_url);
                  },
                  child: Icon(Icons.phone, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    primary: Colors.lightGreen,
                  ),
                )
              ],
            ),
          )
        ]),
      ]),
    );
  }
}
