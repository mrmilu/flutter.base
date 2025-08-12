import 'package:dio/dio.dart';

import '../../../shared/domain/failures/endpoints/unions/app_error.dart';
import '../../../shared/domain/failures/endpoints/unions/user_endpoint_failure.dart';
import '../../../shared/helpers/resource.dart';
import '../../domain/interfaces/i_main_home_repository.dart';

class MainHomeRepositoryImpl extends IMainHomeRepository {
  final Dio httpClient;
  MainHomeRepositoryImpl({
    required this.httpClient,
  });

  @override
  Future<Resource<UserEndpointError, List<String>>> getProducts() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      // Ahora puedes usar mensajes personalizados!
      return Resource.failure(
        const UserEndpointError.general(AppBaseError.networkError()),
      );

      // O usar el mensaje por defecto
      // return Resource.failure(BaseFailure.unauthorized());

      // return Resource.success(['Product 1', 'Product 2', 'Product 3']);
      // final response = await httpClient.get('/users/contractedProducts');
      // return Resource.success([]);
    } on DioException catch (_) {
      // Mensaje personalizado con información del error
      return Resource.failure(
        const UserEndpointError.general(AppBaseError.networkError()),
      );
      // return Resource.failure(
      //   e.toFailure(
      //     BaseFailure.fromString,
      //     BaseFailure.unknown,
      //   ),
      // );
    } on Exception catch (e, _) {
      return Resource.failure(
        const UserEndpointError.general(AppBaseError.networkError()),
      );
    }
  }
}
