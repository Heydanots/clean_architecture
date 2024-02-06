import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/news/data/models/article_model.dart';
import 'package:clean_architecture/features/news/data/repositories/news_repository_impl.dart';
import 'package:clean_architecture/features/news/domain/entities/article.dart';
import 'package:clean_architecture/features/news/domain/usecases/get_top_headline_usecase.dart';
import 'package:collection/collection.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends HydratedBloc<NewsEvent, NewsState> {
  NewsBloc({required NewsRepositoryImpl newsRepositoryImpl})
      : _newsRepositoryImpl = newsRepositoryImpl,
        super(const NewsState()) {
    _getTopHeadLineUsecase = GetTopHeadLineUsecase(_newsRepositoryImpl);
    on<GetTopHeadlineEvent>(
      (event, emit) => errorHandler(() async {
        // await Future<void>.delayed(Duration(seconds: 5));
        emit(state.copyWith(state: BlocState.loading));
        final results = await _getTopHeadLineUsecase(params: event.queries);
        // add(SaveArticlesEvent(articles: results));
        emit(
          state.copyWith(
            state: BlocState.success,
            articles: results,
          ),
        );
      }).either(
        (left) => emit(
          state.copyWith(
            state: BlocState.failed,
            message: left.message,
          ),
        ),
        (right) => null,
      ),
    );

    on<SaveArticleEvent>(
      (event, emit) => errorHandler(() async {
        final saved = Map.of(state.articlesSaved);
        final id = event.article.id;
        if (saved.containsKey(id)) {
          saved.remove(id);
        } else {
          saved.addAll({id!: event.article});
        }
        emit(
          state.copyWith(
            articlesSaved: saved,
          ),
        );
      }),
    );
  }

  late final GetTopHeadLineUsecase _getTopHeadLineUsecase;

  final NewsRepositoryImpl _newsRepositoryImpl;

  @override
  NewsState? fromJson(Map<String, dynamic> json) {
    final articles = (json['articles'] as List<dynamic>? ?? <dynamic>[])
        .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
        .map((e) => e.toEntity())
        .groupFoldBy((element) => element.id!, (previous, element) => element);
    return NewsState(articlesSaved: articles);
  }

  @override
  Map<String, dynamic>? toJson(NewsState state) => {
        'articles': state.articlesSaved.values
            .map((e) => {
                  'id': e.id,
                  'author': e.author,
                  'title': e.title,
                  'description': e.description,
                  'url': e.url,
                  'urlToImage': e.urlToImage,
                  'publishedAt': e.publishedAt,
                  'content': e.content,
                },)
            .toList(),
      };
}
