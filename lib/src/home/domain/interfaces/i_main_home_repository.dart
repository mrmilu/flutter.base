import 'package:flutter_jungle_core/flutter_jungle_core.dart';

import '../../../shared/domain/failures/endpoints/get_user_failure.dart';

abstract class IMainHomeRepository {
  Future<Resource<GetUserFailure, List<String>>> getProducts();
}
