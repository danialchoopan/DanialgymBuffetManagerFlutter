import 'package:floor/floor.dart';
import '../../../core/database/entities/member/member_entity.dart';
import '../../../core/database/entities/member/member_profile_entity.dart';
import '../../../core/database/entities/member/member_health_entity.dart';

class MemberLocalDatasource {
  final dynamic _database;

  MemberLocalDatasource(this._database);

  Future<List<MemberEntity>> getAllMembers() async {
    return await _database.memberDao.getAllMembers();
  }

  Future<MemberEntity?> getMemberById(String id) async {
    return await _database.memberDao.getMemberById(id);
  }

  Future<MemberEntity?> getMemberByEmail(String email) async {
    return await _database.memberDao.getMemberByEmail(email);
  }

  Future<MemberEntity?> getMemberByPhone(String phone) async {
    return await _database.memberDao.getMemberByPhone(phone);
  }

  Future<List<MemberEntity>> getMembersByStatus(String status) async {
    return await _database.memberDao.getMembersByStatus(status);
  }

  Future<List<MemberEntity>> searchMembers(String query) async {
    return await _database.memberDao.searchMembers(query);
  }

  Future<void> insertMember(MemberEntity member) async {
    await _database.memberDao.insertMember(member);
  }

  Future<void> updateMember(MemberEntity member) async {
    await _database.memberDao.updateMember(member);
  }

  Future<void> deleteMember(MemberEntity member) async {
    await _database.memberDao.deleteMember(member);
  }

  Future<void> softDeleteMember(String id) async {
    await _database.memberDao.softDeleteMember(id);
  }

  // Profile methods
  Future<MemberProfileEntity?> getProfileByMemberId(String memberId) async {
    return await _database.memberProfileDao.getProfileByMemberId(memberId);
  }

  Future<void> insertProfile(MemberProfileEntity profile) async {
    await _database.memberProfileDao.insertProfile(profile);
  }

  Future<void> updateProfile(MemberProfileEntity profile) async {
    await _database.memberProfileDao.updateProfile(profile);
  }

  // Health methods
  Future<List<MemberHealthEntity>> getHealthByMemberId(String memberId) async {
    return await _database.memberHealthDao.getHealthByMemberId(memberId);
  }

  Future<void> insertHealth(MemberHealthEntity health) async {
    await _database.memberHealthDao.insertHealth(health);
  }

  Future<void> updateHealth(MemberHealthEntity health) async {
    await _database.memberHealthDao.updateHealth(health);
  }
}