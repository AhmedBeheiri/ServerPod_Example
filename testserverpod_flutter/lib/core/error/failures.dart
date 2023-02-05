import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final id =
      (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  final String message;

  CacheFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class NoDataFailure extends Failure {
  @override
  List<Object?> get props => [];
}
