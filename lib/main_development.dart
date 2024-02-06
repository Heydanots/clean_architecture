import 'package:clean_architecture/app/app.dart';
import 'package:clean_architecture/bootstrap.dart';
import 'package:clean_architecture/features/news/data/datasource/network_remote_data_source.dart';
import 'package:clean_architecture/features/news/data/repositories/news_repository_impl.dart';
import 'package:clean_architecture/injection_container.dart';
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
  init();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  final remoteSource = NewsNetworkRemoteDataSourceImpl();
  final impl = NewsRepositoryImpl(
    networkRemoteSource: remoteSource,
  );
  await bootstrap(() => App(impl: impl));
}
