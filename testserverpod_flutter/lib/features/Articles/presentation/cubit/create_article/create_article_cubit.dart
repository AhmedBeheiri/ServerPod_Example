import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:testserverpod_client/testserverpod_client.dart';
import 'package:testserverpod_flutter/features/Articles/domain/usecases/create_article_usecase.dart';
import 'package:testserverpod_flutter/features/Articles/domain/usecases/update_article_use_case.dart';

import '../../../../../core/error/failures.dart';
part 'create_article_state.dart';

class CreateArticleCubit extends Cubit<CreateArticleState> {
  final CreateArticleUseCase _createArticleUseCase;
  final UpdateArticleUseCase _updateArticleUseCase;
  CreateArticleCubit(
      this._createArticleUseCase, this._updateArticleUseCase)
      : super(const CreateArticleState());

  void createArticle() async {
    emit(state.copyWith(loading: true));
    final article = Article(
      title: state.title,
      content: state.content,
      created: DateTime.now(),
      updated: DateTime.now(),
      isPrime: false,
    );
    final result = await _createArticleUseCase(article);
    result.fold(
      (failure) => emit(state.requestFailure(failure)),
      (response) => emit(state.requestSuccess(response)),
    );
  }

  void updateArticle(Article article) async {
    emit(state.copyWith(loading: true));
    final newArticle = Article(
      id: article.id,
      title: state.title,
      content: state.content,
      created: article.created,
      updated: DateTime.now(),
      isPrime: article.isPrime,
    );
    final result = await _updateArticleUseCase(newArticle);
    result.fold(
      (failure) => emit(state.requestFailure(failure)),
      (response) => emit(state.requestSuccess(response)),
    );
  }

  void titleChanged(String title) {
    emit(state.copyWith(title: title));
  }

  void contentChanged(String content) {
    emit(state.copyWith(content: content));
  }
}
