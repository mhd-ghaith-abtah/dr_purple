import 'package:dr_purple/core/features/domain/entities/entity.dart';
import 'package:dr_purple/features/pharmacy/data/remote/models/responses/pharmacy_api_response/pharmacy_api_response.dart';

class PharmacyEntity extends Entity {
  final List<MaterialsModel> materials;

  PharmacyEntity({required this.materials});

  @override
  List<Object?> get props => [materials];
}
