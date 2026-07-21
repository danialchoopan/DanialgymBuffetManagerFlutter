import 'package:dartz/dartz.dart';
import '../entities/member/member_entity.dart';
import '../entities/member/member_payment_entity.dart';
import '../entities/member/member_health_entity.dart';
import '../entities/value_objects/enums.dart';
import '../errors/failures.dart';

abstract class MemberRepository {
  // CRUD Operations
  Future<Either<Failure, MemberEntity>> addMember(MemberEntity member);
  Future<Either<Failure, MemberEntity>> updateMember(MemberEntity member);
  Future<Either<Failure, void>> deleteMember(String id);
  
  // Query Operations
  Future<Either<Failure, MemberEntity?>> getMemberById(String id);
  Future<Either<Failure, MemberEntity?>> getMemberByPhone(String phone);
  Future<Either<Failure, List<MemberEntity>>> getAllMembers();
  Future<Either<Failure, List<MemberEntity>>> getActiveMembers();
  Future<Either<Failure, List<MemberEntity>>> getMembersByStatus(MembershipStatus status);
  Future<Either<Failure, List<MemberEntity>>> searchMembers(String query);
  Future<Either<Failure, List<MemberEntity>>> getMembersExpiringSoon(int days);
  Future<Either<Failure, List<MemberEntity>>> getMembersWithOverduePayments();
  
  // Membership Operations
  Future<Either<Failure, void>> updateMembershipStatus(String memberId, MembershipStatus status);
  Future<Either<Failure, MemberEntity>> renewMembership(String memberId, DateTime newExpiryDate);
  Future<Either<Failure, void>> blockMember(String memberId, String reason);
  Future<Either<Failure, void>> unblockMember(String memberId);
  
  // Payment Operations
  Future<Either<Failure, List<MemberPaymentEntity>>> getMemberPaymentHistory(String memberId);
  Future<Either<Failure, MemberPaymentEntity>> addPayment(MemberPaymentEntity payment);
  Future<Either<Failure, MemberPaymentEntity>> updatePayment(MemberPaymentEntity payment);
  Future<Either<Failure, void>> deletePayment(String paymentId);
  Future<Either<Failure, List<MemberPaymentEntity>>> getPaymentsByStatus(PaymentStatus status);
  Future<Either<Failure, List<MemberPaymentEntity>>> getPaymentsByDateRange(DateTime start, DateTime end);
  Future<Either<Failure, double>> getTotalPaymentsByMember(String memberId);
  Future<Either<Failure, double>> getOutstandingBalance(String memberId);
  
  // Health Operations
  Future<Either<Failure, List<MemberHealthEntity>>> getMemberHealthHistory(String memberId);
  Future<Either<Failure, MemberHealthEntity>> addHealthRecord(MemberHealthEntity health);
  Future<Either<Failure, MemberHealthEntity>> updateHealthRecord(MemberHealthEntity health);
  Future<Either<Failure, MemberHealthEntity?>> getLatestHealthRecord(String memberId);
  
  // Financial Summary
  Future<Either<Failure, MemberFinancialSummaryEntity>> getMemberFinancialSummary(String memberId);
  
  // Statistics
  Future<Either<Failure, int>> getMemberCount();
  Future<Either<Failure, int>> getActiveMemberCount();
  Future<Either<Failure, Map<String, int>>> getMemberCountByStatus();
  Future<Either<Failure, List<MemberEntity>>> getRecentMembers(int limit);
  Future<Either<Failure, List<MemberEntity>>> getBirthdayMembers(int month);
}