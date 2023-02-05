import 'package:equatable/equatable.dart';

abstract class Exception extends Equatable {
  final id =
      (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
}

class ServerException extends Exception {
  final String message;

  ServerException(this.message);

  @override
  List<Object?> get props => [message];
}

class CacheException extends Exception {
  final String message;

  CacheException(this.message);

  @override
  List<Object?> get props => [message];
}
