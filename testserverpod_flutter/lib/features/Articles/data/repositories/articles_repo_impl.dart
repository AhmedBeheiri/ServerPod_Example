import 'package:darty_commons/darty_commons.dart';
import 'package:dartz/dartz.dart';
import 'package:testserverpod_client/testserverpod_client.dart';
import 'package:testserverpod_flutter/core/error/failures.dart';
import 'package:testserverpod_flutter/features/Articles/data/datasources/articles_data_source.dart';

import '../../domain/repositories/articles_repo.dart';

class ArticlesRepoImpl extends ArticlesRepo {
  final ArticlesDataSource _articlesEndPoint;

  ArticlesRepoImpl(this._articlesEndPoint);

  @override
  Future<Either<Failure, List<Article>>> getArticles(
      {String? keyWord}) async {
    try {
      return Right(
        await _articlesEndPoint.getArticles(
          keyword: keyWord,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Article?>> getArticle(int id) async {
    try {
      return Right(
        await _articlesEndPoint.getArticle(
          id,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Article>> createArticle(
      Article article) async {
    try {
      return Right(
        await _articlesEndPoint.createArticle(
          article,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteArticle(int id) async {
    try {
      return Right(
        await _articlesEndPoint.deleteArticle(
          id,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Article>> updateArticle(
      Article article) async {
    try {
      return Right(
        await _articlesEndPoint.updateArticle(
          article,
        ),
      );
    } on ServerpodClientException catch (e) {
      e.message.logError(tag: 'ArticlesRepoImpl.updateArticle');
      return Left(ServerFailure(e.toString()));
    }
  }
}
