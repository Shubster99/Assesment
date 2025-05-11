
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/article_provider.dart';
import '../widgets/article_card.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ArticleProvider>(context, listen: false).fetchArticles());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ArticleProvider>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: const Text("Articles", style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.indigo],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: "All Articles"),
              Tab(text: "Favorites"),
            ],
          ),
        ),
        body: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : provider.error.isNotEmpty
                ? Center(child: Text(provider.error, style: const TextStyle(color: Colors.red)))
                : Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: provider.search,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search articles...",
                            icon: Icon(Icons.search, color: Colors.deepPurple),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            RefreshIndicator(
                              onRefresh: provider.fetchArticles,
                              child: ListView.builder(
                                itemCount: provider.articles.length,
                                itemBuilder: (context, index) {
                                  final article = provider.articles[index];
                                  return ArticleCard(
                                    article: article,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => DetailScreen(article: article),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            ListView.builder(
                              itemCount: provider.favorites.length,
                              itemBuilder: (context, index) {
                                final article = provider.favorites[index];
                                return ArticleCard(
                                  article: article,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => DetailScreen(article: article),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}

