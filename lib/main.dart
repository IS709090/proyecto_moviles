import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_moviles/auth/bloc/auth_bloc.dart';
import 'package:proyecto_moviles/home.dart';
import 'package:proyecto_moviles/login.dart';
import 'package:proyecto_moviles/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthBloc()..add(VerifyAuthEvent()),
      ),
    ],
    child: misSegurosApp(),
  ));
}

class misSegurosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'misSegurosApp',
        theme: ThemeData(primaryColor: Colors.blue),
        home: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Usuario no identificado"),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthSuccessState) {
              return Home();
            } else if (state is UnAuthState ||
                state is AuthErrorState ||
                state is SignOutSuccessState) {
              return Login();
            }
            return Center(child: CircularProgressIndicator());
          },
        ));
  }
}
