// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;

import 'application/auth_feature/sign_in_form/sign_in_form_bloc.dart' as _i6;
import 'domain/auth_feature/i_auth_facade.dart' as _i7;
import 'infrastructure/auth_feature/firebase_auth_facade.dart'
    as _i3; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.FirebaseAuthFacade>(() =>
      _i3.FirebaseAuthFacade(get<_i4.FirebaseAuth>(), get<_i5.GoogleSignIn>()));
  gh.factory<_i6.SignInFormBloc>(() =>
      _i6.SignInFormBloc(get<_i6.SignInFormState>(), get<_i7.IAuthFacade>()));
  return get;
}
