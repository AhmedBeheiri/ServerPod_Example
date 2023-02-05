part of 'articles_cubit.dart';

@immutable
class ArticlesState extends Equatable {
  const ArticlesState({
    this.loading = false,
    this.articles,
    this.failure,
    this.deleteSuccess,
  });

  final bool loading;
  final List<Article>? articles;
  final Failure? failure;
  final bool? deleteSuccess;

  ArticlesState requestSuccess(List<Article> articles) {
    return copyWith(
      loading: false,
      articles: articles,
    );
  }

  ArticlesState requestDeleteSuccess() {
    return copyWith(
      loading: false,
      deleteSuccess: true,
    );
  }

  ArticlesState requestFailure(Failure failure) {
    return copyWith(
      loading: false,
      failure: failure,
    );
  }

  ArticlesState copyWith({
    bool? loading,
    List<Article>? articles,
    Failure? failure,
    bool? deleteSuccess,
  }) {
    return ArticlesState(
      loading: loading ?? this.loading,
      articles: articles ?? this.articles,
      failure: failure ?? this.failure,
      deleteSuccess: deleteSuccess ?? this.deleteSuccess,
    );
  }

  @override
  List<Object?> get props =>
      [loading, articles, failure, deleteSuccess];
}
