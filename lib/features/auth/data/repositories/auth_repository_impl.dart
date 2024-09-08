import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

@LazySingleton(as:AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserEntity?>> signInWithEmailPassword(String email, String password) async {
    try {
      return Right(await remoteDataSource.signInWithEmailPassword(email, password));
    } catch (e) {
      return Left(ServerFailure('Failed to sign in with email and password'));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> signInWithGoogle() async {
    try {
      return Right(await remoteDataSource.signInWithGoogle());
    } catch (e) {
      return Left(ServerFailure('Failed to sign in with Google'));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> signInAnonymously() async {
    try {
      return Right(await remoteDataSource.signInAnonymously());
    } catch (e) {
      return Left(ServerFailure('Failed to sign in anonymously'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      return Right( await remoteDataSource.signOut());
    } catch (e) {
      return Left(ServerFailure('Failed to sign Out'));
    }

  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      return Right( await remoteDataSource.getCurrentUser());
    } catch (e) {
      return Left(ServerFailure('Failed to sign Out'));
    }
  }
}
