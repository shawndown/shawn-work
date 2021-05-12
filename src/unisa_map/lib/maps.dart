import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/services.dart';
import 'package:time_machine/time_machine.dart';
import 'package:timetable/timetable.dart';

import 'package:geolocator/geolocator.dart';

import './settings.dart';
import './main.dart';
import './navigation.dart';
import './data.dart';

const mainColor = const Color(0xFF4166F6);
int location_place_index = 0;

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print('${this} hashCode=${this.hashCode}');

    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Text('UNISA MAP'),
        backgroundColor: mainColor,
        leading: Builder(
          builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer()),
        ),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () => {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SettingScreen(),
              //   ),
              // ),
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                      'Object Oriented Programming\nRoom 981 \nThe class will start in 30 minutes!'),
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 10),
                  backgroundColor: Colors.redAccent[200],
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: () {
                      print('Action is clicked');
                    },
                    textColor: Colors.white,
                    disabledTextColor: Colors.grey,
                  ),
                ),
              ),
            },
            icon: Icon(
              Icons.settings,
              size: 25,
              color: Colors.white,
            ),
            label: Text(''),
          ),
        ],
      ),
      body: Container(
        child: UnisaMap(),
      ),
      bottomNavigationBar: BottomWidget(),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('UniSA MAP'),
              decoration: BoxDecoration(
                color: mainColor,
              ),
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: Text('logout'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginStatefulWidget(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UnisaMap extends StatefulWidget {
  @override
  State<UnisaMap> createState() => UnisaMapState();
}

class UnisaMapState extends State<UnisaMap> {
  List<Marker> allMakers = [];
  Completer<GoogleMapController> _controller = Completer();
  late int _selectedIndex;
  late Timer timer;

  // store current position
  late Position _currentPosition;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
        Duration(seconds: 15),
        (Timer t) => {
              print("show snack bar"),
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text(
                      'Object Oriented Programming\nRoom 981 \nThe class will start in 30 minutes!'),
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 10),
                  backgroundColor: Colors.redAccent[200],
                  action: SnackBarAction(
                    label: 'OK',
                    onPressed: () {
                      print('Action is clicked');
                    },
                    textColor: Colors.white,
                    disabledTextColor: Colors.grey,
                  ),
                ),
              ),
            });

    _determinePosition();
    _getCurrentLocation();

    allMakers.add(
      Marker(
        markerId: MarkerId('Unisa Gym'),
        draggable: false,
        onTap: () {
          print('unisa gym tapped');
          location_place_index = 0;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.81013780276416, 138.62187383330925),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('Zambrero Mawson Lakes'),
        draggable: false,
        onTap: () {
          print('Zambrero Mawson Lake tapped');
          location_place_index = 1;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.810876321901596, 138.62064432109077),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('C Building'),
        draggable: false,
        onTap: () {
          location_place_index = 2;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.81023470180519, 138.62100651584987),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('W Building'),
        draggable: false,
        onTap: () {
          location_place_index = 3;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.81265084357963, 138.62033567532623),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('GP Building'),
        draggable: false,
        onTap: () {
          location_place_index = 4;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.8105088777755, 138.62132301651206),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('A Building'),
        draggable: false,
        onTap: () {
          location_place_index = 5;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.8109493191998, 138.62076243483045),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('E Building'),
        draggable: false,
        onTap: () {
          location_place_index = 6;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.81092245072467, 138.6200486791957),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('F Building'),
        draggable: false,
        onTap: () {
          location_place_index = 7;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.81035953828779, 138.6199591360638),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('R Building'),
        draggable: false,
        onTap: () {
          location_place_index = 8;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.810622967812265, 138.61872412487153),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('G Building'),
        draggable: false,
        onTap: () {
          location_place_index = 9;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.810637644367034, 138.61796817735134),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('X Building'),
        draggable: false,
        onTap: () {
          location_place_index = 10;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.8098980640614, 138.61809380502714),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('MC Building'),
        draggable: false,
        onTap: () {
          location_place_index = 11;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.810727622529846, 138.61731865553284),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('IW Building'),
        draggable: false,
        onTap: () {
          location_place_index = 12;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.809748830421434, 138.61892775895888),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('Q Building'),
        draggable: false,
        onTap: () {
          location_place_index = 13;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.81007802188638, 138.6188529169409),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('H Building'),
        draggable: false,
        onTap: () {
          location_place_index = 14;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.80936257742281, 138.61975102117896),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('MM Building'),
        draggable: false,
        onTap: () {
          location_place_index = 15;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.80918077890929, 138.6184283210212),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('P Building'),
        draggable: false,
        onTap: () {
          location_place_index = 16;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.80866786810513, 138.61866698315893),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('SCT Building'),
        draggable: false,
        onTap: () {
          location_place_index = 17;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.80776170053167, 138.61839108019058),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('N Building'),
        draggable: false,
        onTap: () {
          location_place_index = 18;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.80742975647108, 138.61969279674935),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('L Building'),
        draggable: false,
        onTap: () {
          location_place_index = 19;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.80737050019683, 138.62018996159625),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('M Building'),
        draggable: false,
        onTap: () {
          location_place_index = 20;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.808055236727114, 138.62096243816003),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('V Building'),
        draggable: false,
        onTap: () {
          location_place_index = 21;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.80830762215844, 138.62186856118757),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('OC Building'),
        draggable: false,
        onTap: () {
          location_place_index = 22;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.80924912272739, 138.6208849232125),
      ),
    );
    allMakers.add(
      Marker(
        markerId: MarkerId('B Building'),
        draggable: false,
        onTap: () {
          location_place_index = 23;
          _onItemTapped(location_place_index);
        },
        position: LatLng(-34.810628627272614, 138.6219699310834),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    location_place_index = index;

    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 2,
          color: mainColor,
          child: Center(
            child: LocationIntro(),
          ),
        );
      },
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
      });
    }).catchError((e) {
      print(e);
    });
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-34.80903299847858, 138.61987035709035),
    zoom: 16,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      markers: Set.from(allMakers),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class BottomWidget extends StatefulWidget {
  const BottomWidget({Key? key}) : super(key: key);

  @override
  _BottomWidgetState createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: UNISA MAP',
      style: optionStyle,
    ),
    Text(
      'Index 1: TIMETABLE',
      style: optionStyle,
    ),
    Text(
      'Index 2: NAVIGATION',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (_selectedIndex) {
      case 0:
        setState(() {});
        break;

      case 1:
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height / 2,
              color: mainColor,
              child: Center(
                child: MapTimetable(),
              ),
            );
          },
        );
        break;

      case 2:
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height / 2,
              color: mainColor,
              child: Center(
                child: Container(
                  child: NavigtaionList(),
                ),
              ),
            );
          },
        );
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.map_outlined),
          label: 'UNISA MAP',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule_outlined),
          label: 'TIMETABLE',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pin_drop_outlined),
          label: 'NAVIGATION',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: mainColor,
      onTap: _onItemTapped,
    );
  }
}

// Navigation List
class NavigtaionList extends StatefulWidget {
  @override
  _NavigtaionListState createState() => _NavigtaionListState();
}

class _NavigtaionListState extends State<NavigtaionList> {
  final List<Data> address = [
    Data(
      name: "C Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.81003,
      dest_longitude: 138.62094,
    ),
    Data(
      name: "C Building Door",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.81023470180519,
      dest_longitude: 138.62100651584987,
    ),
    Data(
      name: "W Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.81265084357963,
      dest_longitude: 138.62100651584987,
    ),
    Data(
      name: "W Building Door 1",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.812584197501096,
      dest_longitude: 138.6203371977557,
    ),
    Data(
      name: "W Building Door 2",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.81280771618449,
      dest_longitude: 138.62034658548723,
    ),
    Data(
      name: "W Building Door 2",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.81280771618449,
      dest_longitude: 138.62034658548723,
    ),
    Data(
      name: "GP Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.8105088777755,
      dest_longitude: 138.62132301651206,
    ),
    Data(
      name: "GP Building Door",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.810507776669006,
      dest_longitude: 138.62112855635945,
    ),
    Data(
      name: "A Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.810949319199,
      dest_longitude: 138.62076243483045,
    ),
    Data(
      name: "A Building Door 1",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.81073900871729,
      dest_longitude: 138.62076511703944,
    ),
    Data(
      name: "A Building Door 2",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.8111078927713259,
      dest_longitude: 138.6207409678787,
    ),
    Data(
      name: "E Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.81092245072467,
      dest_longitude: 138.6200486791957,
    ),
    Data(
      name: "E Building Door",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.81084015382555,
      dest_longitude: 138.61986157414663,
    ),
    Data(
      name: "D Building Door",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.81084125111807,
      dest_longitude: 138.61967446909762,
    ),
    Data(
      name: "D Building Door",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.810941104677035,
      dest_longitude: 138.6196009635426,
    ),
    Data(
      name: "F Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.810359538287795,
      dest_longitude: 138.6199591360638,
    ),
    Data(
      name: "F Building Door 1",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.80999194231902,
      dest_longitude: 138.6200633803057,
    ),
    Data(
      name: "F Building Door 2",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.81000949917845,
      dest_longitude: 138.61959294475383,
    ),
    Data(
      name: "F Building Door 3",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.81019933248206,
      dest_longitude: 138.62021172788033,
    ),
    Data(
      name: "F Building Door 4",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.81045610053221,
      dest_longitude: 138.62019435384005,
    ),
    Data(
      name: "R Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.810622967812265,
      dest_longitude: 138.61872412487153,
    ),
    Data(
      name: "R Building Door 1",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.81060431378787,
      dest_longitude: 138.6192707389077,
    ),
    Data(
      name: "R Building Door 2",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.81059210660382,
      dest_longitude: 138.61833169573384,
    ),
    Data(
      name: "G Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.810637644367034,
      dest_longitude: 138.61796817735134,
    ),
    Data(
      name: "G Building Door 1",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.81071171176498,
      dest_longitude: 138.61790536351364,
    ),
    Data(
      name: "G Building Door 2",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.81057839040317,
      dest_longitude: 138.61787729775608,
    ),
    Data(
      name: "X Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.8098980640614,
      dest_longitude: 138.61809380502714,
    ),
    Data(
      name: "X Building Door 1",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.80999023763664,
      dest_longitude: 138.61784254967554,
    ),
    Data(
      name: "X Building Door 2",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.810075827292756,
      dest_longitude: 138.6183744626007,
    ),
    Data(
      name: "MC Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.810727622529846,
      dest_longitude: 138.61731865553284,
    ),
    Data(
      name: "MC Building Door 1",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.810778098039975,
      dest_longitude: 138.61747903128915,
    ),
    Data(
      name: "MC Building Door 2",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.8105761958139445,
      dest_longitude: 138.61729727209868,
    ),
    Data(
      name: "IW Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.809748830421434,
      dest_longitude: 138.61892775895888,
    ),
    Data(
      name: "IW Building Door 1",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.809841004165676,
      dest_longitude: 138.6189598341118,
    ),
    Data(
      name: "Q Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.81007802188638,
      dest_longitude: 138.6188529169409,
    ),
    Data(
      name: "Q Building Door 1",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.81011752477355,
      dest_longitude: 138.61920307067555,
    ),
    Data(
      name: "H Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.8093625774228,
      dest_longitude: 138.61975102117896,
    ),
    Data(
      name: "H Building Door 1",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.809443778486425,
      dest_longitude: 138.61978309633022,
    ),
    Data(
      name: "MM Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.80918077890929,
      dest_longitude: 138.6184283210212,
    ),
    Data(
      name: "MM Building Door 1",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.809290510297785,
      dest_longitude: 138.61871298798903,
    ),
    Data(
      name: "MM Building Door 2",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.80930148342877,
      dest_longitude: 138.61839090001175,
    ),
    Data(
      name: "P Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.80866786810513,
      dest_longitude: 138.61866698315893,
    ),
    Data(
      name: "P Building Door 1",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.8087490698532,
      dest_longitude: 138.61903852032776,
    ),
    Data(
      name: "P Building Door 2",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.80878418409794,
      dest_longitude: 138.6185948140686,
    ),
    Data(
      name: "SCT Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.80776170053167,
      dest_longitude: 138.61839108019058,
    ),
    Data(
      name: "SCT Building Door 1",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.8080239628339,
      dest_longitude: 138.61833494867457,
    ),
    Data(
      name: "N Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.80742975647108,
      dest_longitude: 138.61969279674935,
    ),
    Data(
      name: "L Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.80737050019683,
      dest_longitude: 138.62018996159625,
    ),
    Data(
      name: "M Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.808055236727114,
      dest_longitude: 138.62096243816003,
    ),
    Data(
      name: "V Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.80830762215844,
      dest_longitude: 138.62186856118757,
    ),
    Data(
      name: "OC Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.80924912272739,
      dest_longitude: 138.6208849232125,
    ),
    Data(
      name: "B Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.810628627272614,
      dest_longitude: -34.810628627272614,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navagation List'),
        backgroundColor: mainColor,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app_sharp),
            onPressed: () => {
              Navigator.pop(context),
            },
            tooltip: 'Minimise',
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: ListView.builder(
          itemBuilder: _buildNavItem,
          itemCount: address.length,
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index) {
    return ListTile(
      title: Text(address[index].name),
      leading: Icon(Icons.house_outlined),
      trailing: Icon(Icons.directions_walk),
      onTap: () {
        print(address[index]);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Navs(data: address[index])),
        );
      },
    );
  }
}

// time tables
class MapTimetable extends StatefulWidget {
  @override
  _MapTimetableState createState() => _MapTimetableState();
}

class _MapTimetableState extends State<MapTimetable> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late TimetableController<BasicEvent> _controller;

  final List<Data> address = [
    Data(
      name: "W Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.81265084357963,
      dest_longitude: 138.62100651584987,
    ),
    Data(
      name: "GP Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.8105088777755,
      dest_longitude: 138.62132301651206,
    ),
    Data(
      name: "A Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.810949319199,
      dest_longitude: 138.62076243483045,
    ),
    Data(
      name: "F Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.810359538287795,
      dest_longitude: 138.6199591360638,
    ),
    Data(
      name: "P Building",
      start_latitude: 0.0,
      start_longitude: 0.0,
      dest_latitude: -34.80866786810513,
      dest_longitude: 138.61866698315893,
    )
  ];

  @override
  void initState() {
    super.initState();

    _controller = TimetableController(
      // A basic EventProvider containing a single event:
      eventProvider: EventProvider.list([
        BasicEvent(
          id: 0,
          title: 'Object Oriented Programming\nRoom\n981',
          color: Colors.blue,
          start: LocalDate.today().at(LocalTime(7, 0, 0)),
          end: LocalDate.today().at(LocalTime(10, 0, 0)),
        ),
        BasicEvent(
          id: 1,
          title: 'Data Driven Web Techologies\nRoom\n801',
          color: Colors.redAccent,
          start: LocalDate.today().at(LocalTime(13, 0, 0)),
          end: LocalDate.today().at(LocalTime(17, 30, 0)),
        ),
        BasicEvent(
          id: 2,
          title: 'System Requirements and User Experience\nRoom\n801',
          color: Colors.yellowAccent,
          start: LocalDate.today().addDays(1).at(LocalTime(10, 0, 0)),
          end: LocalDate.today().addDays(1).at(LocalTime(11, 30, 0)),
        ),
        BasicEvent(
          id: 3,
          title: 'System Requirements Studio\nRoom\n301',
          color: Colors.purpleAccent,
          start: LocalDate.today().addDays(1).at(LocalTime(12, 0, 0)),
          end: LocalDate.today().addDays(1).at(LocalTime(14, 30, 0)),
        ),
        BasicEvent(
          id: 4,
          title: 'Data Driven Web Techologies\nRoom\n801',
          color: Colors.redAccent,
          start: LocalDate.today().addDays(2).at(LocalTime(10, 0, 0)),
          end: LocalDate.today().addDays(2).at(LocalTime(11, 30, 0)),
        ),
      ]),

      // // Or even this short example using a Stream:
      // eventProvider: EventProvider.stream(
      //   eventGetter: (range) => Stream.periodic(
      //     Duration(milliseconds: 16),
      //     (i) {
      //       final start =
      //           LocalDate.today().atMidnight() + Period(minutes: i * 2);
      //       return [
      //         BasicEvent(
      //           id: 0,
      //           title: 'Event',
      //           color: Colors.blue,
      //           start: start,
      //           end: start + Period(hours: 5),
      //         ),
      //       ];
      //     },
      //   ),
      // ),

      // Other (optional) parameters:
      initialTimeRange: InitialTimeRange.range(
        startTime: LocalTime(9, 0, 0),
        endTime: LocalTime(20, 0, 0),
      ),
      initialDate: LocalDate.today(),
      visibleRange: VisibleRange.days(3),
      firstDayOfWeek: DayOfWeek.monday,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Timetable'),
        backgroundColor: mainColor,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app_sharp),
            onPressed: () => {
              Navigator.pop(context),
            },
            tooltip: 'Minimise',
          ),
        ],
      ),
      body: Timetable<BasicEvent>(
        controller: _controller,
        onEventBackgroundTap: (start, isAllDay) {
          // _showSnackBar('Background tapped $start is all day event $isAllDay');
        },
        eventBuilder: (event) {
          return BasicEventWidget(
            event,
            onTap: () => {
              print(int.parse(event.id.toString())),
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Navs(data: address[int.parse(event.id.toString())])),
              )
            },
          );
        },
        allDayEventBuilder: (context, event, info) => BasicAllDayEventWidget(
          event,
          info: info,
          onTap: () => {},
        ),
      ),
    );
  }

  void _showSnackBar(String content) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(content),
    ));
  }
}

// location intruduction
class LocationIntro extends StatefulWidget {
  @override
  _LocationIntroState createState() => _LocationIntroState();
}

class _LocationIntroState extends State<LocationIntro> {
  @override
  void initState() {
    super.initState();
  }

  Scaffold _createScaffold(
      String title, String sub_title, String desc, String image_uri) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: mainColor,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app_sharp),
            onPressed: () => {
              Navigator.pop(context),
            },
          ),
        ],
      ),
      body: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.title_outlined),
              title: Text(sub_title),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                desc,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Image.asset(image_uri),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(location_place_index);

    switch (location_place_index) {
      case 0:
        return _createScaffold(
            "UniSA Gym",
            "UniSA Mawson Lakes Gym",
            "The UniSA Sport gym at Mawson Lakes is designed to cater for people of all ability and fitness levels. It is fully air-conditioned and equipped with the latest gym",
            "assets/ml_gym.png");
      case 1:
        return _createScaffold(
            "Restaurants",
            "ZAMBRERO MAWSON LAKES",
            "We are about more than just delicious, Mexican inspired food made with healthy ingredients. We are a way to feel good inside, by helping in our mission to stop world hunger, one meal at a time. We are Feel Good Mex.",
            "assets/zambrer.png");
      case 2:
        return _createScaffold(
          "Teaching Laboratory Building",
          "C Building",
          "This is the library, where students study.",
          "",
        );
      case 3:
        return _createScaffold(
          "Teaching Laboratory Building",
          "W Building",
          "defense  systems institute information strategy and technology services institute for telecommunication research",
          "",
        );
      case 4:
        return _createScaffold(
          "Teaching Laboratory Building",
          "GP Building",
          "GP HAS TUTORIAL ROOMS AND LECTURE THECTURE THEATRES AS WELL AS SECIENCES GAMES DEVELOPMENT LABORATORY",
          "",
        );
      case 5:
        return _createScaffold(
          "Teaching Laboratory Building",
          "A Building",
          "The A building has (caf, UNI books. Barbara hardy institute, security, prayer rooms, offices.",
          "",
        );
      case 6:
        return _createScaffold(
          "Teaching Laboratory Building",
          "E Building",
          "",
          "",
        );
      case 7:
        return _createScaffold(
          "Teaching Laboratory Building",
          "D Building",
          "This building contains(school of computer and information science office, lecture theatre, faculty offices, computer science laboratories.)",
          "",
        );
      case 8:
        return _createScaffold(
          "Teaching Laboratory Building",
          "F Building",
          "the F building is home to the school of electrical and information engineering.",
          "",
        );
      case 9:
        return _createScaffold(
          "Teaching Laboratory Building",
          "R Building",
          "two teaching labs PMB and MI drink machine in foyer all other spaces are dedicated labs.",
          "",
        );
      case 10:
        return _createScaffold(
          "Teaching Laboratory Building",
          "G Building",
          "the garth boomer building is split into two sections one building contains faculty offices while the other is research labs and tutorial rooms.",
          "",
        );
      case 11:
        return _createScaffold(
          "Teaching Laboratory Building",
          "X Building",
          "The X building is houses a number of research offices and laboratories relating to the environmental sciences.",
          "",
        );
      case 12:
        return _createScaffold(
          "Teaching Laboratory Building",
          "MC Building",
          "The building contains the mawson laskes library as well as a range of services provided by the mawson lakes council.",
          "",
        );
      case 13:
        return _createScaffold(
          "Teaching Laboratory Building",
          "IW Building",
          "lan wark research institute laboratories.",
          "",
        );
      case 14:
        return _createScaffold(
          "Teaching Laboratory Building",
          "Q Building",
          "The O building is home to the school of mathematics and statistics, with the building mostly comprising of offices for school staff.",
          "",
        );
      case 15:
        return _createScaffold(
          "Teaching Laboratory Building",
          "H Building",
          "the H building houses room related mostly to geology, soil and water science.",
          "",
        );
      case 16:
        return _createScaffold(
          "Teaching Laboratory Building",
          "MM Building",
          "Materials and mineral science building.",
          "",
        );
      case 17:
        return _createScaffold(
          "Teaching Laboratory Building",
          "P Building",
          "the P building is home to the school of natural and built environments.",
          "",
        );
      case 18:
        return _createScaffold(
          "Teaching Laboratory Building",
          "SCT Building",
          "SCT contain",
          "",
        );
      case 19:
        return _createScaffold(
          "Teaching Laboratory Building",
          "N Building",
          "N has laboratories for natural and built environment as well as laboratories for civil engineering.",
          "",
        );
      case 20:
        return _createScaffold(
          "Teaching Laboratory Building",
          "L Building",
          "",
          "",
        );
      case 21:
        return _createScaffold(
          "Teaching Laboratory Building",
          "M Building",
          "M contains the school of mechanical engineering and regenerative medicine laboratories.",
          "",
        );
      case 22:
        return _createScaffold(
          "Teaching Laboratory Building",
          "V Building",
          "The V building houses the Mawson institute and is accessible only via card ax.",
          "",
        );
      case 23:
        return _createScaffold(
          "Teaching Laboratory Building",
          "OC Building",
          "The OC building is home to the school of mathematics and statistics, with the building mostly comprising of offices for school staff.",
          "",
        );
      case 24:
        return _createScaffold(
          "Teaching Laboratory Building",
          "B Building",
          "The B building houses the mawson lakes campus sports center.",
          "",
        );
      default:
        return _createScaffold(
            "Others", "others", "others", "assets/ml_gym.png");
    }
  }
}
