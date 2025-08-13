import '../../../shared/domain/failures/endpoints/get_user_failure.dart';
import '../../../shared/helpers/resource.dart';

abstract class IMainHomeRepository {
  Future<Resource<GetUserFailure, List<String>>> getProducts();
}
