import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto_moviles/seguros/bloc/segurosClass.dart';

part 'seguros_event.dart';
part 'seguros_state.dart';

class SegurosBloc extends Bloc<SegurosEvent, SegurosState> {
  SegurosBloc() : super(SegurosInitial()) {
    // on<SegurosOnSearch>(_onSearch);
    on<SegurosGetAll>(_getAll);
  }

  _getAll(SegurosGetAll event, Emitter<SegurosState> emit) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('usuarios')
        .where(FieldPath.documentId,
            isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get();

    for (DocumentSnapshot ds in querySnapshot.docs) {
      print(ds.data());
      emit(SegurosLoaded(query: ds.data() as Map<String, dynamic>));
      break;
    }
  }
}
