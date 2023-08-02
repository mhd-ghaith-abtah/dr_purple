import 'package:dr_purple/core/features/domain/entities/entity.dart';

class RefreshEntity extends Entity {
  final String? accessToken;
  final String? refreshToken;

  RefreshEntity({required this.accessToken, required this.refreshToken});

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
