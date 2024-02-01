import 'package:clean_architecture/core/usecase/usecase.dart';
import 'package:clean_architecture/features/news/domain/entities/article.dart';
import 'package:clean_architecture/features/news/domain/repositories/news_repository.dart';

class GetTopHeadLineUsecase
    implements Usecase<List<Article>, Map<String, dynamic>> {
  const GetTopHeadLineUsecase(this.repository);

  final NewsRepository repository;

  @override
  Future<List<Article>> call({Map<String, dynamic>? params}) async =>
      repository.getTopHeadLine(queries: params);
}
