import 'package:get_it/get_it.dart';
import 'package:testserverpod_flutter/core/data/network.dart';
import 'package:testserverpod_flutter/features/home/data/datasources/home_remote_datasource.dart';
import 'package:testserverpod_flutter/features/home/data/repositories/home_repository_impl.dart';
import 'package:testserverpod_flutter/features/home/domain/usecases/call_hello_use_case.dart';
import 'package:testserverpod_flutter/features/home/presentation/cubit/home_cubit.dart';

import 'domain/repositories/home_repository.dart';

class HomeDI {
  final GetIt di;

  HomeDI(this.di) {
    call();
  }

  void call() {
    di
      ..registerLazySingleton(() => Network.instance)
      ..registerLazySingleton<HomeRemoteDataSource>(
          () => HomeRemoteDataSourceImpl(network: di()))
      ..registerLazySingleton<HomeRepository>(
          () => HomeRepositoryImpl(remoteDataSource: di()))
      ..registerLazySingleton(() => CallHelloUseCase(di()))
      ..registerFactory(() => HomeCubit(di()));
  }
}
