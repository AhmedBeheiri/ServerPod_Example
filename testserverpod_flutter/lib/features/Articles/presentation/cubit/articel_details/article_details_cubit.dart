import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:testserverpod_client/testserverpod_client.dart';
import 'package:testserverpod_flutter/features/Articles/domain/usecases/delete_article_use_case.dart';
import 'package:testserverpod_flutter/features/Articles/domain/usecases/get_article_usecase.dart';

import '../../../../../core/error/failures.dart';

part 'article_details_state.dart';

class ArticleDetailsCubit extends Cubit<ArticleDetailsState> {
  final GetArticleUseCase _getArticleUseCase;
  final DeleteArticleUseCase _deleteArticleUseCase;
  ArticleDetailsCubit(
      this._getArticleUseCase, this._deleteArticleUseCase)
      : super(const ArticleDetailsState());

  Future<void> getArticle(int id) async {
    emit(state.copyWith(loading: true));
    final result = await _getArticleUseCase(id);
    result.fold(
      (failure) => emit(state.requestFailure(failure)),
      (article) => article != null
          ? emit(state.requestSuccess(article))
          : emit(state.requestFailure(NoDataFailure())),
    );
  }

  Future<void> deleteArticle(int id) async {
    emit(state.copyWith(loading: true));
    final result = await _deleteArticleUseCase(id);
    result.fold(
      (failure) => emit(state.requestFailure(failure)),
      (success) => emit(state.copyWith(deleteSuccess: success)),
    );
  }
}
