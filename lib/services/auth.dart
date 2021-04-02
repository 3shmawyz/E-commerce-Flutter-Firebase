import 'package:firebase_auth/firebase_auth.dart';

class Auth {
final _auth = FirebaseAuth.instance;

 signup(String email,String password) async{

  final authResult = await _auth.createUserWithEmailAndPassword(email:email ,password:password);
  return authResult;
 } 

 signin(String email,String password) async{

  final authResult = await _auth.signInWithEmailAndPassword(email:email ,password:password);
  return authResult;

 } 
 Future <void>signOut()async{
  await _auth.signOut();
 }

}