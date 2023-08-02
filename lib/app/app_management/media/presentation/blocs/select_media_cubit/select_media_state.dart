part of 'select_media_cubit.dart';

@immutable
abstract class SelectMediaState {}

class SelectMediaInitial extends SelectMediaState {}

class SelectingMedia extends SelectMediaState {}

class RemovingMedia extends SelectMediaState {}

class MediaSelected extends SelectMediaState {}

class MediaRemoved extends SelectMediaState {}
