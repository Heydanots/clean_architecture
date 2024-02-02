import 'package:clean_architecture/features/news/data/datasource/network_remote_data_source.dart';
import 'package:clean_architecture/features/news/data/models/article_model.dart';
import 'package:clean_architecture/features/news/domain/repositories/news_repository.dart';
import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NewsRepositoryImpl extends NewsRepository {
  NewsRepositoryImpl({
    required this.networkRemoteSource,
  });

  final NewsNetworkRemoteDataSourceImpl networkRemoteSource;

  final _queries = {
    'category': 'general',
  };

  @override
  Future<List<ArticleModel>> getTopHeadLine({
    Map<String, dynamic>? queries,
  }) async {
    // final state = await connectionState;
    ///TODO: Ajouter une data source pour la connection
    const state = ConnectivityResult.wifi;
    final result = <ArticleModel>[];

    if (state == ConnectivityResult.wifi ||
        state == ConnectivityResult.mobile) {
      final request = await networkRemoteSource.getTopHeadLine(_queries);
      result.addAll(
        request
            .mapIndexed(
              (index, e) => ArticleModel(
                id: index,
                url: e.url,
                urlToImage: e.urlToImage,
                title: e.title,
                publishedAt: e.publishedAt,
                description: e.description,
                content: e.content,
                author: e.author,
              ),
            )
            .toList(),
      );
    }

    // if (state == ConnectivityResult.none) {
    //   final request = await localRemoteSource.getTopHeadLine(_queries);
    //   result.addAll(request);
    // }

    return result;
  }
}
