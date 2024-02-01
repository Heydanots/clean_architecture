// import 'dart:convert';
//
// import 'package:clean_architecture/features/news/data/datasources/network_remote_data_source.dart';
// import 'package:clean_architecture/features/news/data/models/article_model.dart';
// import 'package:clean_architecture/features/news/data/repositories/news_repo_impl.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// import 'usecase/get_top_headline_usecase.mocks.dart';
//
// // @GenerateMocks([NewsRemoteSource, NewsRepositoryImpl])
// @GenerateNiceMocks([MockSpec<NewsNetworkRemoteDataSource>()])
// void main() {
//   final dio = Dio(
//     BaseOptions(
//       headers: {
//         'Authorization': '3db4395bafb44c88b4761f9a09d7be0c',
//       },
//       baseUrl: 'https://newsapi.org/v2',
//       queryParameters: {
//         'country': 'us',
//         'category': 'business',
//       },
//     ),
//   );
//   late MockNewsRemoteDataSourceImpl mockRemoteSource;
//   late NewsRepositoryImpl impl;
//   late NewsNetworkRemoteDataSourceImpl remoteSource;
//   setUp(() {
//     mockRemoteSource = MockNewsRemoteDataSourceImpl();
//     // impl = NewsRepositoryImpl(mockRemoteSource);
//     remoteSource = NewsNetworkRemoteDataSourceImpl(dio: dio);
//   });
//
//   group('Test global', () {
//     const articleBloc = [ArticleModel(id: 1)];
//     test('test de la source mocker', () async {
//       when(mockRemoteSource.getTopHeadLine(any)).thenAnswer(
//         (_) async => articleBloc,
//       );
//
//       // final result = await impl.getTopHeadLine(queries: {'country': 'us'});
//       // verify(mockRemoteSource.getTopHeadLine(any));
//
//       // expect(result, articleBloc);
//     });
//
//     test('test de la vrai source via HTTP', () async {
//       final result = await remoteSource.getTopHeadLine({'country': 'us'});
//       if (kDebugMode) {
//         print(json.encode(result));
//       }
//
//       expect(result, isNotEmpty);
//     });
//   });
// }
