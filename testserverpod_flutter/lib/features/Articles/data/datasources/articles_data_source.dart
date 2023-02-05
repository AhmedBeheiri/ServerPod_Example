import 'package:testserverpod_client/testserverpod_client.dart';
import 'package:testserverpod_flutter/core/data/network.dart';

abstract class ArticlesDataSource {
  Future<List<Article>> getArticles({String? keyword});
  Future<Article?> getArticle(int id);
  Future<Article> createArticle(Article article);
  Future<bool> deleteArticle(int id);
  Future<Article> updateArticle(Article article);
}

class ArticlesDataSourceImpl implements ArticlesDataSource {
  final Network network;

  ArticlesDataSourceImpl({required this.network});

  @override
  Future<List<Article>> getArticles({String? keyword}) async =>
      await network.getArticles(keyword: keyword);

  @override
  Future<Article> createArticle(Article article) async =>
      await network.addArticle(article);

  @override
  Future<bool> deleteArticle(int id) async =>
      await network.deleteArticle(id);

  @override
  Future<Article?> getArticle(int id) async =>
      await network.getArticle(id);

  @override
  Future<Article> updateArticle(Article article) async =>
      await network.updateArticle(article);
}
