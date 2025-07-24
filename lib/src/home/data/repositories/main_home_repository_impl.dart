import 'package:dio/dio.dart';

import '../../../shared/domain/failures/general_failure.dart';
import '../../../shared/helpers/resource.dart';
import '../../../shared/presentation/utils/extensions/dio_exception_extension.dart';
import '../../domain/interfaces/i_main_home_repository.dart';

class MainHomeRepositoryImpl extends IMainHomeRepository {
  final Dio httpClient;
  MainHomeRepositoryImpl({
    required this.httpClient,
  });

  @override
  Future<Resource<GeneralFailure, List<String>>> getProducts() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return Resource.success(['Product 1', 'Product 2', 'Product 3']);
      // final response = await httpClient.get('/users/contractedProducts');
      // return Resource.success([]);
    } on DioException catch (e) {
      return Resource.failure(
        e.toFailure(
          GeneralFailure.fromString,
          GeneralFailure.unknown,
        ),
      );
    } on Exception catch (e, _) {
      return Resource.failure(GeneralFailure.unknown);
    }
  }
}
