part of 'home_cubit.dart';

@immutable
class HomeState extends Equatable {
  final bool loading;
  final String? messageResponse;
  final Failure? failure;

  const HomeState({
    this.loading = false,
    this.messageResponse,
    this.failure,
  });
  HomeState copyWith({
    bool? loading,
    String? messageResponse,
    Failure? failure,
  }) {
    return HomeState(
      loading: loading ?? this.loading,
      messageResponse: messageResponse ?? this.messageResponse,
      failure: failure ?? this.failure,
    );
  }

  HomeState messageRequestSuccess(String messageResponse) => copyWith(
        loading: false,
        messageResponse: messageResponse,
      );
  HomeState requestFailure(Failure failure) => copyWith(
        loading: false,
        failure: failure,
      );

  @override
  List<Object?> get props => [
        loading,
        messageResponse,
        failure,
      ];
}
