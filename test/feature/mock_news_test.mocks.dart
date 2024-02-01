// Mocks generated by Mockito 5.4.4 from annotations
// in clean_architecture/test/feature/mock_news_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:clean_architecture/features/news/data/datasources/local_remote_data_source.dart'
    as _i5;
import 'package:clean_architecture/features/news/data/datasources/network_remote_data_source.dart'
    as _i2;
import 'package:clean_architecture/features/news/data/models/article_model.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [NewsNetworkRemoteDataSourceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockNewsNetworkRemoteDataSourceImpl extends _i1.Mock
    implements _i2.NewsNetworkRemoteDataSourceImpl {
  @override
  _i3.Future<List<_i4.ArticleModel>> getTopHeadLine(
          Map<String, dynamic>? queries) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopHeadLine,
          [queries],
        ),
        returnValue:
            _i3.Future<List<_i4.ArticleModel>>.value(<_i4.ArticleModel>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.ArticleModel>>.value(<_i4.ArticleModel>[]),
      ) as _i3.Future<List<_i4.ArticleModel>>);
}

/// A class which mocks [NewsLocalRemoteDataSourceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockNewsLocalRemoteDataSourceImpl extends _i1.Mock
    implements _i5.NewsLocalRemoteDataSourceImpl {
  @override
  _i3.Future<List<_i4.ArticleModel>> getTopHeadLine(
          Map<String, dynamic>? queries) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTopHeadLine,
          [queries],
        ),
        returnValue:
            _i3.Future<List<_i4.ArticleModel>>.value(<_i4.ArticleModel>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.ArticleModel>>.value(<_i4.ArticleModel>[]),
      ) as _i3.Future<List<_i4.ArticleModel>>);

  @override
  _i3.Future<void> saveArticles({required List<_i4.ArticleModel>? articles}) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveArticles,
          [],
          {#articles: articles},
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
