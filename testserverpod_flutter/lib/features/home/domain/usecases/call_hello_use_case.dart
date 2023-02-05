import 'package:dartz/dartz.dart';
import 'package:testserverpod_flutter/core/error/failures.dart';
import 'package:testserverpod_flutter/features/home/domain/repositories/home_repository.dart';

class CallHelloUseCase {
  final HomeRepository homeRepository;

  CallHelloUseCase(this.homeRepository);

  Future<Either<Failure, String>> call(String message) async =>
      await homeRepository.callHello(message);
}
