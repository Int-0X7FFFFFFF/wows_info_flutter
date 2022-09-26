import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: true,
            title: const Text('搜索'),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
            bottom: AppBar(
              title: Container(
                width: double.infinity,
                height: 40,
                color: Theme.of(context).primaryColor,
                child: const Center(
                  child: TextField(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
