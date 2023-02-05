import 'dart:io';

import 'package:serverpod/serverpod.dart';

import '../generated/article_class.dart';

class ArticlesEndPoint extends Endpoint {
  /// Fetch Articles
  Future<List<Article>> getArticles(Session session,
      {String? keyWord}) async {
    return await Article.find(
      session,
      where: (t) => keyWord == null
          ? Constant(true)
          : t.title.like('%$keyWord%'),
    );
  }

  /// Fetch Article
  Future<Article?> getArticle(Session session, int id) async {
    return await Article.findById(
      session,
      id,
    );
  }

  /// Add Article
  Future<Article> addArticle(Session session, Article article) async {
    await Article.insert(session, article);
    return article;
  }

  /// Update Article
  Future<Article> updateArticle(
      Session session, Article article) async {
    final art = await Article.findById(
      session,
      article.id!,
    );

    session.log('Updating article ${article.id})');
    if (art == null) throw HttpException('Article not found');

    await Article.update(session, article);
    return article;
  }

  /// Delete Article
  Future<bool> deleteArticle(Session session, int id) async {
    final result = await Article.delete(
      session,
      where: (t) => t.id.equals(id),
    );
    return result == 1;
  }
}
