// import 'package:clean_architecture/features/news/data/datasources/network_remote_data_source.dart';
// import 'package:clean_architecture/features/news/data/repositories/news_repo_impl.dart';
// import 'package:clean_architecture/features/news/data/repositories/news_repository_impl.dart';
// import 'package:clean_architecture/features/news/domain/entities/article.dart';
// import 'package:clean_architecture/features/news/domain/usecases/get_top_headline_usecase.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
//
// import 'get_top_headline_usecase.mocks.dart';
//
// @GenerateNiceMocks(
//   [MockSpec<NewsNetworkRemoteDataSourceImpl>(), MockSpec<NewsRepositoryImpl>()],
// )
// void main() {
//   late GetTopHeadLineUsecase usecase;
//   NewsNetworkRemoteDataSourceImpl remoteSource;
//   late NewsRepositoryImpl impl;
//
//   setUp(() {
//     remoteSource = MockNewsRemoteDataSourceImpl();
//     impl = MockNewsRepositoryImpl()..newsRemoteDataSourceImpl = remoteSource;
//     usecase = GetTopHeadLineUsecase(impl);
//   });
//
//   test('description', () async {
//     when(impl.getTopHeadLine(queries: {'country': 'us'})).thenAnswer(
//       (realInvocation) async => [],
//     );
//     final result = await usecase(params: {'country': 'us'});
//
//
//     expect(result, isA<List<Article>>());
//     expect(result, isEmpty);
//     // when(usecase).thenAnswer((realInvocation) => null);
//   });
// }
