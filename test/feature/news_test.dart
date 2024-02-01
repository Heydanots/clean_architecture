import 'package:clean_architecture/features/news/data/datasources/local_remote_data_source.dart';
import 'package:clean_architecture/features/news/data/datasources/network_remote_data_source.dart';
import 'package:clean_architecture/features/news/data/repositories/news_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  final dio = Dio(
    BaseOptions(
      headers: {
        'Authorization': '3db4395bafb44c88b4761f9a09d7be0c',
      },
      baseUrl: 'https://newsapi.org/v2',
      queryParameters: {
        'country': 'us',
        'category': 'business',
      },
    ),
  );


  //Instance mock
  late NewsNetworkRemoteDataSourceImpl networkRemoteDataSourceImpl;
  late NewsRepositoryImpl repositoryImpl;
  setUp(() async {
    networkRemoteDataSourceImpl = NewsNetworkRemoteDataSourceImpl(dio: dio);
    repositoryImpl = NewsRepositoryImpl(
      networkRemoteSource: networkRemoteDataSourceImpl,
    );
  });

  test('test de la vrai source via HTTP', () async {
    final result = await repositoryImpl.getTopHeadLine();
    expect(result, isNotEmpty);
  });
}
