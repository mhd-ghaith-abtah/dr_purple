import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/auth/data/remote/models/params/refresh/refresh_params.dart';
import 'package:dr_purple/features/auth/domain/entities/refresh_entity.dart';

abstract class IRefreshRepository extends IRepository {
  Future<Either<ErrorEntity, RefreshEntity>> refresh(
      RefreshParams refreshParams);
}
