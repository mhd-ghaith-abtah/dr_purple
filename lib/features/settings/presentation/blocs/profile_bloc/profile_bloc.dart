import 'package:dr_purple/core/utils/constants.dart';
import 'package:dr_purple/features/settings/data/models/params/get_profile/get_profile_params.dart';
import 'package:dr_purple/features/settings/domain/entities/get_profile_entity.dart';
import 'package:dr_purple/features/settings/domain/use_cases/get_profile_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase _getProfileUseCase;

  GetProfileEntity? _getProfileEntity;

  GetProfileEntity? get getProfileEntity => _getProfileEntity;

  ProfileBloc(this._getProfileUseCase) : super(ProfileInitial()) {
    on<GetProfile>((event, emit) async {
      emit(ProfileLoading(loadingType: ProfileBlocStateType.gettingProfile));
      String errorMessage = Constants.empty;
      var res = await _getProfileUseCase
          .call(GetProfileParams(body: GetProfileParamsBody()));

      bool isError = res.fold((l) {
        errorMessage = l.message;
        return true;
      }, (r) {
        _getProfileEntity = r;
        return false;
      });
      if (isError) {
        emit(ProfileError(
            errorType: ProfileBlocStateType.gettingProfile,
            errorMessage: errorMessage));
      } else {
        emit(ProfileLoaded(loadedType: ProfileBlocStateType.gettingProfile));
      }
    });
  }
}
