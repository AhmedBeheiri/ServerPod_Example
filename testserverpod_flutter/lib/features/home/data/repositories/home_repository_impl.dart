import 'package:dartz/dartz.dart';
import 'package:testserverpod_flutter/core/error/failures.dart';

import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> callHello(String message) async {
    try {
      return Right(await remoteDataSource.callHello(message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
