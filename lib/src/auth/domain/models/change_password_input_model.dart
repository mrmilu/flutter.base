class ChangePasswordInputModel {
  final String uid;
  final String token;
  final String password;
  final String repeatPassword;

  const ChangePasswordInputModel({
    required this.uid,
    required this.token,
    required this.password,
    required this.repeatPassword,
  });
}
