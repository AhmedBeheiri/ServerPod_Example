import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testserverpod_flutter/features/Articles/presentation/cubit/articel_details/article_details_cubit.dart';

import '../../../../../core/di/injection_container.dart';

class ArticleDetailsPage extends StatelessWidget {
  final int id;
  const ArticleDetailsPage({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<ArticleDetailsCubit>(),
      child: _Page(
        id: id,
      ),
    );
  }
}

class _Page extends StatefulWidget {
  final int id;
  const _Page({required this.id});

  @override
  State<_Page> createState() => __PageState();
}

class __PageState extends State<_Page> {
  @override
  void initState() {
    super.initState();
    context.read<ArticleDetailsCubit>().getArticle(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ArticleDetailsCubit, ArticleDetailsState>(
      listenWhen: (previous, current) =>
          previous.deleteSuccess != current.deleteSuccess,
      listener: (context, state) {
        if (state.deleteSuccess != null) {
          if (state.deleteSuccess!) {
            Navigator.of(context).pop(true);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title:
              BlocBuilder<ArticleDetailsCubit, ArticleDetailsState>(
            buildWhen: (previous, current) =>
                previous.article != current.article,
            builder: (context, state) {
              if (state.article != null) {
                return Text(state.article!.title);
              } else {
                return const Text('Article Details');
              }
            },
          ),
          actions: [
            BlocBuilder<ArticleDetailsCubit, ArticleDetailsState>(
              buildWhen: (previous, current) =>
                  previous.article != current.article,
              builder: (context, state) {
                if (state.article != null) {
                  return IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context
                          .read<ArticleDetailsCubit>()
                          .deleteArticle(state.article!.id!);
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
        body: BlocBuilder<ArticleDetailsCubit, ArticleDetailsState>(
          builder: (context, state) {
            if (state.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(state.article!.content),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
