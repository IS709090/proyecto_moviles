import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_moviles/auth/bloc/auth_bloc.dart';
import 'package:proyecto_moviles/seguros/bloc/seguros_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'siniestros.dart';
import 'polizas.dart';
import 'package:carousel_slider/carousel_slider.dart';

final List<String> imgList = [
  'https://firebasestorage.googleapis.com/v0/b/mis-seguros-e6e5d.appspot.com/o/files%2Ftarjetas%2Ftarjeta2.jpg?alt=media&token=34ddceb1-130a-4199-a864-18c015b1b0f6',
  'https://firebasestorage.googleapis.com/v0/b/mis-seguros-e6e5d.appspot.com/o/files%2Ftarjetas%2Ftarjeta3.JPG?alt=media&token=c2f0381d-0e07-4b6e-9516-3a85fc4d6596',
  'https://firebasestorage.googleapis.com/v0/b/mis-seguros-e6e5d.appspot.com/o/files%2Ftarjetas%2Ftarjeta1.jpg?alt=media&token=4ced8d8e-7ee5-43e3-856e-e259efdee1a9'
];

class Home extends StatefulWidget {
  // const Home({Key? key}) : super(key: key);
  final Map<String, dynamic> query;
  Home({Key? key, required this.query}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();

  var _iconColor = Colors.blue;
  var _newIconColor = Colors.yellow;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final Uri _url = Uri.parse('tel://3316689586');
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SegurosBloc, SegurosState>(
      listener: (context, state) {
        if (state is SegurosInitial) {
          BlocProvider.of<SegurosBloc>(context).add(SegurosGetAll());
        }
      },
      builder: (context, state) {
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
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {'Desconectar'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
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
                  accountName: Text(FirebaseAuth
                      .instance.currentUser!.displayName
                      .toString()),
                  accountEmail:
                      Text(FirebaseAuth.instance.currentUser!.email.toString()),
                  currentAccountPicture: CircleAvatar(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(45),
                    child: Image.network(
                        FirebaseAuth.instance.currentUser!.photoURL.toString()),
                  )),
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Inicio"),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.folder),
                  title: Text("Mis Polizas"),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PolizasScreen(query: widget.query)));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Mi Agente"),
                  onTap: () {
                    launchUrl(_url);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.warning),
                  title: Text("Siniestros"),
                  onTap: () {
                    print(widget.query);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Siniestros(query: widget.query)));
                  },
                ),
              ],
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              Expanded(
                child: Container(
                  child: CarouselSlider(
                    items: imageSliders,
                    carouselController: _controller,
                    options: CarouselOptions(
                        autoPlay: false,
                        enlargeCenterPage: true,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imgList.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .15),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.grey),
                          minimumSize: MaterialStateProperty.all(Size(
                              MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height * .2))),
                      child: Text('Mis Recibos\ny Pólizas',
                          style: TextStyle(fontSize: 30),
                          textAlign: TextAlign.center),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PolizasScreen(query: widget.query),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.grey),
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
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      minimumSize: MaterialStateProperty.all(Size(
                          MediaQuery.of(context).size.width,
                          MediaQuery.of(context).size.height * .2))),
                  child: Text('Tengo un Accidente!',
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center),
                  onPressed: () {
                    BlocProvider.of<SegurosBloc>(context).add(SegurosGetAll());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Siniestros(
                          query: widget.query,
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Text(widget.query.toString())
            ],
          ),
        );
      },
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Desconectar':
        showAlertDialog(context);
        break;
    }
  }
}

showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    title: Text(
      "Cerrar session",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    ),
    content: SingleChildScrollView(
      child: ListBody(
        children: const <Widget>[
          Text(
              'Al cerrar la sesion de su cuenta sera redirigido a la pantalla de inicio, ¿Desea continuar?'),
        ],
      ),
    ),
    actions: <Widget>[
      TextButton(
        child: const Text('Cancelar'),
        onPressed: () {
          Navigator.of(context).pop();
          ;
        },
      ),
      TextButton(
        child: const Text('Cerrar Sesion'),
        onPressed: () {
          BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
          Navigator.of(context).pop();
        },
      ),
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
