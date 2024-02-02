import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture/core/style/colors.dart';
import 'package:clean_architecture/features/news/domain/entities/article.dart';
import 'package:clean_architecture/features/news/presentation/bloc/news_bloc.dart';
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
                    ListTile(
                      title: Text('${state.message}'),
                      trailing: OutlinedButton(
                        onPressed: () => context
                            .read<NewsBloc>()
                            .add(const GetTopHeadlineEvent()),
                        child: const Text('Recharger'),
                      ),
                    ),
                    const Divider(height: 0),
                    Expanded(
                      child: RefreshIndicator(
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
                            return newsCard(article, articlesSaved: articles);
                          },
                        ),
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
                      return newsCard(article, articlesSaved: articlesSaved);
                    },
                  ),
                );
            }
          },
        ),
      ),
    );
  }

  Column newsCard(
    Article article, {
    Map<int, Article> articlesSaved = const {},
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CachedNetworkImage(
          imageUrl: '${article.urlToImage}',
          imageBuilder: (context, imageProvider) => Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.only(left: 8, bottom: 1),
            child: article.author == null
                ? null
                : Chip(
                    label: Text('${article.author}'),
                    labelStyle:
                        Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black,
                            ),
                  ),
          ),
          placeholder: (context, url) => const FadeShimmer(
            height: 200,
            width: 150,
            radius: 4,
            highlightColor: highlightColor,
            baseColor: baseColor,
          ),
          errorWidget: (context, url, error) => Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade200,
            ),
            child: const Icon(
              Icons.error_outline_rounded,
            ),
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text('${article.title}'),
          subtitle: article.description == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text('${article.description}'),
                ),
          trailing: IconButton(
            onPressed: () => context.read<NewsBloc>().add(
                  SaveArticleEvent(article: article),
                ),
            icon: Icon(
              articlesSaved.containsKey(article.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
          ),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTile(
        title: const Text('News'),
        titleTextStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
