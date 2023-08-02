import 'package:dr_purple/core/features/domain/entities/entity.dart';

class MediaUploadEntity extends Entity {
  final String? id;
  final String? url;

  MediaUploadEntity({required this.id, required this.url});

  @override
  List<Object?> get props => [id, url];
}
