import 'package:dr_purple/core/features/domain/entities/entity.dart';
import 'package:dr_purple/features/home/data/remote/models/responses/get_service_time_api_response/get_service_time_api_response.dart';

class GetServiceTimeEntity extends Entity {
  final List<GetServiceTimeAPIResult>? serviceTimes;

  GetServiceTimeEntity({required this.serviceTimes});

  @override
  List<Object?> get props => [serviceTimes];
}
