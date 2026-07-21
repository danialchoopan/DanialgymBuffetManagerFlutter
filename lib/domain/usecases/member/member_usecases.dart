import 'package:dartz/dartz.dart';
import '../errors/failures.dart';
import '../repositories/member_repository.dart';

// Use Case: Add New Member
class AddNewMemberUseCase {
  final MemberRepository _repository;

  AddNewMemberUseCase(this._repository);

  Future<Either<Failure, MemberEntity>> call(AddNewMemberParams params) async {
    // Validate input
    if (params.phoneNumber.value.isEmpty) {
      return const Left(InvalidPhoneFormatFailure());
    }

    // Check for duplicate phone
    final existingMember = await _repository.getMemberByPhone(params.phoneNumber.value);
    return existingMember.fold(
      (failure) => Left(failure),
      (member) {
        if (member != null) {
          return const Left(DuplicatePhoneFailure());
        }
        // Create member entity and add
        // This is a simplified version - actual implementation would create the full entity
        return const Left(UnexpectedFailure(message: 'Not implemented'));
      },
    );
  }
}

class AddNewMemberParams {
  final String firstName;
  final String lastName;
  final PhoneNumber phoneNumber;
  final EmailAddress? email;
  final Gender gender;
  final DateTime birthDate;
  final String province;
  final String city;
  final String address;
  final String emergencyContactName;
  final PhoneNumber emergencyPhone;
  final Height height;
  final Weight weight;
  final FitnessGoal fitnessGoal;
  final String membershipType;
  final DateTime membershipExpiryDate;

  const AddNewMemberParams({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.email,
    required this.gender,
    required this.birthDate,
    required this.province,
    required this.city,
    required this.address,
    required this.emergencyContactName,
    required this.emergencyPhone,
    required this.height,
    required this.weight,
    required this.fitnessGoal,
    required this.membershipType,
    required this.membershipExpiryDate,
  });
}

// Use Case: Update Member Information
class UpdateMemberInformationUseCase {
  final MemberRepository _repository;

  UpdateMemberInformationUseCase(this._repository);

  Future<Either<Failure, MemberEntity>> call(MemberEntity member) async {
    return await _repository.updateMember(member);
  }
}

// Use Case: Check Member Payment Status
class CheckMemberPaymentStatusUseCase {
  final MemberRepository _repository;

  CheckMemberPaymentStatusUseCase(this._repository);

  Future<Either<Failure, PaymentStatus>> call(String memberId) async {
    final summaryResult = await _repository.getMemberFinancialSummary(memberId);
    return summaryResult.fold(
      (failure) => Left(failure),
      (summary) {
        if (summary.outstandingBalance.amount <= 0) {
          return const Right(PaymentStatus.paid);
        }
        if (summary.outstandingBalance.amount < summary.totalPaid.amount * 0.5) {
          return const Right(PaymentStatus.partial);
        }
        return const Right(PaymentStatus.pending);
      },
    );
  }
}

// Use Case: Get Member Financial Summary
class GetMemberFinancialSummaryUseCase {
  final MemberRepository _repository;

  GetMemberFinancialSummaryUseCase(this._repository);

  Future<Either<Failure, MemberFinancialSummaryEntity>> call(String memberId) async {
    return await _repository.getMemberFinancialSummary(memberId);
  }
}

// Use Case: Renew Membership
class RenewMembershipUseCase {
  final MemberRepository _repository;

  RenewMembershipUseCase(this._repository);

  Future<Either<Failure, MemberEntity>> call(RenewMembershipParams params) async {
    final memberResult = await _repository.getMemberById(params.memberId);
    return memberResult.fold(
      (failure) => Left(failure),
      (member) async {
        if (member == null) {
          return const Left(MemberNotFoundFailure());
        }
        if (!member.canRenewMembership) {
          return const Left(ValidationFailure(message: 'Member is not eligible for renewal'));
        }
        return await _repository.renewMembership(params.memberId, params.newExpiryDate);
      },
    );
  }
}

class RenewMembershipParams {
  final String memberId;
  final DateTime newExpiryDate;

  const RenewMembershipParams({
    required this.memberId,
    required this.newExpiryDate,
  });
}

// Use Case: Search Members
class SearchMembersUseCase {
  final MemberRepository _repository;

  SearchMembersUseCase(this._repository);

  Future<Either<Failure, List<MemberEntity>>> call(SearchMembersParams params) async {
    if (params.query.isEmpty) {
      return await _repository.getAllMembers();
    }
    return await _repository.searchMembers(params.query);
  }
}

class SearchMembersParams {
  final String query;
  final MembershipStatus? status;
  final FitnessGoal? fitnessGoal;

  const SearchMembersParams({
    required this.query,
    this.status,
    this.fitnessGoal,
  });
}

// Use Case: Get Expiring Members
class GetExpiringMembersUseCase {
  final MemberRepository _repository;

  GetExpiringMembersUseCase(this._repository);

  Future<Either<Failure, List<MemberEntity>>> call(int days) async {
    return await _repository.getMembersExpiringSoon(days);
  }
}

// Use Case: Record Member Payment
class RecordMemberPaymentUseCase {
  final MemberRepository _repository;

  RecordMemberPaymentUseCase(this._repository);

  Future<Either<Failure, MemberPaymentEntity>> call(MemberPaymentEntity payment) async {
    return await _repository.addPayment(payment);
  }
}

// Use Case: Get Member Payment History
class GetMemberPaymentHistoryUseCase {
  final MemberRepository _repository;

  GetMemberPaymentHistoryUseCase(this._repository);

  Future<Either<Failure, List<MemberPaymentEntity>>> call(String memberId) async {
    return await _repository.getMemberPaymentHistory(memberId);
  }
}

// Use Case: Block Member
class BlockMemberUseCase {
  final MemberRepository _repository;

  BlockMemberUseCase(this._repository);

  Future<Either<Failure, void>> call(BlockMemberParams params) async {
    return await _repository.blockMember(params.memberId, params.reason);
  }
}

class BlockMemberParams {
  final String memberId;
  final String reason;

  const BlockMemberParams({
    required this.memberId,
    required this.reason,
  });
}

// Use Case: Unblock Member
class UnblockMemberUseCase {
  final MemberRepository _repository;

  UnblockMemberUseCase(this._repository);

  Future<Either<Failure, void>> call(String memberId) async {
    return await _repository.unblockMember(memberId);
  }
}

// Placeholder imports for value objects
import '../entities/value_objects/enums.dart';
import '../entities/member/member_entity.dart';
import '../entities/member/member_payment_entity.dart';
import '../entities/value_objects/value_objects.dart';