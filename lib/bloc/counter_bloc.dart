import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterblocState> {
  var count = 0;
  CounterBloc() : super(CounterinitialState()) {
    on<CounterincrementEvent>(
        (event, emit) => {count++, log(count.toString())});
    on<CounterincrementEvent>((event, emit) => {count--});
  }
}
