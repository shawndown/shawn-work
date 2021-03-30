import 'package:flutter/material.dart';

const mainColor = const Color(0xFF4166F6);

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SETTINGS'),
        backgroundColor: mainColor,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 30, right: 20.0, left: 20.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  enabled: false,
                  cursorColor: mainColor,
                  initialValue: 'yuexy003@myunisa.edu.au',
                  decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'User Email',
                    labelStyle: TextStyle(
                      color: mainColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              SizedBox(
                width: double.infinity,
                child: TextFormField(
                  enabled: false,
                  cursorColor: mainColor,
                  initialValue: 'Information Technology (LBCP)',
                  decoration: InputDecoration(
                    icon: Icon(Icons.book),
                    labelText: 'Program',
                    labelStyle: TextStyle(
                      color: mainColor,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: mainColor),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              SizedBox(
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Code',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Course Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: const <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('COMP 1046')),
                        DataCell(Text(
                          'Object Oriented Programming',
                          textAlign: TextAlign.left,
                        )),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('INFS 1025')),
                        DataCell(Text('Data Driven Web Technologies')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('INFS 1026')),
                        DataCell(
                            Text('System Requirements and User Experience')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('INFT 1031')),
                        DataCell(Text('System Requirements Studio')),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
