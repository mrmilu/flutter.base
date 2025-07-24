import '../../../shared/helpers/result_or.dart';
import '../failures/delete_account_failure.dart';

abstract class IDeleteAccountRepository {
  Future<ResultOr<DeleteAccountFailure>> deleteAccount();
}
