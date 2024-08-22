import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:navicode/constants/colors.dart';
import 'package:navicode/widgets/search_field.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final FocusNode _focusNode = FocusNode();
  late GoogleMapController _googleMapController;
  String _currentAddress = "Fetching location ...";
  Position? _initialPosition;
  int _currentIndex = 0;
  final LatLng _defaultLatLng = const LatLng(35.234108, 129.080073);

  double _latitude = 35.234108;
  double _longitude = 129.080073;

  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _googleMapController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _currentAddress = 'Location services are disabled.';
      });
      return;
    }

    // 위치 권한 확인.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _currentAddress = 'Location permissions are denied.';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _currentAddress = 'Location permissions are permanently denied.';
      });
      return;
    }

    // 현재 위치 가져오기
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    if (mounted) {
      setState(() {
        _initialPosition = position;
        _currentAddress =
            'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
  }

  void _onMapTapped(LatLng position) {
    final String markerId = position.toString();

    if (_markers.any((marker) => marker.markerId.value == markerId)) {
      setState(() {
        _markers.removeWhere((marker) => marker.markerId.value == markerId);
      });
      return;
    }

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: position,
          onTap: () {
            _onMarkerTapped(markerId);
          },
        ),
      );
    });
  }

  void _onMarkerTapped(String markerId) {
    setState(() {
      _markers.removeWhere((marker) => marker.markerId.value == markerId);
    });
    _googleMapController
        .moveCamera(CameraUpdate.newLatLng(LatLng(_latitude, _longitude)));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _focusNode.unfocus,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
        ),
        backgroundColor: mainColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: SearchField(focusNode: _focusNode),
            ),
            Flexible(
              // 같은 부모 같은 깊이에 있는 flexible 끼리 비율을 나누어 가짐
              flex: 1,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _initialPosition != null
                      ? LatLng(_initialPosition!.latitude,
                          _initialPosition!.longitude)
                      : _defaultLatLng,
                  zoom: 15,
                ),
                markers: _markers,
                onTap: (latlng) {
                  _onMapTapped(latlng);
                  _latitude = latlng.latitude;
                  _longitude = latlng.longitude;
                  log("$_latitude, $_longitude");
                },
                myLocationEnabled: true,
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.white,
                child: Column(
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Text(
                          "네비코드 검색 결과",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        // 아래 특정 위젯들을 받을 위젯 column과 비슷함.
                        children: const [
                          ListTile(
                            leading: CircleAvatar(child: Icon(Icons.abc)),
                            title: Text("053#56"),
                            subtitle: Text("3일 전 검색 2024.08.03"),
                            trailing: Icon(Icons.arrow_right),
                          ),
                          ListTile(
                            leading: CircleAvatar(child: Icon(Icons.park)),
                            title: Text("부산 시민공원 분수대"),
                            subtitle: Text("3일 전 검색 2024.08.03"),
                            trailing: Icon(Icons.arrow_right),
                          ),
                          ListTile(
                            leading: CircleAvatar(child: Icon(Icons.abc)),
                            title: Text("053#56"),
                            subtitle: Text("3일 전 검색 2024.08.03"),
                            trailing: Icon(Icons.arrow_right),
                          ),
                          ListTile(
                            leading: CircleAvatar(child: Icon(Icons.park)),
                            title: Text("부산 시민공원 분수대"),
                            subtitle: Text("3일 전 검색 2024.08.03"),
                            trailing: Icon(Icons.arrow_right),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          // 하단 바

          currentIndex: _currentIndex,
          onTap: (selectedIndex) => setState(() {
            _currentIndex = selectedIndex;
            if (_currentIndex == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MapScreen(),
                ),
              );
            }
          }),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.note), label: "Code"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Login"),
          ],
        ),
      ),
    );
  }
}
