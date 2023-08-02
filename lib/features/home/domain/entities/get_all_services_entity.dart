import 'package:dr_purple/core/features/domain/entities/entity.dart';
import 'package:dr_purple/features/home/data/remote/models/responses/get_all_services_api_response/get_all_services_api_response.dart';

class GetAllServicesEntity extends Entity {
  final List<ServiceModel>? services;
  final int? currentPage;
  final int? pageCount;
  final int? pageSize;
  final int? rowCount;
  final bool? hasPreviousPage;
  final bool? hasNextPage;

  GetAllServicesEntity({
    required this.services,
    required this.currentPage,
    required this.pageCount,
    required this.pageSize,
    required this.rowCount,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  @override
  List<Object?> get props => [
        services,
        currentPage,
        pageCount,
        pageSize,
        rowCount,
        hasPreviousPage,
      ];
}
