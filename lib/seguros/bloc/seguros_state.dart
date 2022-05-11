part of 'seguros_bloc.dart';

abstract class SegurosState extends Equatable {
  const SegurosState();

  @override
  List<Object> get props => [];
}

class SegurosInitial extends SegurosState {}

class SegurosLoaded extends SegurosState {
  final Map<String, dynamic> query;

  SegurosLoaded({required this.query});

  @override
  List<Object> get props => [query];
}
