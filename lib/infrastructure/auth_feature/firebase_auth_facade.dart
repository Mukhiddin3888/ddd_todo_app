import 'package:dartz/dartz.dart';
import 'package:ddd_todo_app/domain/auth_feature/auth_failure.dart';
import 'package:ddd_todo_app/domain/auth_feature/i_auth_facade.dart';
import 'package:ddd_todo_app/domain/auth_feature/value_objects.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseAuthFacade(this._firebaseAuth, this._googleSignIn);

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();

    try{
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailAddressStr,
          password: passwordStr,);
      return right(unit);

    }on PlatformException catch (e){
      if(e.code == 'email-already-in-use'){
        return left(const AuthFailure.emailAlreadyInUse());
      }else{
        return left(const AuthFailure.serverError());
      }
    }

  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async{
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();

    try{
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddressStr,
        password: passwordStr,);
      return right(unit);

    }on PlatformException catch (e){
      if(e.code == 'wrong-password' || e.code == 'user-not-found'){
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      }else{
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async{

    //wrap to try catch

      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return left(const AuthFailure.cancelledByUser());
      }
      final googleAuthentication = await googleUser.authentication;

      final authCredential =  GoogleAuthProvider.credential(
        idToken: googleAuthentication.idToken,
        accessToken: googleAuthentication.accessToken,
      );

      return _firebaseAuth.signInWithCredential(authCredential).then((r) =>
          right(unit));

  }
}
