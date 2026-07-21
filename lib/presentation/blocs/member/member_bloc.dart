import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/member/member_entity.dart';
import '../../../domain/repositories/member_repository.dart';

// Events
abstract class MemberEvent extends Equatable {
  const MemberEvent();

  @override
  List<Object?> get props => [];
}

class LoadMembers extends MemberEvent {
  const LoadMembers();
}

class LoadMemberById extends MemberEvent {
  final String id;

  const LoadMemberById({required this.id});

  @override
  List<Object?> get props => [id];
}

class SearchMembers extends MemberEvent {
  final String query;

  const SearchMembers({required this.query});

  @override
  List<Object?> get props => [query];
}

class AddMember extends MemberEvent {
  final MemberEntity member;

  const AddMember({required this.member});

  @override
  List<Object?> get props => [member];
}

class UpdateMember extends MemberEvent {
  final MemberEntity member;

  const UpdateMember({required this.member});

  @override
  List<Object?> get props => [member];
}

class DeleteMember extends MemberEvent {
  final String id;

  const DeleteMember({required this.id});

  @override
  List<Object?> get props => [id];
}

class FilterMembersByStatus extends MemberEvent {
  final String status;

  const FilterMembersByStatus({required this.status});

  @override
  List<Object?> get props => [status];
}

// States
abstract class MemberState extends Equatable {
  const MemberState();

  @override
  List<Object?> get props => [];
}

class MemberInitial extends MemberState {
  const MemberInitial();
}

class MemberLoading extends MemberState {
  const MemberLoading();
}

class MembersLoaded extends MemberState {
  final List<MemberEntity> members;

  const MembersLoaded({required this.members});

  @override
  List<Object?> get props => [members];
}

class MemberLoaded extends MemberState {
  final MemberEntity member;

  const MemberLoaded({required this.member});

  @override
  List<Object?> get props => [member];
}

class MemberError extends MemberState {
  final String message;

  const MemberError({required this.message});

  @override
  List<Object?> get props => [message];
}

class MemberOperationSuccess extends MemberState {
  final String message;

  const MemberOperationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

// Bloc
class MemberBloc extends Bloc<MemberEvent, MemberState> {
  final MemberRepository _memberRepository;

  MemberBloc({required MemberRepository memberRepository})
      : _memberRepository = memberRepository,
        super(const MemberInitial()) {
    on<LoadMembers>(_onLoadMembers);
    on<LoadMemberById>(_onLoadMemberById);
    on<SearchMembers>(_onSearchMembers);
    on<AddMember>(_onAddMember);
    on<UpdateMember>(_onUpdateMember);
    on<DeleteMember>(_onDeleteMember);
    on<FilterMembersByStatus>(_onFilterMembersByStatus);
  }

  Future<void> _onLoadMembers(
    LoadMembers event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading());
    final result = await _memberRepository.getAllMembers();
    result.fold(
      (failure) => emit(MemberError(message: failure.message)),
      (members) => emit(MembersLoaded(members: members)),
    );
  }

  Future<void> _onLoadMemberById(
    LoadMemberById event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading());
    final result = await _memberRepository.getMemberById(event.id);
    result.fold(
      (failure) => emit(MemberError(message: failure.message)),
      (member) {
        if (member != null) {
          emit(MemberLoaded(member: member));
        } else {
          emit(const MemberError(message: 'Member not found'));
        }
      },
    );
  }

  Future<void> _onSearchMembers(
    SearchMembers event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading());
    final result = await _memberRepository.searchMembers(event.query);
    result.fold(
      (failure) => emit(MemberError(message: failure.message)),
      (members) => emit(MembersLoaded(members: members)),
    );
  }

  Future<void> _onAddMember(
    AddMember event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading());
    final result = await _memberRepository.addMember(event.member);
    result.fold(
      (failure) => emit(MemberError(message: failure.message)),
      (_) {
        emit(const MemberOperationSuccess(message: 'Member added successfully'));
        add(const LoadMembers());
      },
    );
  }

  Future<void> _onUpdateMember(
    UpdateMember event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading());
    final result = await _memberRepository.updateMember(event.member);
    result.fold(
      (failure) => emit(MemberError(message: failure.message)),
      (_) {
        emit(const MemberOperationSuccess(message: 'Member updated successfully'));
        add(LoadMemberById(id: event.member.id));
      },
    );
  }

  Future<void> _onDeleteMember(
    DeleteMember event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading());
    final result = await _memberRepository.deleteMember(event.id);
    result.fold(
      (failure) => emit(MemberError(message: failure.message)),
      (_) {
        emit(const MemberOperationSuccess(message: 'Member deleted successfully'));
        add(const LoadMembers());
      },
    );
  }

  Future<void> _onFilterMembersByStatus(
    FilterMembersByStatus event,
    Emitter<MemberState> emit,
  ) async {
    emit(const MemberLoading());
    final result = await _memberRepository.getMembersByStatus(event.status);
    result.fold(
      (failure) => emit(MemberError(message: failure.message)),
      (members) => emit(MembersLoaded(members: members)),
    );
  }
}