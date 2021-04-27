import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/services.dart';
import 'package:time_machine/time_machine.dart';
import 'package:timetable/timetable.dart';

import './settings.dart';
import './main.dart';

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingScreen(),
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
        // width: MediaQuery.of(context).size.width / 2,
        // height: MediaQuery.of(context).size.height / 2,
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
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    allMakers.add(
      Marker(
        markerId: MarkerId('Unisa Gym'),
        draggable: false,
        onTap: () {
          print('unisa gym tapped');
          location_place_index = 0;
          _onItemTapped(0);
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
          _onItemTapped(1);
        },
        position: LatLng(-34.810876321901596, 138.62064432109077),
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
      markers: Set.from(allMakers),
    );

    // return new Scaffold(
    //   body: GoogleMap(
    //     mapType: MapType.hybrid,
    //     initialCameraPosition: _kGooglePlex,
    //     onMapCreated: (GoogleMapController controller) {
    //       _controller.complete(controller);
    //     },
    //   ),
    //   floatingActionButton: FloatingActionButton.extended(
    //       onPressed: _goToTheLake,
    //       label: Text('To the lake!'),
    //       icon: Icon(Icons.directions_boat)),
    // );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
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

// time tables
class MapTimetable extends StatefulWidget {
  @override
  _MapTimetableState createState() => _MapTimetableState();
}

class _MapTimetableState extends State<MapTimetable> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late TimetableController<BasicEvent> _controller;

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
          _showSnackBar('Background tapped $start is all day event $isAllDay');
        },
        eventBuilder: (event) {
          return BasicEventWidget(
            event,
            onTap: () => _showSnackBar('Part-day event $event tapped'),
          );
        },
        allDayEventBuilder: (context, event, info) => BasicAllDayEventWidget(
          event,
          info: info,
          onTap: () => _showSnackBar('All-day event $event tapped'),
        ),
      ),
    );
  }

  void _showSnackBar(String content) {}
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

    if (location_place_index == 0) {
      return _createScaffold(
          "UniSA Gym",
          "UniSA Mawson Lakes Gym",
          "The UniSA Sport gym at Mawson Lakes is designed to cater for people of all ability and fitness levels. It is fully air-conditioned and equipped with the latest gym",
          "assets/ml_gym.png");
    } else if (location_place_index == 1) {
      return _createScaffold(
          "Restaurants",
          "ZAMBRERO MAWSON LAKES",
          "We are about more than just delicious, Mexican inspired food made with healthy ingredients. We are a way to feel good inside, by helping in our mission to stop world hunger, one meal at a time. We are Feel Good Mex.",
          "assets/zambrer.png");
    } else {
      return _createScaffold("Others", "others", "others", "assets/ml_gym.png");
    }
  }
}
