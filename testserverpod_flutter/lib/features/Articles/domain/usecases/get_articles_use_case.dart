import 'package:dartz/dartz.dart';
import 'package:testserverpod_client/testserverpod_client.dart';

import '../../../../core/error/failures.dart';
import '../repositories/articles_repo.dart';

class GetArticlesUseCase {
  final ArticlesRepo repository;

  GetArticlesUseCase(this.repository);

  Future<Either<Failure, List<Article>>> call() async {
    return await repository.getArticles();
  }
}
