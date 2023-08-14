import 'package:dr_purple/core/features/domain/entities/entity.dart';

class UpdateFCMTokenEntity extends Entity {
  final String accessToken;

  UpdateFCMTokenEntity({required this.accessToken});

  @override
  List<Object?> get props => [accessToken];
}
