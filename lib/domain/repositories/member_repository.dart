import '../entities/member/member_entity.dart';
import '../entities/member/member_profile_entity.dart';
import '../entities/member/member_health_entity.dart';
import '../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class MemberRepository {
  ResultFuture<List<MemberEntity>> getAllMembers();
  ResultFuture<MemberEntity?> getMemberById(String id);
  ResultFuture<MemberEntity?> getMemberByEmail(String email);
  ResultFuture<MemberEntity?> getMemberByPhone(String phone);
  ResultFuture<List<MemberEntity>> getMembersByStatus(String status);
  ResultFuture<List<MemberEntity>> searchMembers(String query);
  ResultFuture<void> addMember(MemberEntity member);
  ResultFuture<void> updateMember(MemberEntity member);
  ResultFuture<void> deleteMember(String id);

  ResultFuture<MemberProfileEntity?> getMemberProfile(String memberId);
  ResultFuture<void> updateMemberProfile(MemberProfileEntity profile);

  ResultFuture<List<MemberHealthEntity>> getMemberHealthHistory(String memberId);
  ResultFuture<void> addMemberHealthRecord(MemberHealthEntity health);
  ResultFuture<void> updateMemberHealthRecord(MemberHealthEntity health);
}