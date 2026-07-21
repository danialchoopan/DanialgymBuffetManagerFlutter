import '../../../core/database/entities/member/member_entity.dart';
import '../../../domain/entities/member/member_entity.dart' as domain;

class MemberMapper {
  static domain.MemberEntity toDomain(MemberEntity entity) {
    return domain.MemberEntity(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      phone: entity.phone,
      dateOfBirth: entity.dateOfBirth,
      gender: entity.gender,
      address: entity.address,
      emergencyContact: entity.emergencyContact,
      photoPath: entity.photoPath,
      membershipType: entity.membershipType,
      membershipStartDate: entity.membershipStartDate,
      membershipEndDate: entity.membershipEndDate,
      membershipStatus: entity.membershipStatus,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      isActive: entity.isActive,
    );
  }

  static MemberEntity toEntity(domain.MemberEntity domain) {
    return MemberEntity(
      id: domain.id,
      firstName: domain.firstName,
      lastName: domain.lastName,
      email: domain.email,
      phone: domain.phone,
      dateOfBirth: domain.dateOfBirth,
      gender: domain.gender,
      address: domain.address,
      emergencyContact: domain.emergencyContact,
      photoPath: domain.photoPath,
      membershipType: domain.membershipType,
      membershipStartDate: domain.membershipStartDate,
      membershipEndDate: domain.membershipEndDate,
      membershipStatus: domain.membershipStatus,
      createdAt: domain.createdAt,
      updatedAt: domain.updatedAt,
      isActive: domain.isActive,
    );
  }

  static List<domain.MemberEntity> toDomainList(List<MemberEntity> entities) {
    return entities.map(toDomain).toList();
  }

  static List<MemberEntity> toEntityList(List<domain.MemberEntity> domains) {
    return domains.map(toEntity).toList();
  }
}