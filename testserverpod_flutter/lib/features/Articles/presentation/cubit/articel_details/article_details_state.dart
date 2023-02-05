part of 'article_details_cubit.dart';

@immutable
class ArticleDetailsState extends Equatable {
  const ArticleDetailsState({
    this.loading = false,
    this.deleteSuccess,
    this.failure,
    this.article,
  });
  final bool loading;
  final bool? deleteSuccess;
  final Failure? failure;
  final Article? article;

  ArticleDetailsState copyWith({
    bool? loading,
    bool? deleteSuccess,
    Failure? failure,
    Article? article,
  }) {
    return ArticleDetailsState(
      loading: loading ?? this.loading,
      deleteSuccess: deleteSuccess ?? this.deleteSuccess,
      failure: failure ?? this.failure,
      article: article ?? this.article,
    );
  }

  ArticleDetailsState requestSuccess(Article article) {
    return copyWith(
      loading: false,
      article: article,
    );
  }

  ArticleDetailsState requestFailure(Failure failure) {
    return copyWith(
      loading: false,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
        loading,
        deleteSuccess,
        failure,
        article,
      ];
}
