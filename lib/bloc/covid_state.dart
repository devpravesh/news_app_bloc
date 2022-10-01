part of 'covid_bloc.dart';

abstract class CovidState extends Equatable {
  const CovidState();

  @override
  List<Object?> get props => [];
}

class CovidInitial extends CovidState {}

class CovidLoading extends CovidState {}

class CovidLoaded extends CovidState {
  final NewsModel newsModel;
  const CovidLoaded(this.newsModel);
}

class CovidError extends CovidState {
  final String? message;
  const CovidError(this.message);
}
