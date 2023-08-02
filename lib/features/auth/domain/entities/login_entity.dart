import 'package:dr_purple/core/features/domain/entities/entity.dart';

class LoginEntity extends Entity {
  final String? accessToken;
  final String? refreshToken;

  LoginEntity({required this.accessToken, required this.refreshToken});

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
