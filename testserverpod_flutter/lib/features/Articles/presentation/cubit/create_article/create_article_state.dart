part of 'create_article_cubit.dart';

@immutable
class CreateArticleState extends Equatable {
  final bool loading;
  final Article? response;
  final Failure? failure;
  final String title;
  final String content;

  const CreateArticleState({
    this.loading = false,
    this.title = '',
    this.content = '',
    this.response,
    this.failure,
  });

  bool isFormValid() {
    return title.isNotEmpty && content.isNotEmpty;
  }

  CreateArticleState requestSuccess(Article response) {
    return copyWith(
      loading: false,
      response: response,
    );
  }

  CreateArticleState requestFailure(Failure failure) {
    return copyWith(
      loading: false,
      failure: failure,
    );
  }

  CreateArticleState copyWith({
    bool? loading,
    Article? response,
    Failure? failure,
    String? title,
    String? content,
  }) {
    return CreateArticleState(
      loading: loading ?? this.loading,
      response: response ?? this.response,
      failure: failure ?? this.failure,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        response,
        title,
        content,
        failure,
      ];
}
