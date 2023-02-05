import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:testserverpod_client/testserverpod_client.dart';

class Network {
  Network._();
  // create singleton instance
  static final Network instance = Network._();
  final _client = Client('http://localhost:8080/')
    ..connectivityMonitor = FlutterConnectivityMonitor();

  Client get client => _client;

  Future<String> callHello(String message) async =>
      await client.example.hello(message);

  Future<List<Article>> getArticles({String? keyword}) async =>
      await client.articlesEndPoint.getArticles(keyWord: keyword);

  Future<Article?> getArticle(int id) async =>
      await client.articlesEndPoint.getArticle(id);
  Future<Article> addArticle(Article article) async =>
      await client.articlesEndPoint.addArticle(article);
  Future<bool> deleteArticle(int id) async =>
      await client.articlesEndPoint.deleteArticle(id);

  Future<Article> updateArticle(Article article) async =>
      await client.articlesEndPoint.updateArticle(article);
}
