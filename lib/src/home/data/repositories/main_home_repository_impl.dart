import 'package:dio/dio.dart';

import '../../../shared/domain/failures/endpoints/get_user_failure.dart';
import '../../../shared/presentation/helpers/handle_request.dart';
import '../../../shared/presentation/helpers/resource.dart';
import '../../domain/interfaces/i_main_home_repository.dart';

class MainHomeRepositoryImpl implements IMainHomeRepository {
  final Dio httpClient;
  MainHomeRepositoryImpl({
    required this.httpClient,
  });

  @override
  Future<Resource<GetUserFailure, List<String>>> getProducts() async {
    return handleRequest(
      request: () async {
        return ['Product 1', 'Product 2', 'Product 3'];
      },
      fromString: GetUserFailure.fromString,
      general: GetUserFailure.general,
      mockData: ['Product 1', 'Product 2', 'Product 3'],
      useMockData: false,
    );
  }
}
