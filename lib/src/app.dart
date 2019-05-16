import 'package:flutter/material.dart';

import 'blocs/stories_provider.dart';
import 'screens/news_list.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return StoriesProvider(
      child: MaterialApp(
        title: 'Top Hacker News',
        home: NewsList(),
      ),
    );
  }
}
