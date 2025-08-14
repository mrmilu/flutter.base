import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/domain/failures/endpoints/get_user_failure.dart';
import '../../../shared/helpers/resource.dart';
import '../../domain/interfaces/i_main_home_repository.dart';

part 'main_home_cubit.freezed.dart';
part 'main_home_state.dart';

class MainHomeCubit extends Cubit<MainHomeState> {
  MainHomeCubit({
    required this.repository,
  }) : super(MainHomeState.initial());
  final IMainHomeRepository repository;

  Future<void> init() async {
    await getProducts();
  }

  Future<void> getProducts() async {
    emit(state.copyWith(resourceGetProducts: Resource.loading()));
    final result = await repository.getProducts();
    emit(state.copyWith(resourceGetProducts: result));
  }
}
