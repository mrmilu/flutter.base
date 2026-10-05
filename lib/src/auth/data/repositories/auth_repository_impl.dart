import 'dart:developer' as dev;

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../shared/data/dtos/user_dto.dart';
import '../../../shared/data/services/app_flyer_service.dart';
import '../../../shared/data/services/simple_notifications_push_service.dart';
import '../../../shared/domain/failures/endpoints/general_base_failure.dart';
import '../../../shared/domain/models/user_model.dart';
import '../../../shared/presentation/extensions/dio_exception_extension.dart';
import '../../../shared/presentation/helpers/analytics_helper.dart';
import '../../../shared/presentation/helpers/handle_request.dart';
import '../../../shared/presentation/helpers/result_or.dart';
import '../../domain/failures/oauth_sign_in_failure.dart';
import '../../domain/failures/signin_failure.dart';
import '../../domain/failures/signup_failure.dart';
import '../../domain/failures/update_document_failure.dart';
import '../../domain/failures/validate_email_failure.dart';
import '../../domain/interfaces/i_auth_repository.dart';
import '../../domain/interfaces/i_token_repository.dart';
import '../mocks/mock_user.dart';
import '../services/firebase_social_auth_service.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final Dio httpClient;
  final FirebaseAuth firebaseAuth;
  final ITokenRepository tokenRepository;
  AuthRepositoryImpl({
    required this.httpClient,
    required this.firebaseAuth,
    required this.tokenRepository,
  });

  @override
  Future<UserModel?> getUser() async {
    try {
      final response = await httpClient.get('/api/users/me');
      dev.log('User: ${response.data}');
      final user = UserDto.fromMap(response.data ?? {}).toDomain();
      return user;
    } catch (e) {
      return mockUser;
    }
  }

  @override
  Future<ResultOr<SigninFailure>> signInWithEmailAndPassword({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    try {
      // final response = await httpClient.post(
      //   '/api/users/login',
      //   data: {
      //     'email': email.toLowerCase(),
      //     'password': password,
      //     if (encodeGlobalDynamicLink != null)
      //       'encoded_identifier': encodeGlobalDynamicLink,
      //   },
      // );
      final token = 'token'; // response.data['token'];
      if (rememberMe) {
        await tokenRepository.saveTokens(token: token);
        await tokenRepository.saveEmailAndPassword(
          email: email,
          password: password,
        );
      }

      return ResultOr.success();
    } on DioException catch (e) {
      return ResultOr.failure(
        e.toFailure(
          SigninFailure.fromString,
          (gF) => SigninFailure.general(gF),
        ),
      );
    } on Exception catch (e) {
      return ResultOr.failure(
        SigninFailure.general(
          GeneralBaseFailure.unexpectedError(message: e.toString()),
        ),
      );
    }
  }

  @override
  Future<void> logout() async {
    final deviceToken = PushNotificationService.token;
    if (deviceToken != null) {
      await deleteUserDevice(token: deviceToken);
    }
    await tokenRepository.clear();
    await tokenRepository.clearEmailAndPassword();
    await firebaseAuth.signOut();
    await GoogleSignIn.instance.signOut();
    await MyAnalyticsHelper.clearUserId();
  }

  @override
  Future<ResultOr<SignupFailure>> signUp({
    required String email,
    required String password,
  }) async {
    return handleRequestResultOr(
      request: () async {
        final response = await httpClient.post(
          '/api/users/register',
          data: {
            'email': email.toLowerCase(),
            'password': password,
            if (encodeGlobalDynamicLink != null)
              'encoded_identifier': encodeGlobalDynamicLink,
          },
        );
        final token = response.data['token'];
        await tokenRepository.saveTokens(token: token);
        await tokenRepository.saveEmailAndPassword(
          email: email,
          password: password,
        );
      },
      fromString: SignupFailure.fromString,
      general: SignupFailure.general,
      useMockData: false,
    );
  }

  @override
  Future<ResultOr<OAuthSignInFailure>> signInWithFacebook() async {
    return ResultOr.failure(const OAuthSignInFailure.invalidCredential());
  }

  @override
  Future<ResultOr<OAuthSignInFailure>> signInWithApple() async {
    try {
      final firebaseToken = await FirebaseSocialAuthService(
        firebaseAuth,
      ).getFirebaseTokenSignInWithApple();
      final result = await socialAuth(firebaseToken);
      if (result.isFailure) {
        return ResultOr.failure(
          const OAuthSignInFailure.general(GeneralBaseFailure.internalError()),
        );
      }
      return ResultOr.success();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        return ResultOr.failure(
          const OAuthSignInFailure.accountExistsWithDifferentCredential(),
        );
      }
      if (e.code == 'invalid-credential') {
        return ResultOr.failure(const OAuthSignInFailure.invalidCredential());
      }
      return ResultOr.failure(
        const OAuthSignInFailure.general(GeneralBaseFailure.internalError()),
      );
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        return ResultOr.failure(const OAuthSignInFailure.cancel());
      }
      return ResultOr.failure(
        const OAuthSignInFailure.general(GeneralBaseFailure.internalError()),
      );
    } catch (e) {
      if (e is CanceledByUserException) {
        throw CanceledByUserException();
      }
      return ResultOr.failure(
        OAuthSignInFailure.general(
          GeneralBaseFailure.unexpectedError(message: e.toString()),
        ),
      );
    }
  }

  @override
  Future<ResultOr<OAuthSignInFailure>> signInWithGoogle() async {
    try {
      final firebaseToken = await FirebaseSocialAuthService(
        firebaseAuth,
      ).getFirebaseTokenSignInWithGoogle();
      final result = await socialAuth(firebaseToken);
      if (result.isFailure) {
        return ResultOr.failure(
          const OAuthSignInFailure.general(GeneralBaseFailure.internalError()),
        );
      }
      return ResultOr.success();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        return ResultOr.failure(
          const OAuthSignInFailure.accountExistsWithDifferentCredential(),
        );
      }
      if (e.code == 'invalid-credential') {
        return ResultOr.failure(const OAuthSignInFailure.invalidCredential());
      }
      return ResultOr.failure(
        const OAuthSignInFailure.general(GeneralBaseFailure.internalError()),
      );
    } catch (e) {
      if (e is CanceledByUserException) {
        return ResultOr.failure(const OAuthSignInFailure.cancel());
      }
      return ResultOr.failure(
        OAuthSignInFailure.general(
          GeneralBaseFailure.unexpectedError(message: e.toString()),
        ),
      );
    }
  }

  Future<ResultOr<OAuthSignInFailure>> socialAuth(String firebaseToken) async {
    return handleRequestResultOr(
      request: () async {
        dev.log('Firebase token: $firebaseToken');
        final response = await httpClient.post(
          '/api/users/social-auth',
          data: {
            'social_token': firebaseToken,
            if (encodeGlobalDynamicLink != null)
              'encoded_identifier': encodeGlobalDynamicLink,
          },
        );
        final token = response.data['token'];
        await tokenRepository.saveTokens(token: token);
      },
      fromString: OAuthSignInFailure.fromString,
      general: OAuthSignInFailure.general,
      useMockData: false,
    );
  }

  @override
  Future<ResultOr<UpdateDocumentFailure>> updateDocument({
    required String firstName,
    required String lastName,
    required String documentType,
    required String documentValue,
  }) async {
    return handleRequestResultOr(
      request: () async {
        await httpClient.patch(
          '/api/users',
          data: {
            'first_name': firstName,
            'last_name': lastName,
            'document': {
              'type': documentType,
              'dni': documentValue,
            },
          },
        );
      },
      fromString: UpdateDocumentFailure.fromString,
      general: UpdateDocumentFailure.general,
      useMockData: false,
    );
  }

  @override
  Future<ResultOr<ValidateEmailFailure>> validateEmail({
    required String token,
  }) async {
    return handleRequestResultOr(
      request: () async {
        await httpClient.post(
          '/api/users/verify-email',
          data: {
            'token': token,
          },
        );
      },
      fromString: ValidateEmailFailure.fromString,
      general: ValidateEmailFailure.general,
      useMockData: false,
    );
  }

  @override
  Future<ResultOr<ValidateEmailFailure>> resendVerificationEmail() async {
    return handleRequestResultOr(
      request: () async {
        await httpClient.post(
          '/api/users/resend-verification-email',
        );
      },
      fromString: ValidateEmailFailure.fromString,
      general: ValidateEmailFailure.general,
      useMockData: false,
    );
  }

  @override
  Future<ResultOr<ValidateEmailFailure>> linkEncoded({
    required String encodedIdentifier,
  }) async {
    return handleRequestResultOr(
      request: () async {
        await httpClient.post(
          '/api/users/link-document',
          data: {
            'encoded_identifier': encodedIdentifier,
          },
        );
      },
      fromString: ValidateEmailFailure.fromString,
      general: ValidateEmailFailure.general,
      useMockData: false,
    );
  }

  @override
  Future<ResultOr<SigninFailure>> forgotPassword({
    required String email,
  }) async {
    return handleRequestResultOr(
      request: () async {
        await httpClient.post(
          '/api/users/forgot-password',
          data: {
            'email': email.toLowerCase(),
          },
        );
      },
      fromString: SigninFailure.fromString,
      general: SigninFailure.general,
      useMockData: false,
    );
  }

  @override
  Future<ResultOr<GeneralBaseFailure>> resetPassword({
    required String tokenKey,
    required String newPassword,
  }) async {
    return handleRequestResultOr(
      request: () async {
        final response = await httpClient.post(
          '/api/users/reset-password',
          data: {
            'token': tokenKey,
            'new_password': newPassword,
          },
        );
        final token = response.data['token'];
        await tokenRepository.saveTokens(token: token);
      },
      fromString: GeneralBaseFailure.fromString,
      general: (p0) => p0,
      useMockData: false,
    );
  }

  @override
  Future<ResultOr<GeneralBaseFailure>> createUserDevice({
    required String token,
  }) async {
    return handleRequestResultOr(
      request: () async {
        await httpClient.post(
          '/api/devices/$token',
        );
      },
      fromString: GeneralBaseFailure.fromString,
      general: (p0) => p0,
      useMockData: false,
    );
  }

  @override
  Future<ResultOr<GeneralBaseFailure>> deleteUserDevice({
    required String token,
  }) async {
    return handleRequestResultOr(
      request: () async {
        await httpClient.delete(
          '/api/devices/$token',
        );
      },
      fromString: GeneralBaseFailure.fromString,
      general: (p0) => p0,
      useMockData: false,
    );
  }
}
