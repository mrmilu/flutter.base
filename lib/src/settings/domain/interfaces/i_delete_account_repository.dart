import 'package:flutter_jungle_core/flutter_jungle_core.dart';

import '../failures/delete_account_failure.dart';

abstract class IDeleteAccountRepository {
  Future<ResultOr<DeleteAccountFailure>> deleteAccount();
}
