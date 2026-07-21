import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/entities/member/member_entity.dart';
import '../../../domain/repositories/member_repository.dart';

class UpdateMemberUseCase {
  final MemberRepository _repository;

  UpdateMemberUseCase(this._repository);

  Future<Either<Failure, void>> call(MemberEntity member) async {
    return await _repository.updateMember(member);
  }
}