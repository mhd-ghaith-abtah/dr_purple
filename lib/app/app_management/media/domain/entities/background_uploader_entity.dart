import 'package:dr_purple/core/features/domain/entities/entity.dart';

class BackgroundUploaderEntity extends Entity {
  final String? taskId;

  BackgroundUploaderEntity({required this.taskId});

  @override
  List<Object?> get props => [taskId];
}
