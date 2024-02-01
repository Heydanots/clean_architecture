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

  factory ArticleModel.fromJson(Map<String, dynamic> map) => ArticleModel(
        author: map['author'] as String?,
        title: map['title'] as String?,
        description: map['description'] as String?,
        url: map['url'] as String?,
        urlToImage: map['urlToImage'] as String?,
        publishedAt: map['publishedAt'] as String?,
        content: map['content'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'author': author,
        'title': title,
        'description': description,
        'url': url,
        'urlToImage': urlToImage,
        'publishedAt': publishedAt,
        'content': content,
      };
}
