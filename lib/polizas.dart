import 'package:flutter/material.dart';
import 'package:proyecto_moviles/home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'loadingScreed.dart';
import 'testing.dart';

class PolizasScreen extends StatefulWidget {
  final Map<String, dynamic> query;
  PolizasScreen({Key? key, required this.query}) : super(key: key);
  @override
  State<PolizasScreen> createState() => _PolizasScreenState();
}

class _PolizasScreenState extends State<PolizasScreen> {
  Map<String, Set<Map<String, String>>> polizas = Polizas;

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> arregloPolizas = [];
    polizas.entries.forEach((entry) {
      entry.value.forEach((element) {
        arregloPolizas.add(element);
      });
    });
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
          "Pólizas",
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: ListView(padding: const EdgeInsets.all(25), children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ListView.separated(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: widget.query['polizas'].length,
            itemBuilder: (BuildContext context, int index) {
              var value = widget.query['polizas'][index.toString()];
              return GestureDetector(
                onTap: () {
                  launchUrl(
                      Uri.parse(
                        "https://firebasestorage.googleapis.com/v0/b/mis-seguros-e6e5d.appspot.com/o/files%2Fdocs%2FCERTIFICADO%20ENANO.pdf?alt=media&token=4dedfcd8-1263-487c-b92f-7c04deed7d3d",
                      ),
                      mode: LaunchMode.externalApplication);
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          spreadRadius: .05,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
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
                            value["nombrePoliza"].toString(),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            value["tipo"].toString(),
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(color: Color.fromARGB(255, 124, 124, 124)),
          ),
        ]),
      ]),
    );
  }
}
