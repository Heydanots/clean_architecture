import 'package:clean_architecture/features/news/data/datasource/network_remote_data_source.dart';
import 'package:clean_architecture/features/news/data/models/article_model.dart';
import 'package:clean_architecture/features/news/data/repositories/news_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mock_news_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<NewsNetworkRemoteDataSourceImpl>(),
])
void main() {
  //Instance mock
  late MockNewsNetworkRemoteDataSourceImpl mockNetworkRemoteDataSourceImpl;
  late NewsRepositoryImpl repositoryImpl;
  setUp(() {
    mockNetworkRemoteDataSourceImpl = MockNewsNetworkRemoteDataSourceImpl();
    repositoryImpl = NewsRepositoryImpl(
      networkRemoteSource: mockNetworkRemoteDataSourceImpl,
    );
  });

  group('Test global', () {
    const articles = [ArticleModel(id: 1)];
    test('test de la source mocker', () async {
      when(repositoryImpl.getTopHeadLine(queries: {})).thenAnswer(
        (_) async => articles,
      );

      final result =
          await repositoryImpl.getTopHeadLine(queries: {'country': 'us'});

      expect(result, isNotEmpty);
      expect(result, articles);
    });

    // test('test de la vrai source via HTTP', () async {});
  });
}
