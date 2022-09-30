import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterState(number: 0));


  void increment()=> emit(CounterState(number: state.number+1));
  void decrement()=> emit(CounterState(number: state.number-1));
}
