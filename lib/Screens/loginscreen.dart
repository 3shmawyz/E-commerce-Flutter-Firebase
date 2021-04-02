import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shop/Screens/admin/adminhome.dart';
import 'package:shop/Screens/signupscreen.dart';
import 'package:shop/Screens/user/homescreen.dart';
import 'package:shop/constants.dart';
import 'package:shop/provider/modelhud.dart';
import 'package:shop/widgets/customtextfield.dart';
import 'package:shop/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> globalkey = GlobalKey<FormState>();

  final _auth = Auth();

  String _email, _password;

  final List adminPass = ["123123123"];

  final List adminMail = [
    "admin@gmail.com",
    "admin2@gmail.com",
    "admin3@gmail.com"
  ];

  bool keepMeLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ModalProgressHUD(
      inAsyncCall: Provider.of<ModelHud>(context).isLoading,
      child: Scaffold(
        backgroundColor: kMainColor,
        body: Container(
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
            key:globalkey,
            child: ListView(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        RotatedBox(
                            quarterTurns: -1,
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                  fontFamily: 'Avenir',
                                  fontSize: 46,
                                  fontWeight: FontWeight.bold),
                            )),
                        Column(
                          children: [
                            Text(
                              "YOUR",
                              style:
                                  TextStyle(fontFamily: 'Avenir', fontSize: 30),
                            ),
                            Text(
                              "WAY TO",
                              style:
                                  TextStyle(fontFamily: 'Avenir', fontSize: 30),
                            ),
                            Text(
                              "FASHION",
                              style:
                                  TextStyle(fontFamily: 'Avenir', fontSize: 30),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: height * 0.1),
                CustomTextField(
                    onClick: (value) {
                      _email = value;
                    },
                    hint: "Email",
                    icon: Icons.email_outlined),
             SizedBox(height:height * 0.02),
                CustomTextField(
                    onClick: (value) {
                      _password = value;
                    },
                    hint: "PassWord",
                    icon: Icons.vpn_key_outlined),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: Checkbox(
                    checkColor: Colors.black,
                      value: keepMeLoggedIn,
                      onChanged: (value) {
                         setState(() {
                        keepMeLoggedIn = value;                               
                                                });
                      }),
                ),
                 Text("Remeber Me")   
              ],
            ),
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
                            onPressed: () {
                              if(keepMeLoggedIn = true)
                              {
                                keepUserLoggedIn();
                              }
                              _validate(context);
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
                      "Don't Have an Account ? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SingupScreen.id);
                        },
                        child: Text("Sing up"))
                  ],
                ),
                /*   Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //  Text("I'am an admin",style: TextStyle(color:isAdmin ? kMainColor.withOpacity(0.1): Colors.black),),
                      //  Text("I'am an user",style: TextStyle(color:isAdmin ? Colors.white:kMainColor ),)
                      Provider.of<AdminMode>(context).isAdmin ? GestureDetector(
                        onTap: (){
                          Provider.of<AdminMode>(context,listen: false).changeIsAdmin(true);
                        }, 
                        child: Text("I'am an user"),) : 
                      GestureDetector(
                        onTap: (){
                          Provider.of<AdminMode>(context,listen: false).changeIsAdmin(false);
                        },
                        child: Text("I'am an admin"),)
                    ],
                  ),
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final modelhud = Provider.of<ModelHud>(context, listen: false);
    modelhud.changeisLoading(true);
    if (globalkey.currentState.validate()) {
      globalkey.currentState.save();
      if (adminMail.contains(_email.trim()) &&
          adminPass.contains(_password.trim())) {
        try {
          await _auth.signin(_email.trim(), _password);
          Navigator.pushReplacementNamed(context, AdminHome.id);
        } catch (e) {
          modelhud.changeisLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
        }
      } else {
        try {
          await _auth.signin(_email.trim(), _password);
          Navigator.pushReplacementNamed(context, Home.id);
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message)));
        }
      }
    }
    modelhud.changeisLoading(false);
  }

  void keepUserLoggedIn() async{
    SharedPreferences preference = await SharedPreferences.getInstance();
    preference.setBool("keepMeLoggedIn",keepMeLoggedIn);
  }
}
