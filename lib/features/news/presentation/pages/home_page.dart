import 'package:clean_architecture/core/style/colors.dart';
import 'package:clean_architecture/features/news/presentation/bloc/news_bloc.dart';
import 'package:clean_architecture/features/news/presentation/widgets/widgets.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<NewsBloc>().add(const GetTopHeadlineEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewsBloc, NewsState>(
      listenWhen: (previous, current) => previous.state != current.state,
      listener: (context, state) {
        if (state.state == BlocState.failed) {}
      },
      child: Scaffold(
        appBar: const HomeAppBar(),
        body: BlocBuilder<NewsBloc, NewsState>(
          buildWhen: (previous, current) =>
              previous.state != current.state ||
              previous.articlesSaved != current.articlesSaved,
          builder: (context, state) {
            switch (state.state) {
              case BlocState.initial:
              case BlocState.loading:
                return ListView(
                  children: List.generate(
                    5,
                    (index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 200,
                          child: FadeShimmer(
                            width: MediaQuery.sizeOf(context).width,
                            height: 200,
                            highlightColor: highlightColor,
                            baseColor: baseColor,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 8, left: 8, bottom: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FadeShimmer(
                                width: 100,
                                height: 25,
                                radius: 8,
                                highlightColor: highlightColor,
                                baseColor: baseColor,
                              ),
                              Gap(10),
                              FadeShimmer(
                                width: 150,
                                height: 25,
                                radius: 8,
                                highlightColor: highlightColor,
                                baseColor: baseColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              case BlocState.failed:
                final articles = state.articlesSaved;
                return Column(
                  children: [
                    Expanded(
                      child: articles.isEmpty
                          ? Text(
                              "Vous n'avez aucun article dans vos favoris",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                            )
                          : RefreshIndicator(
                              onRefresh: () async => context
                                  .read<NewsBloc>()
                            .add(const GetTopHeadlineEvent()),
                        child: ListView.separated(
                          itemCount: articles.length,
                          padding: const EdgeInsets.all(16),
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          separatorBuilder: (context, index) =>
                              const Divider(thickness: .2),
                          itemBuilder: (context, index) {
                            final article = articles.values.elementAt(index);
                                  return NewsCard(
                                    article: article,
                                    articlesSaved: articles,
                                  );
                                },
                              ),
                      ),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      title: Text('${state.message}'),
                      minVerticalPadding: 16,
                      trailing: OutlinedButton(
                        onPressed: () => context
                            .read<NewsBloc>()
                            .add(const GetTopHeadlineEvent()),
                        child: const Text('Recharger'),
                      ),
                    ),
                  ],
                );
              case BlocState.success:
                final articles = state.articles;
                final articlesSaved = state.articlesSaved;
                return RefreshIndicator(
                  onRefresh: () async =>
                      context.read<NewsBloc>().add(const GetTopHeadlineEvent()),
                  child: ListView.separated(
                    itemCount: articles.length,
                    padding: const EdgeInsets.all(16),
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        const Divider(thickness: .2),
                    itemBuilder: (context, index) {
                      final article = articles.elementAt(index);
                      return NewsCard(
                        article: article,
                        articlesSaved: articlesSaved,
                      );
                    },
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
