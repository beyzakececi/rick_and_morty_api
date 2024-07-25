import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/location_bloc.dart';
import '../../bloc/location_event.dart';
import '../../bloc/location_state.dart';
import '../../models/location_model.dart';

class LocationCard extends StatefulWidget {
  final LocationModel location;

  const LocationCard({super.key, required this.location});

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black54,
        // Card background color
        border: Border.all(color: Colors.grey.shade800, width: 2),
        // Border color and width
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(0),
      // Remove padding to align image with edges
      child: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          bool isFavorite = false; // Varsayılan olarak favori değil

          // Eğer favoriler durumu takip ediliyorsa ve bu lokasyon favoriyse, durumu güncelle
          if (state is LocationLoaded) {
            isFavorite = state.favoriteLocations.contains(widget.location.name);
          }
          final locationBloc = context.read<LocationBloc>();

          return ExpansionTile(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Location details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.location.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Type: ${widget.location.type}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Dimension: ${widget.location.dimension}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: isFavorite
                      ? const Icon(Icons.favorite, color: Colors.red, size: 30)
                      : const Icon(Icons.favorite_border,
                          color: Colors.white, size: 30),
                  onPressed: () {
                    if (isFavorite) {
                      locationBloc
                          .add(RemoveFavoriteLocation(widget.location.name));
                    } else {
                      locationBloc
                          .add(AddFavoriteLocation(widget.location.name));
                    }
                  },
                ),
              ],
            ),
            children: [
              if (state is LocationLoaded)
                ...state.characters
                    .where((character) =>
                        character.location.name == widget.location.name)
                    .toList()
                    .map(
                      (character) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(character.image),
                        ),
                        title: Text(character.name),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
