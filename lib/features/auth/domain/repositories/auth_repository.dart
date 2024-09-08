import 'package:dartz/dartz.dart';
import 'package:researchfirebase/core/errors/failures.dart';
import 'package:researchfirebase/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity?>> signInWithEmailPassword(String email, String password);
  Future<Either<Failure, UserEntity?>> signInWithGoogle();
  Future<Either<Failure, UserEntity?>> signInAnonymously();
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, UserEntity?>> getCurrentUser();
}
