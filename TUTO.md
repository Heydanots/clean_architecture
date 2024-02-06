# Explication

Pour pouvoir faire de la clean architecture, il faut avoir 3 couches :

- domain
- data
- presentation

je les ai classé selon ordre de priorité

## 1. La couche Domain

La couche de domaine constitue le cœur de l'application et est la première sur laquelle toutes les autres couches
reposent. Elle comprend :

### 1. Entities :

Ces entités définissent les objets de base de l'application. Par exemple, la classe "Article" est définie avec des
attributs tels que "id", "author", etc.

```dart
import 'package:equatable/equatable.dart';

/// !!! On ne place pas d'autre méthode telle que copyWith, toJson et fromJson
class Article extends Equatable {
  const Article({
    this.id,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  final int? id;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

// @override
// List<Object?> get props {
//   return [
//     id,
//     author,
//     title,
//     description,
//     url,
//     urlToImage,
//     publishedAt,
//     content,
//   ];
// }
}
```

### 2. Repositories :

Les repositories sont des classes abstraites contenant des méthodes ou des fonctions. Elles définissent des méthodes ou
fonctions pour l'accès aux données, comme la méthode "getTopHeadLine" qui récupère une liste d'articles.

Dans la feature **[news]** nous n'avons qu'une seul classe abstraite dans repositories qui s'appelle *
*[news_repository.dart]**

```dart
import 'package:clean_architecture/features/news/domain/entities/article.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

///Dans cette classe abstraite, nous n'avons que 2 fonctions,
/// - La première servira à connaitre l'état de connection sur internet
/// - La deuxième permettra de récuperer une liste d'article
abstract class NewsRepository {
  // Future<ConnectivityResult> get connectionState async =>
  //     Connectivity().checkConnectivity();

  Future<List<Article>> getTopHeadLine({
    Map<String, dynamic>? queries,
  });
}
```

### 3. Usecases

Les cas d'utilisation représentent des scénarios spécifiques d'utilisation du système.

Mais avant de créer une usecase, j'ai crée une classe abstraite qui nous permettra de définir
resultats qu'on attend d'une usecase et les paramêtres qu'on lui donne.

j'ai crée cette classe dans le dossier core/usecase, la fonction call sert à appélé la fonction un peu comme **[onTap]**

```dart
///- Type : C'est la valeur qu'on veut recupere si le usecase reussi
/// - Params : C'est les paramêtres qu'on lui attribue un peu comme dans les fonctions 
abstract class Usecase<Type, Params> {
  Future<Type> call({Params? params});
}

```

La usecase pour recupérer les articles sur internet, je l'ai appelé **[GetTopHeadLineUsecase]**
comme il implemente la classe Usecase, il va recevoir une **[List<'Article>]** et comme paramêtre j'ai mis une map pour
pouvoir mettre
les attributs que l'API News offre.

```dart
import 'package:clean_architecture/core/usecase/usecase.dart';
import 'package:clean_architecture/features/news/domain/entities/article.dart';
import 'package:clean_architecture/features/news/domain/repositories/news_repository.dart';

class GetTopHeadLineUsecase
    implements Usecase<List<Article>, Map<String, dynamic>> {
  const GetTopHeadLineUsecase(this.repository);

  /// 1 - on crée un objet [NewsRepository] qui est une classe abstraite
  final NewsRepository repository;

  /// 2 - on appelle la fonction de [NewsRepository] en rapport avec l'objectif
  /// de cette usecase , ici c'est la fonction getTopHeadLine
  @override
  Future<List<Article>> call({Map<String, dynamic>? params}) async =>
      repository.getTopHeadLine(queries: params);
}

```

A ce niveau, on a seulement definie les elements de base telle que les entities, le repository
et le usecase qui seront utilisé dans la couche **Data**.

## 2. La couche Data

La couche de données donne forme aux données qui seront récupérées, que ce soit à partir d'une API ou de données
locales. Elle comprend :

### 1. Models

Les modèles sont des classes qui définissent la structure des données. Ils sont similaires aux entités de la couche de
domaine, mais peuvent inclure des méthodes supplémentaires telles que "fromJson" et "toJson".

Avant je ne trouvais pas normal de créer 2 fois la même choses au lieu
de faire une classe qui a tout mais dans la clean architecture chaque objet doit être independante
donc dans la couche **Data** si on veut utilisé une classe Article c'est celui de **models** qu'on va utilisé et pas
celui de la couche **Domain**.

```dart
import 'package:clean_architecture/features/news/domain/entities/article.dart';

///Pour bien montre que le model dans data et le même que celui de domain, 
///la classe [data] doit extend l'entitie [domain]
class ArticleModel extends Article {
  const ArticleModel({
    super.id,
    super.author,
    super.title,
    super.description,
    super.url,
    super.urlToImage,
    super.publishedAt,
    super.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      ArticleModel(
        id: json['id'] as int?,
        author: json['author'] as String?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        url: json['url'] as String?,
        urlToImage: json['urlToImage'] as String?,
        publishedAt: json['publishedAt'] as String?,
        content: json['content'] as String?,
      );

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'author': author,
        'title': title,
        'description': description,
        'url': url,
        'urlToImage': urlToImage,
        'publishedAt': publishedAt,
        'content': content,
      };

  Article toEntity() =>
      Article(
        id: id,
        url: url,
        urlToImage: urlToImage,
        title: title,
        publishedAt: publishedAt,
        description: description,
        content: content,
        author: author,
      );
}

```

### 2. Datasource

Les sources de données représentent les différentes sources à partir desquelles les données sont récupérées. Par
exemple, [NewsNetworkRemoteDataSource] est une source de données qui récupère des articles à partir d'une API.

```dart
import 'package:clean_architecture/features/news/data/models/article_model.dart';
import 'package:clean_architecture/injection_container.dart';
import 'package:dio/dio.dart';

///J'ai crée une classe abstraite qu va contenir les mêmes fonctions
///qui se trouve dans la classe abstraite [NewsRepository] de la couche Domain
abstract class NewsNetworkRemoteDataSource {
  NewsNetworkRemoteDataSource({Dio? dio}) : _dio = dio ?? getIt<Dio>();
  final Dio _dio;

  Future<List<ArticleModel>> getTopHeadLine(Map<String, dynamic> queries,);
}

class NewsNetworkRemoteDataSourceImpl extends NewsNetworkRemoteDataSource {
  NewsNetworkRemoteDataSourceImpl({super.dio});

  @override
  Future<List<ArticleModel>> getTopHeadLine(Map<String, dynamic> queries,) async {
    final request = await _dio.get<Map<dynamic, dynamic>>('/top-headlines');
    return (request.data?['articles'] as List<dynamic>)
        .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

```

### 3. Repositories

Les repositories regroupent les différentes sources de données dans un seul endroit.

Si j'avais crée une data source [LocalRemoteDataSource] et [NewsNetworkRemoteDataSource], j'allais faire
en sorte que s'il n'y a pas internet c'est dans [LocalRemoteDataSource] qu'on va récupérer les articles enregistré
mais dans cette exemple, je n'ai crée qu'une **data source** [NewsNetworkRemoteDataSource] et je l'ai mis dans un
repository appelé [NewsRepositoryImpl] qui la classe jumelle de [NewsRepository] de la couche **Domain**.

```dart
import 'package:clean_architecture/features/news/data/datasource/network_remote_data_source.dart';
import 'package:clean_architecture/features/news/data/models/article_model.dart';
import 'package:clean_architecture/features/news/domain/repositories/news_repository.dart';
import 'package:collection/collection.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// On entend la classe [NewsRepository] de la couche Domain pour recuperer ses
/// fonctions à implementer
class NewsRepositoryImpl extends NewsRepository {
  NewsRepositoryImpl({
    required this.networkRemoteSource,
  });

  final NewsNetworkRemoteDataSourceImpl networkRemoteSource;

  ///Dans le NewsAPI il y'a 3 paramêtres
  ///1. category
  ///2. country
  ///3. source
  final _queries = {
    'category': 'general',
  };

  @override
  Future<List<ArticleModel>> getTopHeadLine({
    Map<String, dynamic>? queries,
  }) async {
    // const state = ConnectivityResult.wifi;
    final result = <ArticleModel>[];
    // if (state == ConnectivityResult.wifi ||
    //     state == ConnectivityResult.mobile) {
    final request = await networkRemoteSource.getTopHeadLine(_queries);
    result.addAll(
      request
          .mapIndexed(
            (index, e) =>
            ArticleModel(
              id: index,
              url: e.url,
              urlToImage: e.urlToImage,
              title: e.title,
              publishedAt: e.publishedAt,
              description: e.description,
              content: e.content,
              author: e.author,
            ),
      )
          .toList(),
    );
    // }

    return result;
  }
}
```

J'avais réalisé des tests dans le dossier test, mais pour voir celui du repository [NewsRepositoryImpl]
c'est dans **test/feature/news_test.dart**