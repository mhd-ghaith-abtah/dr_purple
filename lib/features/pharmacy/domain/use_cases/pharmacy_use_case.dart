import 'package:dartz/dartz.dart';
import 'package:dr_purple/core/features/domain/entities/error_entity.dart';
import 'package:dr_purple/core/features/domain/use_cases/use_case.dart';
import 'package:dr_purple/features/pharmacy/data/remote/models/params/pharmacy/pharmacy_params.dart';
import 'package:dr_purple/features/pharmacy/data/repositories/pharmacy_repository.dart';
import 'package:dr_purple/features/pharmacy/domain/entities/pharmacy_entity.dart';

class PharmacyUseCase extends UseCase<PharmacyEntity, PharmacyParams> {
  PharmacyRepository repository;

  PharmacyUseCase(this.repository);

  @override
  Future<Either<ErrorEntity, PharmacyEntity>> call(
          PharmacyParams params) async =>
      repository.getPharmacy(params);
}
