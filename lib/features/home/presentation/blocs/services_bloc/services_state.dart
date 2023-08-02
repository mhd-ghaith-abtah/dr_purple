part of 'services_bloc.dart';

@immutable
abstract class ServicesState {}

class ServicesInitial extends ServicesState {}

class ServicesLoading extends ServicesState {
  final ServicesBlocStateType loadingType;

  ServicesLoading({required this.loadingType});
}

class ServicesLoaded extends ServicesState {
  final ServicesBlocStateType loadedType;

  ServicesLoaded({required this.loadedType});
}

class ServicesError extends ServicesState {
  final ServicesBlocStateType errorType;
  final String errorMessage;

  ServicesError({required this.errorType, required this.errorMessage});
}

enum ServicesBlocStateType {
  services,
}
