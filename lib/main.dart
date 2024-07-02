import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perasoft Demo',
      home: MyHomePage(title: 'Rick and Morty'),
    );
  }
}

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
        appBar: AppBar(
          backgroundColor: Color(0xFFe89ac7),
          title: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(color: Colors.white),
                  onChanged: (query) {
                    dataProvider.search(query);
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
            ],
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Characters'),
              Tab(text: 'Locations'),
            ],
          ),
        ),
        body: dataProvider.isLoading
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
          children: [
            CharacterList(),
            LocationList(),
          ],
        ),
      ),
    );
  }
}

class CharacterList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final characters = Provider.of<DataProvider>(context).characters;

    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return ListTile(
          leading: Image.network(character.image),
          title: Text(character.name),
        );
      },
    );
  }
}

class LocationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locations = Provider.of<DataProvider>(context).locations;

    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (context, index) {
        final location = locations[index];
        return ListTile(
          leading: Icon(Icons.location_on),
          title: Text(location.name),
        );
      },
    );
  }
}
