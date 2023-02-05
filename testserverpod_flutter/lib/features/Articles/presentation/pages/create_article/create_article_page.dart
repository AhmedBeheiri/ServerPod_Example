import 'package:darty_commons/ankos/strings_anko.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testserverpod_client/testserverpod_client.dart';

import '../../../../../core/di/injection_container.dart';
import '../../../../../core/error/failures.dart';
import '../../cubit/create_article/create_article_cubit.dart';

class CreateArticlePage extends StatelessWidget {
  final Article? article;
  const CreateArticlePage({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<CreateArticleCubit>(),
      child: _Page(
        article: article,
      ),
    );
  }
}

class _Page extends StatefulWidget {
  final Article? article;
  const _Page({this.article});

  @override
  State<_Page> createState() => __PageState();
}

class __PageState extends State<_Page> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController =
      TextEditingController();
  final TextEditingController _contentController =
      TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.article != null) {
      _titleController.text = widget.article!.title;
      _contentController.text = widget.article!.content;
      context
          .read<CreateArticleCubit>()
          .titleChanged(widget.article!.title);
      context
          .read<CreateArticleCubit>()
          .contentChanged(widget.article!.content);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateArticleCubit, CreateArticleState>(
          listenWhen: (previous, current) =>
              previous.loading != current.loading,
          listener: (context, state) {},
        ),
        BlocListener<CreateArticleCubit, CreateArticleState>(
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
        BlocListener<CreateArticleCubit, CreateArticleState>(
          listenWhen: (previous, current) =>
              previous.response != current.response,
          listener: (context, state) {
            if (state.response != null) {
              Navigator.of(context).pop(true);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.article == null
                ? 'Create Article'
                : 'Edit Article',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30.0),
              Expanded(
                  child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocBuilder<CreateArticleCubit,
                        CreateArticleState>(
                      buildWhen: (previous, current) =>
                          previous.title != current.title,
                      builder: (context, state) {
                        return TextFormField(
                          validator: (value) => value!.isEmpty
                              ? 'Title can\'t be empty'
                              : value.length > 50
                                  ? 'Title can\'t be longer than 50 characters'
                                  : null,
                          controller: _titleController,
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            context
                                .read<CreateArticleCubit>()
                                .titleChanged(value);
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16.0),
                    BlocBuilder<CreateArticleCubit,
                        CreateArticleState>(
                      buildWhen: (previous, current) =>
                          previous.content != current.content,
                      builder: (context, state) {
                        return TextFormField(
                          validator: (value) => value!.isEmpty
                              ? 'Content can\'t be empty'
                              : null,
                          controller: _contentController,
                          autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            labelText: 'Content',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                          ),
                          textAlign: TextAlign.start,
                          textInputAction: TextInputAction.newline,
                          keyboardType: TextInputType.multiline,
                          minLines: 9,
                          maxLines: 90,
                          onChanged: (value) {
                            context
                                .read<CreateArticleCubit>()
                                .contentChanged(value);
                          },
                        );
                      },
                    ),
                  ],
                ),
              )),
              BlocBuilder<CreateArticleCubit, CreateArticleState>(
                buildWhen: (previous, current) =>
                    previous.isFormValid() != current.isFormValid(),
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.isFormValid()
                        ? () {
                            if (widget.article != null) {
                              context
                                  .read<CreateArticleCubit>()
                                  .updateArticle(widget.article!);
                            } else {
                              context
                                  .read<CreateArticleCubit>()
                                  .createArticle();
                            }
                          }
                        : null,
                    child: Text(
                      widget.article == null
                          ? 'Create Article'
                          : 'Update Article',
                    ),
                  );
                },
              ),
              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
