import '../../../shared/domain/failures/general_failure.dart';
import '../../../shared/helpers/resource.dart';

abstract class IMainHomeRepository {
  Future<Resource<GeneralFailure, List<String>>> getProducts();
}
