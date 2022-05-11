part of 'seguros_bloc.dart';

abstract class SegurosEvent extends Equatable {
  const SegurosEvent();

  @override
  List<Object> get props => [];
}

class SegurosGetAll extends SegurosEvent {}
