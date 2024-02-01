import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/news/data/repositories/news_repo_impl.dart';
import 'package:clean_architecture/features/news/domain/entities/article.dart';
import 'package:clean_architecture/features/news/domain/usecases/get_top_headline_usecase.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc({required NewsRepositoryImpl newsRepositoryImpl})
      : _newsRepositoryImpl = newsRepositoryImpl,
        super(const NewsState()) {
    _getTopHeadLineUsecase = GetTopHeadLineUsecase(_newsRepositoryImpl);

    on<GetTopHeadlineEvent>(
      (event, emit) => errorHandler(() async {
        // await Future<void>.delayed(Duration(seconds: 5));
        emit(state.copyWith(state: BlocState.loading));
        final results = await _getTopHeadLineUsecase(params: event.queries);
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
  }

  late final GetTopHeadLineUsecase _getTopHeadLineUsecase;

  final NewsRepositoryImpl _newsRepositoryImpl;
}
