import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/settings/data/models/params/change_language/change_language_params.dart';
import 'package:dr_purple/features/settings/data/repositories/change_language_repository.dart';
import 'package:dr_purple/features/settings/domain/entities/change_language_entity.dart';

class ChangeLanguageUseCase
    extends UseCase<ChangeLanguageEntity, ChangeLanguageParams> {
  ChangeLanguageRepository repository;

  ChangeLanguageUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, ChangeLanguageEntity>> call(
          ChangeLanguageParams params) async =>
      repository.changeLanguage(params);
}
