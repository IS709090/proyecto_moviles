import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home.dart';
import 'seguros/bloc/seguros_bloc.dart';

class loading extends StatefulWidget {
  loading({Key? key}) : super(key: key);

  @override
  State<loading> createState() => _loadingState();
}

class _loadingState extends State<loading> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SegurosBloc, SegurosState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is SegurosLoaded) {
          return Home(query: state.query);
        }
        return Center(
            child: Container(
          child: Text("Loading"),
        ));
      },
    );
  }
}
