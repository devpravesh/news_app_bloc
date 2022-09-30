part of 'counter_bloc.dart';

@immutable
abstract class CounterEvent {}
class CounterinitialEvent extends CounterEvent{}
class CounterincrementEvent extends CounterEvent{}
class CounterdecrementEvent extends CounterEvent{}

