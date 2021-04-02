import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  final String  initial;
  // ignore: missing_return
  String _errorMsg(String str){
    switch(hint)
    {
      case "Name" : return "Name is Empty";
      case "Email" : return "Email Is Empty";
      case "PassWord" : return "PassWord Is Empty";

    }
  
  }
  CustomTextField({this.hint, @required this.icon, this.onClick,this.initial});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20 ),
      child: TextFormField( 
        // ignore: missing_return
        validator: (value){
          if(value.isEmpty){
            return _errorMsg(hint);
          }
        },
        onSaved: onClick,
        initialValue: initial,
        obscureText: hint =="PassWord" ? true : false,
        cursorColor: Colors.black,
        decoration:InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon,color:Colors.black),
          enabledBorder:OutlineInputBorder(
             borderRadius:BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
             borderRadius:BorderRadius.circular(20),
          ),
          errorBorder:OutlineInputBorder(
             borderSide: BorderSide(color: Colors.red[300]),
             borderRadius:BorderRadius.circular(20),
          ), 
        ),
      ),
    );
  }
}
