import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../locations/bloc/location_bloc.dart';
import '../../../locations/bloc/location_event.dart';
import '../../../locations/bloc/location_state.dart';
import '../widget/location_card.dart';

class LocationListScreen extends StatefulWidget {
  const LocationListScreen({super.key});

  @override
  State<LocationListScreen> createState() => _LocationListScreenState();
}

class _LocationListScreenState extends State<LocationListScreen> {
  initState() {
    super.initState();

    context.read<LocationBloc>().add(FetchLocations());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            return Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  contentPadding: EdgeInsets.zero,
                  fillColor: Colors.grey[200],
                ),
                onChanged: (query) {
                  context.read<LocationBloc>().add(SearchLocations(query: query));
                },
              ),
            );
          }
        ),
      ),
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state is LocationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LocationLoaded) {
            final locations = state.locations;
            return ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                return LocationCard(location: locations[index]);
              },
            );
          } else if (state is LocationError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
