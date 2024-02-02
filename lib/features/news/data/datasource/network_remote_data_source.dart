import 'package:clean_architecture/features/news/data/models/article_model.dart';
import 'package:dio/dio.dart';

abstract class NewsNetworkRemoteDataSource {
  NewsNetworkRemoteDataSource({required Dio dio}) : _dio = dio;
  final Dio _dio;

  Future<List<ArticleModel>> getTopHeadLine(
    Map<String, dynamic> queries,
  );
}

class NewsNetworkRemoteDataSourceImpl extends NewsNetworkRemoteDataSource {
  NewsNetworkRemoteDataSourceImpl({required super.dio});

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
