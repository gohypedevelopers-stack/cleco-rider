import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget {
  final LatLng initialCenter;
  final double initialZoom;
  final List<Marker> markers;

  const MapWidget({
    super.key,
    this.initialCenter = const LatLng(28.6139, 77.2090), // New Delhi default
    this.initialZoom = 13.0,
    this.markers = const [],
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: initialCenter,
        initialZoom: initialZoom,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.cleclo_rider',
        ),
        MarkerLayer(
          markers: markers,
        ),
      ],
    );
  }
}
