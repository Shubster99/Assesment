import 'package:dio/dio.dart';
import '../models/article.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Article>> fetchArticles() async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/posts');
      return (response.data as List).map((e) => Article.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load articles');
    }
  }
}
