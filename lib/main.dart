import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'colors.dart';
import 'data_provider.dart';
import 'models/character_model.dart';
import 'models/location_model.dart';
import 'splash_screen.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Perasoft Demo',
      home: SplashScreen(),
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
          backgroundColor: RickAndMortyColors.pink,
          title: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white24, // Arka plan rengi
                    borderRadius: BorderRadius.circular(8.0), // Kenarları yuvarlatma
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    style: TextStyle(color: Colors.white),
                    onChanged: (query) {
                      dataProvider.search(query);
                    },
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
            ],
          ),
          bottom: const TabBar(
            indicatorColor: RickAndMortyColors.brown,
            labelStyle: TextStyle(color: RickAndMortyColors.brown, fontSize: 18), // Selected tab text style
            unselectedLabelStyle: TextStyle(color: RickAndMortyColors.brown, fontSize: 18), // Unselected tab text style
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: RickAndMortyColors.yellow, width: 4),
        borderRadius: BorderRadius.circular(4),
      ),
      margin: const EdgeInsets.all(10),
      child: Card(
        elevation: 0, // Kartın gölgesini kaldırmak için
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
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
                  buildInfoRow('Status', widget.character.status),
                  buildInfoRow('Species', widget.character.species),
                  buildInfoRow('Gender', widget.character.gender),
                  buildInfoRow('Episode count', widget.character.episode.length.toString()),
                  buildInfoRow('Created', widget.character.created.substring(0, 10)),
                ],
              ),
              Positioned(
                top: 8,
                right: 8,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      isFollowed ? RickAndMortyColors.green : RickAndMortyColors.peach,
                    ),
                  ),
                  onPressed: toggleFollow,
                  child: Text(isFollowed ? 'Followed' : 'Follow'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(value),
        ),
      ],
    ),
  );
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
        return LocationCard(location: location);
      },
    );
  }
}

class LocationCard extends StatefulWidget {
  final Location location;

  const LocationCard({required this.location});

  @override
  _LocationCardState createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  List<Character> charactersInLocation = [];

  @override
  void initState() {
    super.initState();
    _fetchCharacters();
  }

  void _fetchCharacters() async {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    charactersInLocation = dataProvider.characters
        .where((character) => character.location.name == widget.location.name)
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: RickAndMortyColors.yellow, width: 4),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: const EdgeInsets.all(10),
      child: Card(
        elevation: 0, // Kartın gölgesini kaldırmak için
        child: ExpansionTile(
          title: Text(widget.location.name),
          leading: const Icon(Icons.location_on),
          children: charactersInLocation
              .map((character) => ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(character.image),
            ),
            title: Text(character.name),
          ))
              .toList(),
        ),
      ),
    );
  }
}
