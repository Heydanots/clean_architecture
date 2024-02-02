import 'package:clean_architecture/features/news/domain/entities/article.dart';

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

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json['id'] as int?,
        author: json['author'] as String?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        url: json['url'] as String?,
        urlToImage: json['urlToImage'] as String?,
        publishedAt: json['publishedAt'] as String?,
        content: json['content'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'author': author,
        'title': title,
        'description': description,
        'url': url,
        'urlToImage': urlToImage,
        'publishedAt': publishedAt,
        'content': content,
      };

  Article toEntity() => Article(
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
