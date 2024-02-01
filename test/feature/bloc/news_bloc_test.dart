// import 'package:bloc_test/bloc_test.dart';
// import 'package:clean_architecture/features/news/presentation/bloc/news_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// import '../usecase/get_top_headline_usecase.mocks.dart';
//
// class MockNewsBloc extends MockBloc<NewsEvent, NewsState> implements NewsBloc {}
//
// // @GenerateNiceMocks([MockSpec<NewsBloc>()])
// void main() {
//   final remoteSource = MockNewsRepositoryImpl();
//   late MockNewsBloc newsBloc;
//
//   // whenListen(newsBloc, const Stream.empty());
//   setUpAll(() {
//     newsBloc = MockNewsBloc();
//   });
//
//   group('Test global du bloc ', () {
//     blocTest(
//       'description',
//       build: () => newsBloc,
//       expect: () => [],
//     );
//
//     blocTest(
//       'description',
//       build: () => newsBloc,
//       act: (bloc) => bloc.add(const GetTopHeadlineEvent()),
//       expect: () => <NewsState>[],
//     );
//   });
// }
