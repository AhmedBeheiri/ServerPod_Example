import 'package:dartz/dartz.dart';
import 'package:testserverpod_client/testserverpod_client.dart';

import '../../../../core/error/failures.dart';
import '../repositories/articles_repo.dart';

class GetArticleUseCase {
  final ArticlesRepo articleRepository;

  GetArticleUseCase({required this.articleRepository});

  Future<Either<Failure, Article?>> call(int id) async {
    return await articleRepository.getArticle(id);
  }
}
