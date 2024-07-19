import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_cubit.dart';
import 'package:fyp/logic/cubits/staff_cubit/staff_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SecurityVisitorLocation extends StatefulWidget {
  final String appointmentId;

  const SecurityVisitorLocation({
    required this.appointmentId,
    Key? key,
  }) : super(key: key);

  @override
  _SecurityVisitorLocationState createState() =>
      _SecurityVisitorLocationState();
}

class _SecurityVisitorLocationState extends State<SecurityVisitorLocation> {
  late GoogleMapController _mapController;
  Marker? _liveMarker;
  bool _isLiveLocationVisible = false;
  Timer? _timer;
  List<Map<String, dynamic>> _mapTrackings = [];

  @override
  void initState() {
    super.initState();
    _startPeriodicFetching();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startPeriodicFetching() {
    context
        .read<StaffCubit>()
        .fetchAppointmentVisitorLocation(widget.appointmentId);
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      context
          .read<StaffCubit>()
          .fetchAppointmentVisitorLocation(widget.appointmentId);
    });
  }

  void _initializeLiveMarker(List<Map<String, dynamic>> mapTrackings) {
    if (mapTrackings.isNotEmpty) {
      final initialLocation = mapTrackings.first;
      _liveMarker = Marker(
        markerId: const MarkerId('liveLocation'),
        position: LatLng(
          initialLocation['latitude'] ?? 0.0,
          initialLocation['longitude'] ?? 0.0,
        ),
      );
    }
  }

  void _updateLiveMarker(List<Map<String, dynamic>> mapTrackings) {
    if (mapTrackings.isNotEmpty) {
      final newLocation = mapTrackings.first;
      setState(() {
        _liveMarker = _liveMarker?.copyWith(
          positionParam: LatLng(
            newLocation['latitude'] ?? 0.0,
            newLocation['longitude'] ?? 0.0,
          ),
        );
      });
      // Move the camera to the new location if the live location view is visible
      if (_isLiveLocationVisible) {
        _mapController.animateCamera(
          CameraUpdate.newLatLng(
            LatLng(
              newLocation['latitude'] ?? 0.0,
              newLocation['longitude'] ?? 0.0,
            ),
          ),
        );
      }
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _openLocationOnMap(double latitude, double longitude) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Location'),
          ),
          body: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(latitude, longitude),
              zoom: 14.0,
            ),
            markers: {
              Marker(
                markerId: MarkerId('location'),
                position: LatLng(latitude, longitude),
              ),
            },
          ),
        ),
      ),
    );
  }

  void _openLiveLocationOnMap() {
    setState(() {
      _isLiveLocationVisible = true;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Live Location'),
          ),
          body: GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _liveMarker?.position ?? LatLng(0, 0),
              zoom: 14.0,
            ),
            markers: {
              if (_liveMarker != null) _liveMarker!,
            },
          ),
        ),
      ),
    ).then((_) {
      setState(() {
        _isLiveLocationVisible = false;
      });
    });
  }

  void _updateMapTrackings(List<Map<String, dynamic>> newTrackings) {
    setState(() {
      // Add new trackings at the top of the list
      _mapTrackings = newTrackings + _mapTrackings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visitor Locations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.location_on),
            onPressed: _openLiveLocationOnMap,
          ),
        ],
      ),
      body: BlocListener<StaffCubit, StaffState>(
        listener: (context, state) {
          if (state is AppointmentLoaded) {
            _initializeLiveMarker(state.mapTrackings);
            _updateMapTrackings(state.mapTrackings);
            _updateLiveMarker(state.mapTrackings);
          }
        },
        child: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: _openLiveLocationOnMap,
                child: const Text('Live Location'),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _mapTrackings.length,
                itemBuilder: (context, index) {
                  final tracking = _mapTrackings[index];
                  final latitude = tracking['latitude'] ?? 0.0;
                  final longitude = tracking['longitude'] ?? 0.0;
                  final time = tracking['time'] ?? 'N/A';

                  return ListTile(
                    title: Text('Latitude: $latitude, Longitude: $longitude'),
                    subtitle: Text('Time: $time'),
                    onTap: () => _openLocationOnMap(latitude, longitude),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
