import 'package:dartz/dartz.dart';
import 'package:testserverpod_client/testserverpod_client.dart';
import 'package:testserverpod_flutter/features/Articles/domain/repositories/articles_repo.dart';

import '../../../../core/error/failures.dart';

class UpdateArticleUseCase {
  final ArticlesRepo articleRepository;

  UpdateArticleUseCase({required this.articleRepository});

  Future<Either<Failure, Article>> call(Article article) async {
    return await articleRepository.updateArticle(article);
  }
}
