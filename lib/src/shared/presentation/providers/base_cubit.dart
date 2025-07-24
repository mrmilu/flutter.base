import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseCubit<State> extends Cubit<State> {
  BaseCubit(super.initialState);

  bool isDisposed = false;

  @override
  Future<void> close() {
    isDisposed = true;
    return super.close();
  }

  void emitIfNotDisposed(State state) {
    if (!isDisposed) {
      emit(state);
    }
  }
}
