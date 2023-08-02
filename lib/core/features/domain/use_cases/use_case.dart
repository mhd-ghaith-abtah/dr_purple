import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/data/remote_data_source/models/params/params_model.dart';
import 'package:dr_purple/core/features/domain/entities/entity.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<DataEntity extends Entity, Params extends ParamsModel> {
  Future<Either<ErrorEntity, DataEntity>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
