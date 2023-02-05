import 'package:testserverpod_flutter/core/error/exceptions.dart';

import '../../../../core/data/network.dart';

abstract class HomeRemoteDataSource {
  Future<String> callHello(String message);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Network network;

  HomeRemoteDataSourceImpl({required this.network});

  @override
  Future<String> callHello(String message) async {
    try {
      return await network.callHello(message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
