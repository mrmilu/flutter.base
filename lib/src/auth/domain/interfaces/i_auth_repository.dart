import '../../../shared/domain/failures/endpoints/general_base_failure.dart';
import '../../../shared/domain/models/user_model.dart';
import '../../../shared/presentation/helpers/result_or.dart';
import '../failures/oauth_sign_in_failure.dart';
import '../failures/signin_failure.dart';
import '../failures/signup_failure.dart';
import '../failures/update_document_failure.dart';
import '../failures/validate_email_failure.dart';

abstract class IAuthRepository {
  Future<ResultOr<SigninFailure>> signInWithEmailAndPassword({
    required String email,
    required String password,
    bool rememberMe,
  });
  Future<void> logout();

  Future<ResultOr<SignupFailure>> signUp({
    required String email,
    required String password,
  });

  Future<UserModel?> getUser();

  // Future<ResultOr<FirebaseFailure>> sendOnBoarding();

  Future<ResultOr<OAuthSignInFailure>> signInWithFacebook();

  Future<ResultOr<OAuthSignInFailure>> signInWithGoogle();

  Future<ResultOr<OAuthSignInFailure>> signInWithApple();

  Future<ResultOr<UpdateDocumentFailure>> updateDocument({
    required String firstName,
    required String lastName,
    required String documentType,
    required String documentValue,
  });

  Future<ResultOr<ValidateEmailFailure>> validateEmail({
    required String token,
  });

  Future<ResultOr<ValidateEmailFailure>> resendVerificationEmail();

  Future<ResultOr<ValidateEmailFailure>> linkEncoded({
    required String encodedIdentifier,
  });

  Future<ResultOr<SigninFailure>> forgotPassword({
    required String email,
  });

  Future<ResultOr<GeneralBaseFailure>> resetPassword({
    required String tokenKey,
    required String newPassword,
  });

  Future<ResultOr<GeneralBaseFailure>> createUserDevice({
    required String token,
  });

  Future<ResultOr<GeneralBaseFailure>> deleteUserDevice({
    required String token,
  });
}
