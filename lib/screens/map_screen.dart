import 'package:flutter/material.dart';
// import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import '../models/place.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLoaction;
  final bool isSelecting;
  const MapScreen(
      {this.initialLoaction =
          const PlaceLocation(latitude: 21.7679, longitude: 78.8718),
      this.isSelecting = false,
      super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  void _selectLocation(tapPosition, point) {
    setState(() {
      _pickedLocation = point;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: _pickedLocation == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_pickedLocation);
                    },
              icon: const Icon(Icons.check),
            )
        ],
        title: const Text('Your Map'),
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      // body: OpenStreetMapSearchAndPick(
      //   onPicked: (pickedData) {
      //     print(pickedData.latLong.latitude);
      //     print(pickedData.latLong.longitude);
      //   },
      // ),
      body: FlutterMap(
        options: MapOptions(
          onTap: widget.isSelecting ? _selectLocation : null,
          initialCenter: LatLng(widget.initialLoaction.latitude,
              widget.initialLoaction.longitude),
          initialZoom: 4,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: _pickedLocation == null
                ? <Marker>[]
                : [
                    Marker(
                      point: _pickedLocation!,
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                      ),
                    ),
                  ],
          ),
          // RichAttributionWidget(
          //   attributions: [
          //     TextSourceAttribution(
          //       'OpenStreetMap contributors',
          //       onTap: () =>
          //           http.get(Uri.parse('https://openstreetmap.org/copyright')),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
