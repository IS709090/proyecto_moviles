import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'siniestros.dart';
import 'polizas.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _iconColor = Colors.blue;
  var _newIconColor = Colors.yellow;
  int _current = 0;
  //final CarouselController _controller = CarouselController();
  final Uri _url = Uri.parse('tel://3316689586');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'Multi',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                color: Color(0xff14279B),
              ),
              children: [
                TextSpan(
                  text: 'Seguros',
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
              ]),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onPressed: () {},
          )
        ],
        actionsIconTheme: IconThemeData(
          size: 32,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("user"),
              accountEmail: Text("user@mail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Inicio"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.folder),
              title: Text("Mis Polizas"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Mi Agente"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.warning),
              title: Text("Siniestros"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(
                          MediaQuery.of(context).size.width,
                          MediaQuery.of(context).size.height * .2))),
                  child: Text('Mis Recibos\ny Pólizas',
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PolizasScreen(),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(
                          MediaQuery.of(context).size.width,
                          MediaQuery.of(context).size.height * .2))),
                  child: Text('Contactar Agente',
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center),
                  onPressed: () => launchUrl(_url),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  minimumSize: MaterialStateProperty.all(Size(
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height * .2))),
              child: Text('Tengo un Accidente!',
                  style: TextStyle(fontSize: 30), textAlign: TextAlign.center),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Siniestros(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
