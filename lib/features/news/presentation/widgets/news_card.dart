import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture/core/style/colors.dart';
import 'package:clean_architecture/features/news/domain/entities/article.dart';
import 'package:clean_architecture/features/news/presentation/bloc/news_bloc.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    required this.article,
    required this.articlesSaved,
    super.key,
  });

  final Article article;
  final Map<int, Article> articlesSaved;

  @override
  Widget build(BuildContext context) {
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
