import 'package:clean_architecture/features/news/domain/entities/article.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NewsRepository {
  Future<ConnectivityResult> get connectionState async =>
      Connectivity().checkConnectivity();

  Future<List<Article>> getTopHeadLine({
    Map<String, dynamic>? queries,
  });

  Future<void> saveArticles({required List<Article> articles});
}
