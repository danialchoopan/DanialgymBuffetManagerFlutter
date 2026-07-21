import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/member/member_entity.dart';
import '../../../domain/entities/member/member_payment_entity.dart';
import '../../../domain/entities/member/member_health_entity.dart';
import '../../../domain/entities/value_objects/enums.dart';
import '../../../domain/entities/value_objects/value_objects.dart';

// ============================================================
// MEMBER STATES
// ============================================================

abstract class MemberState extends Equatable {
  const MemberState();

  @override
  List<Object?> get props => [];
}

class MemberInitial extends MemberState {
  const MemberInitial();
}

class MemberLoading extends MemberState {
  final String? message;

  const MemberLoading({this.message});

  @override
  List<Object?> get props => [message];
}

class MemberLoaded extends MemberState {
  final List<MemberEntity> members;
  final int totalCount;
  final int currentPage;
  final bool hasMore;
  final String? searchQuery;
  final MembershipStatus? filterStatus;

  const MemberLoaded({
    required this.members,
    required this.totalCount,
    this.currentPage = 1,
    this.hasMore = false,
    this.searchQuery,
    this.filterStatus,
  });

  @override
  List<Object?> get props => [members, totalCount, currentPage, hasMore, searchQuery, filterStatus];
}

class MemberDetailLoaded extends MemberState {
  final MemberEntity member;
  final MemberHealthEntity? latestHealth;
  final List<MemberPaymentEntity> recentPayments;
  final double totalPaid;
  final double outstandingBalance;

  const MemberDetailLoaded({
    required this.member,
    this.latestHealth,
    this.recentPayments = const [],
    this.totalPaid = 0,
    this.outstandingBalance = 0,
  });

  @override
  List<Object?> get props => [member, latestHealth, recentPayments, totalPaid, outstandingBalance];
}

class MemberSearchResults extends MemberState {
  final List<MemberEntity> results;
  final String query;

  const MemberSearchResults({
    required this.results,
    required this.query,
  });

  @override
  List<Object?> get props => [results, query];
}

class MemberPaymentHistoryLoaded extends MemberState {
  final String memberId;
  final List<MemberPaymentEntity> payments;
  final double totalPaid;
  final double outstandingBalance;

  const MemberPaymentHistoryLoaded({
    required this.memberId,
    required this.payments,
    required this.totalPaid,
    required this.outstandingBalance,
  });

  @override
  List<Object?> get props => [memberId, payments, totalPaid, outstandingBalance];
}

class MemberFinancialSummaryLoaded extends MemberState {
  final String memberId;
  final double totalPaid;
  final double totalDue;
  final double outstandingBalance;
  final DateTime? lastPaymentDate;
  final DateTime? nextPaymentDate;
  final PaymentStatus paymentStatus;

  const MemberFinancialSummaryLoaded({
    required this.memberId,
    required this.totalPaid,
    required this.totalDue,
    required this.outstandingBalance,
    this.lastPaymentDate,
    this.nextPaymentDate,
    required this.paymentStatus,
  });

  @override
  List<Object?> get props => [memberId, totalPaid, totalDue, outstandingBalance, lastPaymentDate, nextPaymentDate, paymentStatus];
}

class MemberOperationSuccess extends MemberState {
  final String message;
  final String? memberId;

  const MemberOperationSuccess({
    required this.message,
    this.memberId,
  });

  @override
  List<Object?> get props => [message, memberId];
}

class MemberOperationFailed extends MemberState {
  final String message;
  final String? code;

  const MemberOperationFailed({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

class MemberEmptyState extends MemberState {
  final String message;

  const MemberEmptyState({this.message = 'هیچ عضوی یافت نشد'});

  @override
  List<Object?> get props => [message];
}

class MemberOverdueLoaded extends MemberState {
  final List<MemberEntity> overdueMembers;
  final double totalOverdueAmount;

  const MemberOverdueLoaded({
    required this.overdueMembers,
    required this.totalOverdueAmount,
  });

  @override
  List<Object?> get props => [overdueMembers, totalOverdueAmount];
}

// ============================================================
// MEMBER EVENTS
// ============================================================

abstract class MemberEvent extends Equatable {
  const MemberEvent();

  @override
  List<Object?> get props => [];
}

class FetchMembersRequested extends MemberEvent {
  final int page;
  final int limit;
  final MembershipStatus? status;
  final String? searchQuery;

  const FetchMembersRequested({
    this.page = 1,
    this.limit = 20,
    this.status,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [page, limit, status, searchQuery];
}

class FetchMemberByIdRequested extends MemberEvent {
  final String memberId;

  const FetchMemberByIdRequested({required this.memberId});

  @override
  List<Object?> get props => [memberId];
}

class FetchMemberByPhoneRequested extends MemberEvent {
  final String phone;

  const FetchMemberByPhoneRequested({required this.phone});

  @override
  List<Object?> get props => [phone];
}

class AddMemberRequested extends MemberEvent {
  final String firstName;
  final String lastName;
  final PhoneNumber phone;
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

  const AddMemberRequested({
    required this.firstName,
    required this.lastName,
    required this.phone,
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

  @override
  List<Object?> get props => [firstName, lastName, phone, email, gender, birthDate, membershipType];
}

class UpdateMemberRequested extends MemberEvent {
  final MemberEntity member;

  const UpdateMemberRequested({required this.member});

  @override
  List<Object?> get props => [member];
}

class DeleteMemberRequested extends MemberEvent {
  final String memberId;
  final String reason;

  const DeleteMemberRequested({
    required this.memberId,
    required this.reason,
  });

  @override
  List<Object?> get props => [memberId, reason];
}

class SearchMembersRequested extends MemberEvent {
  final String query;

  const SearchMembersRequested({required this.query});

  @override
  List<Object?> get props => [query];
}

class FilterMembersRequested extends MemberEvent {
  final MembershipStatus? status;
  final DateTime? startDate;
  final DateTime? endDate;
  final FitnessGoal? fitnessGoal;

  const FilterMembersRequested({
    this.status,
    this.startDate,
    this.endDate,
    this.fitnessGoal,
  });

  @override
  List<Object?> get props => [status, startDate, endDate, fitnessGoal];
}

class SortMembersRequested extends MemberEvent {
  final String sortBy;
  final bool ascending;

  const SortMembersRequested({
    required this.sortBy,
    this.ascending = true,
  });

  @override
  List<Object?> get props => [sortBy, ascending];
}

class FetchMemberPaymentsRequested extends MemberEvent {
  final String memberId;

  const FetchMemberPaymentsRequested({required this.memberId});

  @override
  List<Object?> get props => [memberId];
}

class AddPaymentRequested extends MemberEvent {
  final String memberId;
  final Money amount;
  final PaymentType paymentType;
  final PaymentMethod paymentMethod;
  final String? description;
  final DateTime? periodStartDate;
  final DateTime? periodEndDate;

  const AddPaymentRequested({
    required this.memberId,
    required this.amount,
    required this.paymentType,
    required this.paymentMethod,
    this.description,
    this.periodStartDate,
    this.periodEndDate,
  });

  @override
  List<Object?> get props => [memberId, amount, paymentType, paymentMethod, description];
}

class FetchFinancialSummaryRequested extends MemberEvent {
  final String memberId;

  const FetchFinancialSummaryRequested({required this.memberId});

  @override
  List<Object?> get props => [memberId];
}

class CheckPaymentStatusRequested extends MemberEvent {
  final String memberId;

  const CheckPaymentStatusRequested({required this.memberId});

  @override
  List<Object?> get props => [memberId];
}

class GetOverdueMembersRequested extends MemberEvent {
  const GetOverdueMembersRequested();
}

class RefreshMembersRequested extends MemberEvent {
  const RefreshMembersRequested();
}

class ExportMembersRequested extends MemberEvent {
  final String format; // CSV or PDF

  const ExportMembersRequested({required this.format});

  @override
  List<Object?> get props => [format];
}

class UpdateMembershipStatusRequested extends MemberEvent {
  final String memberId;
  final MembershipStatus newStatus;
  final String? reason;

  const UpdateMembershipStatusRequested({
    required this.memberId,
    required this.newStatus,
    this.reason,
  });

  @override
  List<Object?> get props => [memberId, newStatus, reason];
}

class RenewMembershipRequested extends MemberEvent {
  final String memberId;
  final String membershipType;
  final DateTime newExpiryDate;
  final Money paymentAmount;

  const RenewMembershipRequested({
    required this.memberId,
    required this.membershipType,
    required this.newExpiryDate,
    required this.paymentAmount,
  });

  @override
  List<Object?> get props => [memberId, membershipType, newExpiryDate, paymentAmount];
}

class BlockMemberRequested extends MemberEvent {
  final String memberId;
  final String reason;

  const BlockMemberRequested({
    required this.memberId,
    required this.reason,
  });

  @override
  List<Object?> get props => [memberId, reason];
}

class UnblockMemberRequested extends MemberEvent {
  final String memberId;

  const UnblockMemberRequested({required this.memberId});

  @override
  List<Object?> get props => [memberId];
}

// ============================================================
// MEMBER BLOC
// ============================================================

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  // Dependencies would be injected via constructor
  // final MemberRepository _memberRepository;
  // final PaymentRepository _paymentRepository;

  MemberBloc() : super(const MemberInitial()) {
    on<FetchMembersRequested>(_onFetchMembers);
    on<FetchMemberByIdRequested>(_onFetchMemberById);
    on<FetchMemberByPhoneRequested>(_onFetchMemberByPhone);
    on<AddMemberRequested>(_onAddMember);
    on<UpdateMemberRequested>(_onUpdateMember);
    on<DeleteMemberRequested>(_onDeleteMember);
    on<SearchMembersRequested>(_onSearchMembers);
    on<FilterMembersRequested>(_onFilterMembers);
    on<SortMembersRequested>(_onSortMembers);
    on<FetchMemberPaymentsRequested>(_onFetchMemberPayments);
    on<AddPaymentRequested>(_onAddPayment);
    on<FetchFinancialSummaryRequested>(_onFetchFinancialSummary);
    on<CheckPaymentStatusRequested>(_onCheckPaymentStatus);
    on<GetOverdueMembersRequested>(_onGetOverdueMembers);
    on<RefreshMembersRequested>(_onRefreshMembers);
    on<ExportMembersRequested>(_onExportMembers);
    on<UpdateMembershipStatusRequested>(_onUpdateMembershipStatus);
    on<RenewMembershipRequested>(_onRenewMembership);
    on<BlockMemberRequested>(_onBlockMember);
    on<UnblockMemberRequested>(_onUnblockMember);
  }

  // ============================================================
  // EVENT HANDLERS
  // ============================================================

  Future<void> _onFetchMembers(
    FetchMembersRequested event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading(message: 'در حال بارگذاری اعضا...'));

    try {
      // Fetch members from repository
      final members = await _fetchMembersFromRepository(
        page: event.page,
        limit: event.limit,
        status: event.status,
        searchQuery: event.searchQuery,
      );

      if (members.isEmpty) {
        emit(const MemberEmptyState());
        return;
      }

      emit(MemberLoaded(
        members: members,
        totalCount: members.length,
        currentPage: event.page,
        hasMore: members.length >= event.limit,
        searchQuery: event.searchQuery,
        filterStatus: event.status,
      ));
    } catch (e) {
      emit(MemberOperationFailed(
        message: 'خطا در بارگذاری اعضا.',
        code: 'FETCH_MEMBERS_ERROR',
      ));
    }
  }

  Future<void> _onFetchMemberById(
    FetchMemberByIdRequested event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading(message: 'در حال بارگذاری اطلاعات عضو...'));

    try {
      final member = await _fetchMemberById(event.memberId);

      if (member == null) {
        emit(const MemberOperationFailed(
          message: 'عضو مورد نظر یافت نشد.',
          code: 'MEMBER_NOT_FOUND',
        ));
        return;
      }

      // Fetch related data
      final latestHealth = await _fetchLatestHealth(member.id);
      final recentPayments = await _fetchMemberPayments(member.id, limit: 5);
      final totalPaid = await _calculateTotalPaid(member.id);

      emit(MemberDetailLoaded(
        member: member,
        latestHealth: latestHealth,
        recentPayments: recentPayments,
        totalPaid: totalPaid,
        outstandingBalance: member.outstandingBalance,
      ));
    } catch (e) {
      emit(MemberOperationFailed(
        message: 'خطا در بارگذاری اطلاعات عضو.',
        code: 'FETCH_MEMBER_ERROR',
      ));
    }
  }

  Future<void> _onFetchMemberByPhone(
    FetchMemberByPhoneRequested event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading(message: 'در حال جستجو...'));

    try {
      final member = await _fetchMemberByPhone(event.phone);

      if (member == null) {
        emit(const MemberOperationFailed(
          message: 'عضوی با این شماره تلفن یافت نشد.',
          code: 'MEMBER_NOT_FOUND',
        ));
        return;
      }

      add(FetchMemberByIdRequested(memberId: member.id));
    } catch (e) {
      emit(MemberOperationFailed(
        message: 'خطا در جستجو.',
        code: 'SEARCH_ERROR',
      ));
    }
  }

  Future<void> _onAddMember(
    AddMemberRequested event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading(message: 'در حال ثبت عضو جدید...'));

    try {
      // Validate phone uniqueness
      final existingMember = await _fetchMemberByPhone(event.phone.value);
      if (existingMember != null) {
        emit(const MemberOperationFailed(
          message: 'عضوی با این شماره تلفن قبلاً ثبت شده است.',
          code: 'DUPLICATE_PHONE',
        ));
        return;
      }

      // Validate age (minimum 12 years)
      final age = DateTime.now().year - event.birthDate.year;
      if (age < 12) {
        emit(const MemberOperationFailed(
          message: 'حداقل سن عضویت 12 سال است.',
          code: 'MINIMUM_AGE',
        ));
        return;
      }

      // Create member entity
      final member = MemberEntity(
        id: _generateMemberId(),
        firstName: event.firstName,
        lastName: event.lastName,
        phoneNumber: event.phone,
        email: event.email,
        gender: event.gender,
        birthDate: event.birthDate,
        province: event.province,
        city: event.city,
        address: event.address,
        emergencyContactName: event.emergencyContactName,
        emergencyPhone: event.emergencyPhone,
        height: event.height,
        weight: event.weight,
        fitnessGoal: event.fitnessGoal,
        joinDate: DateTime.now(),
        membershipStatus: MembershipStatus.active,
        membershipExpiryDate: event.membershipExpiryDate,
        membershipType: event.membershipType,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Save to repository
      await _saveMember(member);

      emit(MemberOperationSuccess(
        message: 'عضو جدید با موفقیت ثبت شد.',
        memberId: member.id,
      ));
    } catch (e) {
      emit(MemberOperationFailed(
        message: 'خطا در ثبت عضو جدید.',
        code: 'ADD_MEMBER_ERROR',
      ));
    }
  }

  Future<void> _onUpdateMember(
    UpdateMemberRequested event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading(message: 'در حال بروزرسانی اطلاعات...'));

    try {
      // Validate phone uniqueness (excluding current member)
      final existingMember = await _fetchMemberByPhone(event.member.phoneNumber.value);
      if (existingMember != null && existingMember.id != event.member.id) {
        emit(const MemberOperationFailed(
          message: 'عضوی با این شماره تلفن قبلاً ثبت شده است.',
          code: 'DUPLICATE_PHONE',
        ));
        return;
      }

      // Update member
      final updatedMember = event.member.copyWith(updatedAt: DateTime.now());
      await _updateMember(updatedMember);

      emit(const MemberOperationSuccess(
        message: 'اطلاعات عضو با موفقیت بروزرسانی شد.',
      ));
    } catch (e) {
      emit(MemberOperationFailed(
        message: 'خطا در بروزرسانی اطلاعات.',
        code: 'UPDATE_MEMBER_ERROR',
      ));
    }
  }

  Future<void> _onDeleteMember(
    DeleteMemberRequested event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading(message: 'در حال حذف عضو...'));

    try {
      // Check for outstanding balance
      final balance = await _calculateOutstandingBalance(event.memberId);
      if (balance > 0) {
        emit(MemberOperationFailed(
          message: 'عضو دارای بدهی است. لطفاً ابتدا بدهی را تسویه کنید.',
          code: 'OUTSTANDING_BALANCE',
        ));
        return;
      }

      // Soft delete (mark as inactive)
      await _deleteMember(event.memberId);

      emit(const MemberOperationSuccess(
        message: 'عضو با موفقیت حذف شد.',
      ));
    } catch (e) {
      emit(MemberOperationFailed(
        message: 'خطا در حذف عضو.',
        code: 'DELETE_MEMBER_ERROR',
      ));
    }
  }

  Future<void> _onSearchMembers(
    SearchMembersRequested event,
    Emitter<MemberState> emit,
  ) async {
    if (event.query.isEmpty) {
      add(const FetchMembersRequested());
      return;
    }

    emit(const MemberLoading(message: 'در حال جستجو...'));

    try {
      final results = await _searchMembers(event.query);

      if (results.isEmpty) {
        emit(const MemberEmptyState(message: 'نتیجه‌ای یافت نشد.'));
        return;
      }

      emit(MemberSearchResults(
        results: results,
        query: event.query,
      ));
    } catch (e) {
      emit(MemberOperationFailed(
        message: 'خطا در جستجو.',
        code: 'SEARCH_ERROR',
      ));
    }
  }

  Future<void> _onFilterMembers(
    FilterMembersRequested event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading(message: 'در حال فیلتر کردن...'));

    try {
      final members = await _filterMembers(
        status: event.status,
        startDate: event.startDate,
        endDate: event.endDate,
        fitnessGoal: event.fitnessGoal,
      );

      if (members.isEmpty) {
        emit(const MemberEmptyState(message: 'عضوی با فیلتر مورد نظر یافت نشد.'));
        return;
      }

      emit(MemberLoaded(
        members: members,
        totalCount: members.length,
        filterStatus: event.status,
      ));
    } catch (e) {
      emit(MemberOperationFailed(
        message: 'خطا در فیلتر کردن.',
        code: 'FILTER_ERROR',
      ));
    }
  }

  Future<void> _onSortMembers(
    SortMembersRequested event,
    Emitter<MemberState> emit,
  ) async {
    final currentState = state;
    if (currentState is! MemberLoaded) return;

    try {
      final sortedMembers = _sortMembers(
        currentState.members,
        event.sortBy,
        event.ascending,
      );

      emit(MemberLoaded(
        members: sortedMembers,
        totalCount: currentState.totalCount,
        currentPage: currentState.currentPage,
        hasMore: currentState.hasMore,
      ));
    } catch (e) {
      emit(MemberOperationFailed(
        message: 'خطا در مرتب‌سازی.',
        code: 'SORT_ERROR',
      ));
    }
  }

  Future<void> _onFetchMemberPayments(
    FetchMemberPaymentsRequested event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading(message: 'در حال بارگذاری تاریخچه پرداخت...'));

    try {
      final payments = await _fetchMemberPayments(event.memberId);
      final totalPaid = await _calculateTotalPaid(event.memberId);
      final outstandingBalance = await _calculateOutstandingBalance(event.memberId);

      emit(MemberPaymentHistoryLoaded(
        memberId: event.memberId,
        payments: payments,
        totalPaid: totalPaid,
        outstandingBalance: outstandingBalance,
      ));
    } catch (e) {
      emit(MemberOperationFailed(
        message: 'خطا در بارگذاری تاریخچه پرداخت.',
        code: 'FETCH_PAYMENTS_ERROR',
      ));
    }
  }

  Future<void> _onAddPayment(
    AddPaymentRequested event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading(message: 'در حال ثبت پرداخت...'));

    try {
      // Validate amount
      if (event.amount.amount <= 0) {
        emit(const MemberOperationFailed(
          message: 'مبلغ پرداخت باید بیشتر از صفر باشد.',
          code: 'INVALID_AMOUNT',
        ));
        return;
      }

      // Create payment entity
      final payment = MemberPaymentEntity(
        id: _generatePaymentId(),
        memberId: event.memberId,
        amount: event.amount,
        paymentDate: DateTime.now(),
        paymentType: event.paymentType,
        paymentMethod: event.paymentMethod,
        paymentStatus: PaymentStatus.paid,
        description: event.description,
        periodStartDate: event.periodStartDate,
        periodEndDate: event.periodEndDate,
        recordedAt: DateTime.now(),
      );

      // Save payment
      await _savePayment(payment);

      // Update member's total paid
      await _updateMemberFinancials(event.memberId);

      emit(const MemberOperationSuccess(
        message: 'پرداخت با موفقیت ثبت شد.',
      ));
    } catch (e) {
      emit(MemberOperationFailed(
        message: 'خطا در ثبت پرداخت.',
        code: 'ADD_PAYMENT_ERROR',
      ));
    }
  }

  Future<void> _onFetchFinancialSummary(
    FetchFinancialSummaryRequested event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading(message: 'در حال بارگذاری خلاصه مالی...'));

    try {
      final summary = await _getFinancialSummary(event.memberId);

      emit(MemberFinancialSummaryLoaded(
        memberId: event.memberId,
        totalPaid: summary['totalPaid'],
        totalDue: summary['totalDue'],
        outstandingBalance: summary['outstandingBalance'],
        lastPaymentDate: summary['lastPaymentDate'],
        nextPaymentDate: summary['nextPaymentDate'],
        paymentStatus: summary['paymentStatus'],
      ));
    } catch (e) {
      emit(MemberOperationFailed(
        message: 'خطا در بارگذاری خلاصه مالی.',
        code: 'FETCH_SUMMARY_ERROR',
      ));
    }
  }

  Future<void> _onCheckPaymentStatus(
    CheckPaymentStatusRequested event,
    Emitter<MemberState> emit,
  ) async {
    try {
      final outstandingBalance = await _calculateOutstandingBalance(event.memberId);

      if (outstandingBalance <= 0) {
        emit(const MemberOperationSuccess(
          message: 'پرداخت عضو تسویه شده است.',
        ));
      } else {
        emit(MemberOperationSuccess(
          message: 'مبلغ باقیمانده: ${outstandingBalance.toStringAsFixed(0)} تومان',
        ));
      }
    } catch (e) {
      emit(MemberOperationFailed(
        message: 'خطا در بررسی وضعیت پرداخت.',
        code: 'CHECK_PAYMENT_ERROR',
      ));
    }
  }

  Future<void> _onGetOverdueMembers(
    GetOverdueMembersRequested event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading(message: 'در حال بارگذاری اعضای بدهکار...'));

    try {
      final overdueMembers = await _getOverdueMembers();
      final totalOverdue = overdueMembers.fold<double>(
        0,
        (sum, member) => sum + member.outstandingBalance,
      );

      emit(MemberOverdueLoaded(
        overdueMembers: overdueMembers,
        totalOverdueAmount: totalOverdue,
      ));
    } catch (e) {
      emit(MemberOperationFailed(
        message: 'خطا در بارگذاری اعضای بدهکار.',
        code: 'FETCH_OVERDUE_ERROR',
      ));
    }
  }

  Future<void> _onRefreshMembers(
    RefreshMembersRequested event,
    Emitter<MemberState> emit,
  ) async {
    add(const FetchMembersRequested());
  }

  Future<void> _onExportMembers(
    ExportMembersRequested event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading(message: 'در حال خروجی گرفتن...'));

    try {
      // Get current members
      final currentState = state;
      if (currentState is! MemberLoaded) {
        add(const FetchMembersRequested());
        return;
      }

      // Export based on format
      if (event.format == 'CSV') {
        await _exportToCSV(currentState.members);
      } else if (event.format == 'PDF') {
        await _exportToPDF(currentState.members);
      }

      emit(const MemberOperationSuccess(
        message: 'خروجی با موفقیت ایجاد شد.',
      ));
    } catch (e) {
      emit(MemberOperationFailed(
        message: 'خطا در خروجی گرفتن.',
        code: 'EXPORT_ERROR',
      ));
    }
  }

  Future<void> _onUpdateMembershipStatus(
    UpdateMembershipStatusRequested event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading(message: 'در حال بروزرسانی وضعیت عضویت...'));

    try {
      await _updateMembershipStatus(event.memberId, event.newStatus);

      emit(const MemberOperationSuccess(
        message: 'وضعیت عضویت با موفقیت بروزرسانی شد.',
      ));
    } catch (e) {
      emit(MemberOperationFailed(
        message: 'خطا در بروزرسانی وضعیت عضویت.',
        code: 'UPDATE_STATUS_ERROR',
      ));
    }
  }

  Future<void> _onRenewMembership(
    RenewMembershipRequested event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading(message: 'در حال تمدید عضویت...'));

    try {
      // Record payment
      final payment = MemberPaymentEntity(
        id: _generatePaymentId(),
        memberId: event.memberId,
        amount: event.paymentAmount,
        paymentDate: DateTime.now(),
        paymentType: PaymentType.membership,
        paymentMethod: PaymentMethod.cash,
        paymentStatus: PaymentStatus.paid,
        description: 'تمدید عضویت - ${event.membershipType}',
        periodStartDate: DateTime.now(),
        periodEndDate: event.newExpiryDate,
        recordedAt: DateTime.now(),
      );

      await _savePayment(payment);

      // Update membership
      await _updateMembership(
        event.memberId,
        event.newExpiryDate,
        event.membershipType,
      );

      emit(const MemberOperationSuccess(
        message: 'عضویت با موفقیت تمدید شد.',
      ));
    } catch (e) {
      emit(MemberOperationFailed(
        message: 'خطا در تمدید عضویت.',
        code: 'RENEW_MEMBERSHIP_ERROR',
      ));
    }
  }

  Future<void> _onBlockMember(
    BlockMemberRequested event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading(message: 'در حال مسدود کردن عضو...'));

    try {
      await _blockMember(event.memberId, event.reason);

      emit(const MemberOperationSuccess(
        message: 'عضو با موفقیت مسدود شد.',
      ));
    } catch (e) {
      emit(MemberOperationFailed(
        message: 'خطا در مسدود کردن عضو.',
        code: 'BLOCK_MEMBER_ERROR',
      ));
    }
  }

  Future<void> _onUnblockMember(
    UnblockMemberRequested event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading(message: 'در حال رفع مسدودیت عضو...'));

    try {
      await _unblockMember(event.memberId);

      emit(const MemberOperationSuccess(
        message: 'عضو با موفقیت از مسدودیت خارج شد.',
      ));
    } catch (e) {
      emit(MemberOperationFailed(
        message: 'خطا در رفع مسدودیت عضو.',
        code: 'UNBLOCK_MEMBER_ERROR',
      ));
    }
  }

  // ============================================================
  // PRIVATE HELPER METHODS
  // ============================================================

  String _generateMemberId() {
    final now = DateTime.now();
    final datePart = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    final randomPart = DateTime.now().millisecondsSinceEpoch.toString().substring(8);
    return 'MEM$datePart$randomPart';
  }

  String _generatePaymentId() {
    final now = DateTime.now();
    final datePart = '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    final randomPart = DateTime.now().millisecondsSinceEpoch.toString().substring(8);
    return 'PAY$datePart$randomPart';
  }

  // Placeholder methods - would use actual repositories
  Future<List<MemberEntity>> _fetchMembersFromRepository({
    int page = 1,
    int limit = 20,
    MembershipStatus? status,
    String? searchQuery,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [];
  }

  Future<MemberEntity?> _fetchMemberById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return null;
  }

  Future<MemberEntity?> _fetchMemberByPhone(String phone) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return null;
  }

  Future<MemberHealthEntity?> _fetchLatestHealth(String memberId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return null;
  }

  Future<List<MemberPaymentEntity>> _fetchMemberPayments(String memberId, {int? limit}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [];
  }

  Future<double> _calculateTotalPaid(String memberId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return 0;
  }

  Future<double> _calculateOutstandingBalance(String memberId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return 0;
  }

  Future<void> _saveMember(MemberEntity member) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<void> _updateMember(MemberEntity member) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<void> _deleteMember(String memberId) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<List<MemberEntity>> _searchMembers(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [];
  }

  Future<List<MemberEntity>> _filterMembers({
    MembershipStatus? status,
    DateTime? startDate,
    DateTime? endDate,
    FitnessGoal? fitnessGoal,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [];
  }

  List<MemberEntity> _sortMembers(List<MemberEntity> members, String sortBy, bool ascending) {
    final sorted = List<MemberEntity>.from(members);
    sorted.sort((a, b) {
      int comparison;
      switch (sortBy) {
        case 'name':
          comparison = a.fullName.compareTo(b.fullName);
          break;
        case 'joinDate':
          comparison = a.joinDate.compareTo(b.joinDate);
          break;
        case 'membershipExpiry':
          comparison = a.membershipExpiryDate.compareTo(b.membershipExpiryDate);
          break;
        default:
          comparison = 0;
      }
      return ascending ? comparison : -comparison;
    });
    return sorted;
  }

  Future<void> _savePayment(MemberPaymentEntity payment) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  Future<void> _updateMemberFinancials(String memberId) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<Map<String, dynamic>> _getFinancialSummary(String memberId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return {
      'totalPaid': 0.0,
      'totalDue': 0.0,
      'outstandingBalance': 0.0,
      'lastPaymentDate': null,
      'nextPaymentDate': null,
      'paymentStatus': PaymentStatus.paid,
    };
  }

  Future<List<MemberEntity>> _getOverdueMembers() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [];
  }

  Future<void> _exportToCSV(List<MemberEntity> members) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> _exportToPDF(List<MemberEntity> members) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> _updateMembershipStatus(String memberId, MembershipStatus status) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<void> _updateMembership(String memberId, DateTime newExpiryDate, String membershipType) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<void> _blockMember(String memberId, String reason) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  Future<void> _unblockMember(String memberId) async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}