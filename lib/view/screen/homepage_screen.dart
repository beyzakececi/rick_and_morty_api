import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/colors.dart';
import '../../providers/data_provider.dart';
import '../widgets/search_bar_custom.dart';
import '../widgets/custom_tab_bar.dart';
import '../widgets/tab_bar_view_content.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: _buildAppBar(dataProvider),
        body: TabBarViewContent(dataProvider: dataProvider),
      ),
    );
  }

  AppBar _buildAppBar(DataProvider dataProvider) {
    return AppBar(
      backgroundColor: RickAndMortyColors.pink,
      title: Text(widget.title),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 50.0),
        child: Column(
          children: [
            SearchBarCustom(dataProvider: dataProvider),
            const CustomTabBar(),
          ],
        ),
      ),
    );
  }
}
