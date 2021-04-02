import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop/Screens/user/homescreen.dart';
import 'package:shop/Screens/loginscreen.dart';
import 'package:shop/constants.dart';
import 'package:shop/provider/modelhud.dart';
import 'package:shop/widgets/customtextfield.dart';
import 'package:shop/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class SingupScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = "Signup Screen";
  String _email, _password;
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: kMainColor,
        body: ModalProgressHUD(
          inAsyncCall:Provider.of<ModelHud>(context).isLoading,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color(0xFFD9C7AA),
                Color(0xFFD3BD9C),
                Color(0xFFCDB48E),
                kMainColor
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
            child: Form(
              key: _globalKey,
              child: ListView(
                children: [
                  Container(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        children: [
                          RotatedBox(
                              quarterTurns: -1,
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                    fontFamily: 'Avenir',
                                    fontSize: 46,
                                    fontWeight: FontWeight.bold),
                              )),
                          Column(
                            children: [
                              Text(
                                "WE CAN START  ",
                                style:
                                    TextStyle(fontFamily: 'Avenir', fontSize: 26),
                              ),
                              Text(
                                "SOMETHING",
                                style:
                                    TextStyle(fontFamily: 'Avenir', fontSize: 26),
                              ),
                              Text(
                                "NEW",
                                style:
                                    TextStyle(fontFamily: 'Avenir', fontSize: 26),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.1),
                  CustomTextField(hint: "Name", icon: Icons.person_outline),
                  SizedBox(height: height * 0.01),
                  CustomTextField(
                      onClick: (value) {
                        _email = value;
                      },
                      hint: "Email",
                      icon: Icons.email_outlined),
                  SizedBox(height: height * 0.01),
                  CustomTextField(
                      onClick: (value) {
                        _password = value;
                      },
                      hint: "PassWord",
                      icon: Icons.vpn_key_outlined),
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LimitedBox(
                        maxWidth: width * 0.3,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black),
                          ),
                          child: Builder(
                            builder: (context) => TextButton(
                              onPressed: () async {
                            final modelhud = Provider.of<ModelHud>(context,listen: false);
                            modelhud.changeisLoading(true);
                                if (_globalKey.currentState.validate()) {
                                  _globalKey.currentState.save();

                                  try {
                                    final authResult =
                                        await _auth.signup(_email, _password);
                                    modelhud.changeisLoading(false);
                                    Navigator.pushReplacementNamed(context,Home.id);
                                  } catch (e) {
                                    modelhud.changeisLoading(false);
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(e.message),
                                    ));
                                  }
                                }
                                modelhud.changeisLoading(false);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Ok",
                                    style: TextStyle(
                                        fontFamily: "Avenir",
                                        fontSize: 18,
                                        color: Colors.black),
                                  ),
                                  Icon(Icons.arrow_forward_outlined,
                                      size: 30, color: Colors.black),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already Have an Account ? ",
                        style: TextStyle(fontSize: 16),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                          child: Text("Login"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
  }
}
