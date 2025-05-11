import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArticleProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Article> _articles = [];
  List<Article> get articles => _filteredArticles;
  List<Article> _filteredArticles = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _error = ''; 
  String get error => _error;

  List<int> _favoriteIds = [];

  Future<void> fetchArticles() async {
    _isLoading = true;
    notifyListeners();
    try {
      _articles = await _apiService.fetchArticles();
      _filteredArticles = _articles;
      await loadFavorites();
      _error = '';
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  void search(String query) {
    if (query.isEmpty) {
      _filteredArticles = _articles;
    } else {
      _filteredArticles = _articles.where((article) {
        return article.title.toLowerCase().contains(query.toLowerCase()) ||
               article.body.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  List<Article> get favorites =>
      _articles.where((a) => _favoriteIds.contains(a.id)).toList();

  void toggleFavorite(int id) {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    saveFavorites();
    notifyListeners();
  }

  bool isFavorite(int id) => _favoriteIds.contains(id);

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _favoriteIds.map((e) => e.toString()).toList());
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList('favorites') ?? [];
    _favoriteIds = favs.map(int.parse).toList();
  }
}
