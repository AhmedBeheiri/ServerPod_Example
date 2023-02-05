import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:testserverpod_flutter/core/error/failures.dart';
import 'package:testserverpod_flutter/features/home/domain/usecases/call_hello_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CallHelloUseCase _callHelloUseCase;
  HomeCubit(this._callHelloUseCase) : super(const HomeState());

  void callHello(String message) async {
    emit(state.copyWith(loading: true));
    final result = await _callHelloUseCase.call(message);
    result.fold(
      (failure) => emit(
        state.requestFailure(failure),
      ),
      (message) => emit(
        state.messageRequestSuccess(message),
      ),
    );
  }
}
