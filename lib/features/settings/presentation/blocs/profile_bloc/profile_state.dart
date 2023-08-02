part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {
  final ProfileBlocStateType loadingType;

  ProfileLoading({required this.loadingType});
}

class ProfileLoaded extends ProfileState {
  final ProfileBlocStateType loadedType;

  ProfileLoaded({required this.loadedType});
}

class ProfileError extends ProfileState {
  final ProfileBlocStateType errorType;
  final String errorMessage;

  ProfileError({required this.errorType, required this.errorMessage});
}

enum ProfileBlocStateType { gettingProfile }
