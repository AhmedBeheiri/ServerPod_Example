/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: public_member_api_docs
// ignore_for_file: implementation_imports

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:testserverpod_client/src/protocol/article_class.dart' as _i3;
import 'dart:io' as _i4;
import 'protocol.dart' as _i5;

class _EndpointArticlesEndPoint extends _i1.EndpointRef {
  _EndpointArticlesEndPoint(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'articlesEndPoint';

  /// Fetch Articles
  _i2.Future<List<_i3.Article>> getArticles({String? keyWord}) =>
      caller.callServerEndpoint<List<_i3.Article>>(
        'articlesEndPoint',
        'getArticles',
        {'keyWord': keyWord},
      );

  /// Fetch Article
  _i2.Future<_i3.Article?> getArticle(int id) =>
      caller.callServerEndpoint<_i3.Article?>(
        'articlesEndPoint',
        'getArticle',
        {'id': id},
      );

  /// Add Article
  _i2.Future<_i3.Article> addArticle(_i3.Article article) =>
      caller.callServerEndpoint<_i3.Article>(
        'articlesEndPoint',
        'addArticle',
        {'article': article},
      );

  /// Update Article
  _i2.Future<_i3.Article> updateArticle(_i3.Article article) =>
      caller.callServerEndpoint<_i3.Article>(
        'articlesEndPoint',
        'updateArticle',
        {'article': article},
      );

  /// Delete Article
  _i2.Future<bool> deleteArticle(int id) => caller.callServerEndpoint<bool>(
        'articlesEndPoint',
        'deleteArticle',
        {'id': id},
      );
}

class _EndpointExample extends _i1.EndpointRef {
  _EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

class Client extends _i1.ServerpodClient {
  Client(
    String host, {
    _i4.SecurityContext? context,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
  }) : super(
          host,
          _i5.Protocol(),
          context: context,
          authenticationKeyManager: authenticationKeyManager,
        ) {
    articlesEndPoint = _EndpointArticlesEndPoint(this);
    example = _EndpointExample(this);
  }

  late final _EndpointArticlesEndPoint articlesEndPoint;

  late final _EndpointExample example;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'articlesEndPoint': articlesEndPoint,
        'example': example,
      };
  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
