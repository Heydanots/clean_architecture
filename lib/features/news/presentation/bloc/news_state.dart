part of 'news_bloc.dart';

enum BlocState { initial, loading, failed, success }

class NewsState extends Equatable {
  const NewsState({
    this.state = BlocState.initial,
    this.articles = const [],
    this.articlesSaved = const {},
    this.message,
  });

  final BlocState state;
  final List<Article> articles;
  final Map<int, Article> articlesSaved;
  final String? message;

  NewsState copyWith({
    BlocState? state,
    List<Article>? articles,
    Map<int, Article>? articlesSaved,
    String? message,
  }) =>
      NewsState(
        state: state ?? this.state,
        articles: articles ?? this.articles,
        message: message ?? this.message,
        articlesSaved: articlesSaved ?? this.articlesSaved,
      );

  @override
  List<Object?> get props => [state, articles, articlesSaved, message];
}
