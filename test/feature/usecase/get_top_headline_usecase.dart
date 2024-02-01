import 'package:clean_architecture/features/news/data/datasources/network_remote_data_source.dart';
import 'package:clean_architecture/features/news/data/repositories/news_repo_impl.dart';
import 'package:clean_architecture/features/news/domain/entities/article.dart';
import 'package:clean_architecture/features/news/domain/usecases/get_top_headline_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../mock_news_test.mocks.dart';

@GenerateNiceMocks(
  [MockSpec<NewsNetworkRemoteDataSourceImpl>()],
)
void main() {
  late GetTopHeadLineUsecase usecase;
  late MockNewsNetworkRemoteDataSourceImpl newsNetworkRemoteDataSourceImpl;
  late NewsRepositoryImpl impl;

  setUp(() {
    newsNetworkRemoteDataSourceImpl = MockNewsNetworkRemoteDataSourceImpl();
    impl = NewsRepositoryImpl(
        networkRemoteSource: newsNetworkRemoteDataSourceImpl);
    usecase = GetTopHeadLineUsecase(impl);
  });

  test('description', () async {
    when(impl.getTopHeadLine(queries: {'country': 'us'})).thenAnswer(
      (realInvocation) async => [],
    );
    final result = await usecase(params: {'country': 'us'});
    print(result);

    expect(result, isA<List<Article>>());
    expect(result, isEmpty);
    // when(usecase).thenAnswer((realInvocation) => null);
  });
}