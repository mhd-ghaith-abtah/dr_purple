part of 'pharmacy_bloc.dart';

@immutable
abstract class PharmacyState {}

class PharmacyInitial extends PharmacyState {}

class PharmacyLoading extends PharmacyState {
  final PharmacyBlocStateType loadingType;

  PharmacyLoading({required this.loadingType});
}

class PharmacyLoaded extends PharmacyState {
  final PharmacyBlocStateType loadedType;

  PharmacyLoaded({required this.loadedType});
}

class PharmacyError extends PharmacyState {
  final PharmacyBlocStateType errorType;
  final String errorMessage;

  PharmacyError({required this.errorType, required this.errorMessage});
}

enum PharmacyBlocStateType { getPharmacy }
