import 'package:dartz/dartz.dart';
import 'package:testserverpod_client/testserverpod_client.dart';

import '../../../../core/error/failures.dart';
import '../repositories/articles_repo.dart';

class CreateArticleUseCase {
  final ArticlesRepo articleRepository;

  CreateArticleUseCase({required this.articleRepository});

  Future<Either<Failure, Article>> call(Article article) async {
    return await articleRepository.createArticle(article);
  }
}
