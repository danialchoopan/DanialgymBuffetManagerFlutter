import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../domain/entities/member/member_entity.dart';
import '../../../domain/repositories/member_repository.dart';

class AddMemberUseCase {
  final MemberRepository _repository;

  AddMemberUseCase(this._repository);

  Future<Either<Failure, void>> call(MemberEntity member) async {
    return await _repository.addMember(member);
  }
}