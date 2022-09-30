part of 'counter_bloc.dart';

@immutable
abstract class CounterblocState {}

class CounterinitialState extends CounterblocState{}
class CounterincrementState extends CounterblocState{}
class CounterdecrementState extends CounterblocState{}