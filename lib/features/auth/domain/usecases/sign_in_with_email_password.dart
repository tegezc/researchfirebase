import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

@injectable
class SignInWithEmailPassword implements UseCase<UserEntity?, SignInParams> {
  final AuthRepository repository;

  SignInWithEmailPassword(this.repository);

  @override
  Future<Either<Failure, UserEntity?>> call(SignInParams params) async {
    return await repository.signInWithEmailPassword(params.email, params.password);
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});
}
