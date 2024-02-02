import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:sqflite/sqflite.dart';

Future<Either<Failure, T>> errorHandler<T>(
  AsyncCallback<T> asyncCallback,
) async {
  try {
    return Right(await asyncCallback());
  } on SocketException catch (e) {
    final error = Failure('${e.runtimeType}', e.message);
    return Left(error);
  } on DioException catch (e) {
    final error = Failure('${e.runtimeType}', '${e.message}');
    return Left(error);
  } on DatabaseException catch (e) {
    final error = Failure('${e.runtimeType}', '${e.getResultCode()}');
    return Left(error);
  } catch (e) {
    final error = Failure('${e.runtimeType}', '$e');
    return Left(error);
  }
}

typedef AsyncCallback<T> = Future<T> Function();

class Failure {
  Failure(this.title, this.message);

  final String title;

  final String message;

  @override
  String toString() {
    return 'Failure{title: $title, message: $message}';
  }
}
