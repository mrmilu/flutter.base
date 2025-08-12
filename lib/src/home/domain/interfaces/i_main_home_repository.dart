import '../../../shared/domain/failures/endpoints/unions/user_endpoint_failure.dart';
import '../../../shared/helpers/resource.dart';

abstract class IMainHomeRepository {
  Future<Resource<UserEndpointError, List<String>>> getProducts();
}
