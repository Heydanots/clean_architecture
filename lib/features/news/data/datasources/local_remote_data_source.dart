import 'package:clean_architecture/features/news/data/models/article_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class NewsLocalRemoteSource {
  NewsLocalRemoteSource({required Database database}) : _database = database;

  late final Database _database;

  Future<List<ArticleModel>> getTopHeadLine(
    Map<String, dynamic> queries,
  );

  Future<void> saveArticles({required List<ArticleModel> articles});
}

class NewsLocalRemoteDataSourceImpl extends NewsLocalRemoteSource {
  NewsLocalRemoteDataSourceImpl({required super.database});

  @override
  Future<List<ArticleModel>> getTopHeadLine(
    Map<String, dynamic> queries,
  ) async {
    final query = await _database.query(
      'article',
      where: queries.entries.map((e) => '${e.key} = ${e.value}').join(' && '),
    );
    return query.map(ArticleModel.fromJson).toList();
  }

  @override
  Future<void> saveArticles({required List<ArticleModel> articles}) {
    // TODO: implement saveArticles
    throw UnimplementedError();
  }
}
