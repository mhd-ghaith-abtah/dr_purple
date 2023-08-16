import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/repositories/irepository.dart';
import 'package:dr_purple/features/pharmacy/data/remote/models/params/pharmacy/pharmacy_params.dart';
import 'package:dr_purple/features/pharmacy/domain/entities/pharmacy_entity.dart';

abstract class IPharmacyRepository extends IRepository {
  Future<Either<ErrorEntity, PharmacyEntity>> getPharmacy(
      PharmacyParams pharmacyParams);
}
