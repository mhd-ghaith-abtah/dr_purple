import 'package:dr_purple/core/features/domain/entities/entity.dart';

class GetServiceTimeContractEntity extends Entity {
  final int? id;
  final int? contractId;
  final int? serviceId;

  GetServiceTimeContractEntity({
    required this.id,
    required this.contractId,
    required this.serviceId,
  });

  @override
  List<Object?> get props => [id, contractId, serviceId];
}
