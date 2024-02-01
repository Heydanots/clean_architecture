part of 'news_bloc.dart';

enum BlocState { initial, loading, failed, success }

class NewsState extends Equatable {
  const NewsState({
    this.state = BlocState.initial,
    this.articles = const [],
    this.message,
  });

  final BlocState state;
  final List<Article> articles;
  final String? message;

  NewsState copyWith({
    BlocState? state,
    List<Article>? articles,
    String? message,
  }) =>
      NewsState(
        state: state ?? this.state,
        articles: articles ?? this.articles,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [state, articles, message];
}
