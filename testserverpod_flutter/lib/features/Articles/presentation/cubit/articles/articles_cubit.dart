import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:testserverpod_client/testserverpod_client.dart';
import 'package:testserverpod_flutter/features/Articles/domain/usecases/delete_article_use_case.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/usecases/get_articles_use_case.dart';

part 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  final GetArticlesUseCase _getArticlesUseCase;
  final DeleteArticleUseCase _deleteArticleUseCase;
  ArticlesCubit(this._deleteArticleUseCase, this._getArticlesUseCase)
      : super(const ArticlesState());

  Future<void> getArticles() async {
    emit(state.copyWith(loading: true));
    final result = await _getArticlesUseCase();
    result.fold(
      (failure) => emit(state.requestFailure(failure)),
      (articles) => emit(state.requestSuccess(articles)),
    );
  }

  Future<void> deleteArticle(int id) async {
    emit(state.copyWith(loading: true));
    final result = await _deleteArticleUseCase(id);
    result.fold(
      (failure) => emit(state.requestFailure(failure)),
      (success) => emit(state.requestDeleteSuccess()),
    );
  }
}
