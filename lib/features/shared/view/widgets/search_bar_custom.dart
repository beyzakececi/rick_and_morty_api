import 'package:flutter/material.dart';
import '../../../locations/viewmodel/data_provider.dart';

class SearchBarCustom extends StatelessWidget {
  final DataProvider dataProvider;

  const SearchBarCustom({super.key, required this.dataProvider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.black38, fontSize: 16),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (query) {
                  dataProvider.search(query);
                },
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
