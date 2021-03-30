import 'package:flutter/material.dart';
import './settings.dart';

const mainColor = const Color(0xFF4166F6);

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('${this} hashCode=${this.hashCode}');
    return Scaffold(
      appBar: AppBar(
        title: Text('UNISA MAP'),
        backgroundColor: mainColor,
        leading: Icon(Icons.menu),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.settings,
                size: 25,
              )),
        ],
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 2,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("LOGOUT"),
                  style: ElevatedButton.styleFrom(
                      primary: mainColor, padding: EdgeInsets.all(15)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 0, bottom: 0, top: 45, right: 0),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingScreen(),
                      ),
                    ),
                  },
                  child: Text("SETTINGS"),
                  style: ElevatedButton.styleFrom(
                      primary: mainColor, padding: EdgeInsets.all(15)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
