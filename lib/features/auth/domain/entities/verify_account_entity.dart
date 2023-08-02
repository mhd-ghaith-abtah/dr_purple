import 'package:dr_purple/core/features/domain/entities/entity.dart';

class VerifyAccountEntity extends Entity {
  final String? accessToken;
  final String? refreshToken;

  VerifyAccountEntity({required this.accessToken, required this.refreshToken});

  @override
  List<Object?> get props => [];
}
