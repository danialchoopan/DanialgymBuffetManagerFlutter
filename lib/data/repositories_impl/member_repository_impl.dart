import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/errors/error_handler.dart';
import '../../../domain/repositories/member_repository.dart';
import '../../../domain/entities/member/member_entity.dart' as domain;
import '../../../domain/entities/member/member_profile_entity.dart' as domain_profile;
import '../../../domain/entities/member/member_health_entity.dart' as domain_health;
import '../../../core/database/entities/member/member_entity.dart';
import '../../../core/database/entities/member/member_profile_entity.dart';
import '../../../core/database/entities/member/member_health_entity.dart';
import '../datasources/local/member_local_datasource.dart';

class MemberRepositoryImpl implements MemberRepository {
  final MemberLocalDatasource _localDatasource;
  final ErrorHandler _errorHandler;

  MemberRepositoryImpl({
    required MemberLocalDatasource localDatasource,
    required ErrorHandler errorHandler,
  })  : _localDatasource = localDatasource,
        _errorHandler = errorHandler;

  @override
  ResultFuture<List<domain.MemberEntity>> getAllMembers() async {
    try {
      final members = await _localDatasource.getAllMembers();
      return Right(members.map(_toDomainMember).toList());
    } catch (e) {
      return Left(_errorHandler.handleError(e, StackTrace.current));
    }
  }

  @override
  ResultFuture<domain.MemberEntity?> getMemberById(String id) async {
    try {
      final member = await _localDatasource.getMemberById(id);
      return Right(member != null ? _toDomainMember(member) : null);
    } catch (e) {
      return Left(_errorHandler.handleError(e, StackTrace.current));
    }
  }

  @override
  ResultFuture<domain.MemberEntity?> getMemberByEmail(String email) async {
    try {
      final member = await _localDatasource.getMemberByEmail(email);
      return Right(member != null ? _toDomainMember(member) : null);
    } catch (e) {
      return Left(_errorHandler.handleError(e, StackTrace.current));
    }
  }

  @override
  ResultFuture<domain.MemberEntity?> getMemberByPhone(String phone) async {
    try {
      final member = await _localDatasource.getMemberByPhone(phone);
      return Right(member != null ? _toDomainMember(member) : null);
    } catch (e) {
      return Left(_errorHandler.handleError(e, StackTrace.current));
    }
  }

  @override
  ResultFuture<List<domain.MemberEntity>> getMembersByStatus(String status) async {
    try {
      final members = await _localDatasource.getMembersByStatus(status);
      return Right(members.map(_toDomainMember).toList());
    } catch (e) {
      return Left(_errorHandler.handleError(e, StackTrace.current));
    }
  }

  @override
  ResultFuture<List<domain.MemberEntity>> searchMembers(String query) async {
    try {
      final members = await _localDatasource.searchMembers(query);
      return Right(members.map(_toDomainMember).toList());
    } catch (e) {
      return Left(_errorHandler.handleError(e, StackTrace.current));
    }
  }

  @override
  ResultFuture<void> addMember(domain.MemberEntity member) async {
    try {
      await _localDatasource.insertMember(_toEntityMember(member));
      return const Right(null);
    } catch (e) {
      return Left(_errorHandler.handleError(e, StackTrace.current));
    }
  }

  @override
  ResultFuture<void> updateMember(domain.MemberEntity member) async {
    try {
      await _localDatasource.updateMember(_toEntityMember(member));
      return const Right(null);
    } catch (e) {
      return Left(_errorHandler.handleError(e, StackTrace.current));
    }
  }

  @override
  ResultFuture<void> deleteMember(String id) async {
    try {
      await _localDatasource.softDeleteMember(id);
      return const Right(null);
    } catch (e) {
      return Left(_errorHandler.handleError(e, StackTrace.current));
    }
  }

  @override
  ResultFuture<domain_profile.MemberProfileEntity?> getMemberProfile(String memberId) async {
    try {
      final profile = await _localDatasource.getProfileByMemberId(memberId);
      return Right(profile != null ? _toDomainProfile(profile) : null);
    } catch (e) {
      return Left(_errorHandler.handleError(e, StackTrace.current));
    }
  }

  @override
  ResultFuture<void> updateMemberProfile(domain_profile.MemberProfileEntity profile) async {
    try {
      await _localDatasource.updateProfile(_toEntityProfile(profile));
      return const Right(null);
    } catch (e) {
      return Left(_errorHandler.handleError(e, StackTrace.current));
    }
  }

  @override
  ResultFuture<List<domain_health.MemberHealthEntity>> getMemberHealthHistory(String memberId) async {
    try {
      final health = await _localDatasource.getHealthByMemberId(memberId);
      return Right(health.map(_toDomainHealth).toList());
    } catch (e) {
      return Left(_errorHandler.handleError(e, StackTrace.current));
    }
  }

  @override
  ResultFuture<void> addMemberHealthRecord(domain_health.MemberHealthEntity health) async {
    try {
      await _localDatasource.insertHealth(_toEntityHealth(health));
      return const Right(null);
    } catch (e) {
      return Left(_errorHandler.handleError(e, StackTrace.current));
    }
  }

  @override
  ResultFuture<void> updateMemberHealthRecord(domain_health.MemberHealthEntity health) async {
    try {
      await _localDatasource.updateHealth(_toEntityHealth(health));
      return const Right(null);
    } catch (e) {
      return Left(_errorHandler.handleError(e, StackTrace.current));
    }
  }

  // Helper methods for mapping
  domain.MemberEntity _toDomainMember(MemberEntity entity) {
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

  MemberEntity _toEntityMember(domain.MemberEntity domain) {
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

  domain_profile.MemberProfileEntity _toDomainProfile(MemberProfileEntity entity) {
    return domain_profile.MemberProfileEntity(
      id: entity.id,
      memberId: entity.memberId,
      height: entity.height,
      weight: entity.weight,
      targetWeight: entity.targetWeight,
      fitnessGoal: entity.fitnessGoal,
      dietaryRestrictions: entity.dietaryRestrictions,
      medicalConditions: entity.medicalConditions,
      fitnessExperience: entity.fitnessExperience,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  MemberProfileEntity _toEntityProfile(domain_profile.MemberProfileEntity domain) {
    return MemberProfileEntity(
      id: domain.id,
      memberId: domain.memberId,
      height: domain.height,
      weight: domain.weight,
      targetWeight: domain.targetWeight,
      fitnessGoal: domain.fitnessGoal,
      dietaryRestrictions: domain.dietaryRestrictions,
      medicalConditions: domain.medicalConditions,
      fitnessExperience: domain.fitnessExperience,
      createdAt: domain.createdAt,
      updatedAt: domain.updatedAt,
    );
  }

  domain_health.MemberHealthEntity _toDomainHealth(MemberHealthEntity entity) {
    return domain_health.MemberHealthEntity(
      id: entity.id,
      memberId: entity.memberId,
      weight: entity.weight,
      bodyFatPercentage: entity.bodyFatPercentage,
      chestMeasurement: entity.chestMeasurement,
      waistMeasurement: entity.waistMeasurement,
      hipsMeasurement: entity.hipsMeasurement,
      bicepMeasurement: entity.bicepMeasurement,
      thighMeasurement: entity.thighMeasurement,
      photoPath: entity.photoPath,
      notes: entity.notes,
      recordedDate: entity.recordedDate,
      createdAt: entity.createdAt,
    );
  }

  MemberHealthEntity _toEntityHealth(domain_health.MemberHealthEntity domain) {
    return MemberHealthEntity(
      id: domain.id,
      memberId: domain.memberId,
      weight: domain.weight,
      bodyFatPercentage: domain.bodyFatPercentage,
      chestMeasurement: domain.chestMeasurement,
      waistMeasurement: domain.waistMeasurement,
      hipsMeasurement: domain.hipsMeasurement,
      bicepMeasurement: domain.bicepMeasurement,
      thighMeasurement: domain.thighMeasurement,
      photoPath: domain.photoPath,
      notes: domain.notes,
      recordedDate: domain.recordedDate,
      createdAt: domain.createdAt,
    );
  }
}