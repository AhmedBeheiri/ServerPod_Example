import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testserverpod_flutter/core/error/failures.dart';
import 'package:darty_commons/darty_commons.dart';
import 'package:testserverpod_flutter/features/Articles/presentation/pages/article_details/article_details_page.dart';
import '../../../../../core/di/injection_container.dart';
import '../../cubit/articles/articles_cubit.dart';
import '../create_article/create_article_page.dart';

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<ArticlesCubit>(),
      child: const _Page(),
    );
  }
}

class _Page extends StatefulWidget {
  const _Page();

  @override
  State<_Page> createState() => __PageState();
}

class __PageState extends State<_Page> {
  @override
  void initState() {
    super.initState();
    context.read<ArticlesCubit>().getArticles();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ArticlesCubit, ArticlesState>(
          listenWhen: (previous, current) =>
              previous.loading != current.loading,
          listener: (context, state) {},
        ),
        BlocListener<ArticlesCubit, ArticlesState>(
          listenWhen: (previous, current) =>
              previous.failure != current.failure,
          listener: (context, state) {
            if (state.failure != null) {
              if (state.failure is ServerFailure) {
                (state.failure as ServerFailure)
                    .message
                    .showErrorSnackBar(
                      context,
                      duration: const Duration(
                        seconds: 2,
                      ),
                    );
              }
            }
          },
        ),
        BlocListener<ArticlesCubit, ArticlesState>(
          listenWhen: (previous, current) =>
              previous.deleteSuccess != current.deleteSuccess,
          listener: (context, state) {
            context.read<ArticlesCubit>().getArticles();
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Articles'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const CreateArticlePage(),
              ),
            );
            if (result == true) {
              context.read<ArticlesCubit>().getArticles();
            }
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            BlocBuilder<ArticlesCubit, ArticlesState>(
              builder: (context, state) {
                if (state.articles == null ||
                    state.articles!.isEmpty) {
                  return const Center(
                    child: Text('No articles'),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.articles!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          final result =
                              await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ArticleDetailsPage(
                                id: state.articles![index].id!,
                              ),
                            ),
                          );
                          if (result == true) {
                            context
                                .read<ArticlesCubit>()
                                .getArticles();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 5,
                            child: ListTile(
                              title: Text(
                                state.articles![index].title,
                              ),
                              subtitle: Text(
                                state.articles![index].content,
                                maxLines: 2,
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      context
                                          .read<ArticlesCubit>()
                                          .deleteArticle(state
                                              .articles![index].id!);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              CreateArticlePage(
                                            article: state
                                                .articles![index],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
