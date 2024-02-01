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
