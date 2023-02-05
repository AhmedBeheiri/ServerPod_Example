import 'package:dartz/dartz.dart';
import 'package:testserverpod_flutter/core/error/failures.dart';

import '../repositories/articles_repo.dart';

class DeleteArticleUseCase {
  final ArticlesRepo articleRepository;

  DeleteArticleUseCase({required this.articleRepository});

  Future<Either<Failure, bool>> call(int id) async {
    return await articleRepository.deleteArticle(id);
  }
}
