import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_machine/time_machine.dart';

import './maps.dart';
import './settings.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import './gloabls.dart' as globals;

const mainColor = const Color(0xFF4166F6);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TimeMachine.initialize({'rootBundle': rootBundle});

  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  static const String _title = 'UniSA Map';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: LoginStatefulWidget(),
    );
  }
}

class LoginStatefulWidget extends StatefulWidget {
  const LoginStatefulWidget({Key? key}) : super(key: key);

  @override
  _LoginStatefulWidgetState createState() => _LoginStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _LoginStatefulWidgetState extends State<LoginStatefulWidget> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<bool> _verify(String user, String password) async {
    var url = Uri.parse('http://192.168.0.12:3000/auth');

    print(url);

    var response =
        await http.post(url, body: {'user': user, 'password': password});

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map<String, dynamic> res = convert.jsonDecode(response.body);

    var status = res['status'].toString();

    if (status == "success") {
      globals.user_num = user.split("_")[1];
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
                child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              color: mainColor,
              child: Center(
                child: Container(
                  width: 150,
                  height: 200,
                  child: Column(
                    children: [
                      Image.asset('assets/login_icon.png',
                          width: 300, height: 150, fit: BoxFit.fill),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 0, bottom: 0, top: 20, right: 0),
                        child: Text(
                          "UNISA MAP",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
            Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(top: 30.0),
              width: MediaQuery.of(context).size.width * (2 / 3),
              child: Column(
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 0, bottom: 10, top: 30, right: 0),
                      helperText: 'Please input your unisa email',
                      hintText: "Email",
                    ),
                  ),
                  TextField(
                    controller: _passwordController,
                    enableSuggestions: false,
                    autocorrect: false,
                    obscureText: true,
                    decoration: new InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 0, bottom: 10, top: 30, right: 0),
                      helperText: 'Please input your password',
                      hintText: "Password",
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.only(left: 0, bottom: 0, top: 45, right: 0),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        var is_verified = await this._verify(
                            _emailController.text.toString(),
                            _passwordController.text.toString());

                        if (is_verified) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapScreen(),
                              ));
                        } else {
                          // set up the button
                          Widget okButton = ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: mainColor,
                              padding: EdgeInsets.all(10),
                            ),
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          );
                          // set up the AlertDialog
                          AlertDialog alert = AlertDialog(
                            title: Text("Sorry"),
                            content: Text(
                                "The user email or password is not correct, please try again!"),
                            actions: [
                              okButton,
                            ],
                          );
                          // show the dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        }
                        print(is_verified);

                        // bool isUserVerified =
                        //     _emailController.text == 'yuexy003@myunisa.edu.au';
                        // bool isPasswordVerified =
                        //     _passwordController.text == '12345678';
                        // print(isUserVerified);
                        // print(isPasswordVerified);

                        // if (!isUserVerified || !isPasswordVerified) {
                        //   // set up the button
                        //   Widget okButton = ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //       primary: mainColor,
                        //       padding: EdgeInsets.all(10),
                        //     ),
                        //     child: Text("OK"),
                        //     onPressed: () {
                        //       Navigator.pop(context);
                        //     },
                        //   );
                        //   // set up the AlertDialog
                        //   AlertDialog alert = AlertDialog(
                        //     title: Text("Sorry"),
                        //     content: Text(
                        //         "The user email or password is not correct, please try again!"),
                        //     actions: [
                        //       okButton,
                        //     ],
                        //   );
                        //   // show the dialog
                        //   showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return alert;
                        //     },
                        //   );
                        // } else {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => MapScreen(),
                        //       ));
                        // }
                      },
                      child: Text("LOGIN"),
                      style: ElevatedButton.styleFrom(
                        primary: mainColor,
                        padding: EdgeInsets.all(15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
