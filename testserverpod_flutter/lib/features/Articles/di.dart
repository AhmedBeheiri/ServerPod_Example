import 'package:get_it/get_it.dart';
import 'package:testserverpod_flutter/features/Articles/domain/repositories/articles_repo.dart';
import 'package:testserverpod_flutter/features/Articles/domain/usecases/update_article_use_case.dart';
import 'package:testserverpod_flutter/features/Articles/presentation/cubit/articel_details/article_details_cubit.dart';
import 'package:testserverpod_flutter/features/Articles/presentation/cubit/articles/articles_cubit.dart';
import 'package:testserverpod_flutter/features/Articles/presentation/cubit/create_article/create_article_cubit.dart';

import '../../core/data/network.dart';
import 'data/datasources/articles_data_source.dart';
import 'data/repositories/articles_repo_impl.dart';
import 'domain/usecases/create_article_usecase.dart';
import 'domain/usecases/delete_article_use_case.dart';
import 'domain/usecases/get_article_usecase.dart';
import 'domain/usecases/get_articles_use_case.dart';

class ArticlesDI {
  final GetIt di;

  ArticlesDI(this.di) {
    call();
  }

  void call() {
    di
      ..registerLazySingleton<ArticlesDataSource>(
          () => ArticlesDataSourceImpl(network: di()))
      ..registerLazySingleton<ArticlesRepo>(
          () => ArticlesRepoImpl(di()))
      ..registerLazySingleton(
          () => DeleteArticleUseCase(articleRepository: di()))
      ..registerLazySingleton(
          () => CreateArticleUseCase(articleRepository: di()))
      ..registerLazySingleton(
          () => UpdateArticleUseCase(articleRepository: di()))
      ..registerLazySingleton(() => GetArticlesUseCase(di()))
      ..registerLazySingleton(
          () => GetArticleUseCase(articleRepository: di()))
      ..registerFactory(() => ArticlesCubit(di(), di()))
      ..registerFactory(() => CreateArticleCubit(di(), di()))
      ..registerFactory(() => ArticleDetailsCubit(di(), di()));
  }
}
