part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class GetTopHeadlineEvent extends NewsEvent {
  const GetTopHeadlineEvent({this.queries = const {}});

  final Map<String, dynamic> queries;

  @override
  List<Object> get props => [queries];
}

class SaveArticleEvent extends NewsEvent {
  const SaveArticleEvent({required this.article});

  final Article article;

  @override
  List<Object> get props => [article];
}
