import 'package:clean_architecture/features/news/data/models/article_model.dart';
import 'package:clean_architecture/injection_container.dart';
import 'package:dio/dio.dart';

abstract class NewsNetworkRemoteDataSource {
  NewsNetworkRemoteDataSource({Dio? dio}) : _dio = dio ?? getIt<Dio>();
  final Dio _dio;

  Future<List<ArticleModel>> getTopHeadLine(
    Map<String, dynamic> queries,
  );
}

class NewsNetworkRemoteDataSourceImpl extends NewsNetworkRemoteDataSource {
  NewsNetworkRemoteDataSourceImpl({super.dio});

  @override
  Future<List<ArticleModel>> getTopHeadLine(
    Map<String, dynamic> queries,
  ) async {
    final request = await _dio.get<Map<dynamic, dynamic>>('/top-headlines');
    return (request.data?['articles'] as List<dynamic>)
        .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
