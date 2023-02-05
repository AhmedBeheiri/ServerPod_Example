import 'package:dartz/dartz.dart';
import 'package:testserverpod_client/testserverpod_client.dart';

import '../../../../core/error/failures.dart';

abstract class ArticlesRepo {
  Future<Either<Failure, List<Article>>> getArticles(
      {String? keyWord});
  Future<Either<Failure, Article?>> getArticle(int id);
  Future<Either<Failure, Article>> createArticle(Article article);
  Future<Either<Failure, bool>> deleteArticle(int id);
  Future<Either<Failure, Article>> updateArticle(Article article);
}
