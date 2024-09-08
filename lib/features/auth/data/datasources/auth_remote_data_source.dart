import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity?> signInWithEmailPassword(String email, String password);
  Future<UserEntity?> signInWithGoogle();
  Future<UserEntity?> signInAnonymously();
  Future<void> signOut();
  Future<UserEntity?> getCurrentUser();
}

@LazySingleton(as:AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({required this.firebaseAuth, required this.googleSignIn});

  @override
  Future<UserEntity?> signInWithEmailPassword(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return UserEntity(uid: userCredential.user?.uid, email: userCredential.user?.email);
  }

  @override
  Future<UserEntity?> signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await firebaseAuth.signInWithCredential(credential);
    return UserEntity(uid: userCredential.user?.uid, email: userCredential.user?.email);
  }

  @override
  Future<UserEntity?> signInAnonymously() async {
    final userCredential = await firebaseAuth.signInAnonymously();
    return UserEntity(uid: userCredential.user?.uid);
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    if (user == null) return null;
    return UserEntity(uid: user.uid, email: user.email);
  }
}
