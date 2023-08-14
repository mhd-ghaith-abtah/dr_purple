import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/settings/data/models/params/change_language/change_language_params.dart';
import 'package:dr_purple/features/settings/domain/entities/change_language_entity.dart';

abstract class IChangeLanguageRepository extends IRepository {
  Future<Either<ErrorEntity, ChangeLanguageEntity>> changeLanguage(
      ChangeLanguageParams changeLanguageParams);
}
