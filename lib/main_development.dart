import 'package:clean_architecture/app/app.dart';
import 'package:clean_architecture/bootstrap.dart';
import 'package:clean_architecture/features/news/data/datasource/network_remote_data_source.dart';
import 'package:clean_architecture/features/news/data/repositories/news_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white.withOpacity(0),
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

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

//   final databasesPath = await getDatabasesPath();
//   final path = join(databasesPath, 'news.db');
//
//   await Directory(databasesPath).create(recursive: true);
//
//   final db = await openDatabase(
//     path,
//     version: 1,
//     onCreate: (db, version) async {
//       await db.execute('''
// CREATE TABLE article (
//     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     author TEXT,
//     title TEXT,
//     description TEXT,
//     url TEXT,
//     urlToImage TEXT,
//     publishedAt TEXT,
//     content TEXT
// )
// ''');
//     },
//   );
  final remoteSource = NewsNetworkRemoteDataSourceImpl(dio: dio);
  // final localSource = NewsLocalRemoteDataSourceImpl(database: db);
  final impl = NewsRepositoryImpl(
    // localRemoteSource: localSource,
    networkRemoteSource: remoteSource,
  );
  await bootstrap(() => App(impl: impl));
}
