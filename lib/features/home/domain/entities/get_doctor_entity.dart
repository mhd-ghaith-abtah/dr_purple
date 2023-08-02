import 'package:dr_purple/core/features/domain/entities/entity.dart';

class GetDoctorEntity extends Entity {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? userName;
  final String? email;
  final String? contactNumber;
  final String? address;
  final int? role;
  final int? gender;
  final String? profilePicPath;

  GetDoctorEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.contactNumber,
    required this.address,
    required this.role,
    required this.gender,
    required this.profilePicPath,
  });

  @override
  List<Object?> get props => [];
}
