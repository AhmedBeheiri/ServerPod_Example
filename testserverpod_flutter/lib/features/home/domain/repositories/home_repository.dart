import 'package:dartz/dartz.dart';
import 'package:testserverpod_flutter/core/error/failures.dart';

abstract class HomeRepository {
  Future<Either<Failure, String>> callHello(String message);
}
