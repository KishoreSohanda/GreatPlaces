import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';

import '../screens/add_place_screen.dart';
import '../screens/place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Your Places'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddPlaceScreen.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : Consumer<GreatPlaces>(
                  builder: (context, greatPlaces, ch) =>
                      greatPlaces.items.isEmpty
                          ? ch!
                          : ListView.builder(
                              itemBuilder: (ctx, i) {
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        FileImage(greatPlaces.items[i].image),
                                  ),
                                  title: Text(greatPlaces.items[i].title),
                                  subtitle: Text(greatPlaces
                                      .items[i].location!.address as String),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        PlaceDetailScreen.routeName,
                                        arguments: greatPlaces.items[i].id);
                                  },
                                );
                              },
                              itemCount: greatPlaces.items.length,
                            ),
                  child: const Center(
                    child: Text('Got no places yet, start adding some!'),
                  ),
                );
        },
      ),
    );
  }
}
