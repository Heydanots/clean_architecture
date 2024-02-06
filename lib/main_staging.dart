import 'package:clean_architecture/app/app.dart';
import 'package:clean_architecture/bootstrap.dart';
import 'package:clean_architecture/features/news/data/datasource/network_remote_data_source.dart';
import 'package:clean_architecture/features/news/data/repositories/news_repository_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white.withOpacity(0),
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final dio = Dio(
    BaseOptions(
      headers: {
        'Authorization': '3db4395bafb44c88b4761f9a09d7be0c',
      },
      baseUrl: 'https://newsapi.org/v2',
      queryParameters: {
        'country': 'us',
        'category': 'business',
      },
    ),
  );

  final remoteSource = NewsNetworkRemoteDataSourceImpl(dio: dio);
  final impl = NewsRepositoryImpl(
    networkRemoteSource: remoteSource,
  );
  await bootstrap(() => App(impl: impl));
}
