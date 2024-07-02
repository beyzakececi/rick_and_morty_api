import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data_provider.dart';
import 'models/character_model.dart';

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
                  decoration: const InputDecoration(
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
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Characters'),
              Tab(text: 'Locations'),
            ],
          ),
        ),
        body: dataProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : const TabBarView(
          children: [
            CharacterList(),
            LocationList(),
          ],
        ),
      ),
    );
  }
}

class CharacterCard extends StatefulWidget {
  final Character character;

  const CharacterCard({required this.character});

  @override
  _CharacterCardState createState() => _CharacterCardState();
}

class _CharacterCardState extends State<CharacterCard> {
  bool isFollowed = false;

  void toggleFollow() {
    setState(() {
      isFollowed = !isFollowed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.character.image),
                ),
                const SizedBox(width: 10),
                Text(
                  widget.character.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text('Status: ${widget.character.status}'),
            Text('Species: ${widget.character.species}'),
            Text('Gender: ${widget.character.gender}'),
            Text('Episode count: ${widget.character.episode.length}'),
            Text('Created: ${widget.character.created.substring(0, 10)}'),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: toggleFollow,
                child: Text(isFollowed ? 'Followed' : 'Follow'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CharacterList extends StatelessWidget {
  const CharacterList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final characters = Provider.of<DataProvider>(context).characters;

    return ListView.builder(
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return CharacterCard(character: character);
      },
    );
  }
}

class LocationList extends StatelessWidget {
  const LocationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locations = Provider.of<DataProvider>(context).locations;

    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: (context, index) {
        final location = locations[index];
        return ListTile(
          leading: const Icon(Icons.location_on),
          title: Text(location.name),
        );
      },
    );
  }
}
