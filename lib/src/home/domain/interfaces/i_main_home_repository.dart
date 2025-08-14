import '../../../shared/domain/failures/endpoints/get_user_failure.dart';
import '../../../shared/presentation/helpers/resource.dart';

abstract class IMainHomeRepository {
  Future<Resource<GetUserFailure, List<String>>> getProducts();
}
