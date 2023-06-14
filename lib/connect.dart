import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:searchfield/searchfield.dart';

class MongoDatabasee{
  zz(String email,String pass)async{
    /* final appp = App(AppConfiguration('application-0-wxtih' ,localAppName: "odkec",localAppVersion: '1.0.0+1'));
    final users= await appp.logIn(Credentials.emailPassword(email, pass));*/

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      print("success");
      // if success
      return "success";

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "User not found";
      } else if (e.code == 'wrong-password') {
        return "Wrong password";
      }
    }

    return "gfd";
  }
  zzz(String email,String pass)async{
    /* final appp = App(AppConfiguration('application-0-wxtih' ,localAppName: "odkec",localAppVersion: '1.0.0+1'));
    final users= await appp.logIn(Credentials.emailPassword(email, pass));*/

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      print("success");
      // if success
      return "success";

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "User not found";
      } else if (e.code == 'wrong-password') {
        return "Wrong password";
      }
    }

    return "gfd";
  }

  queryim()async{
    List<String>x=[];
    var m=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email.toString()).doc("items").collection("items").get();
    m.docs.forEach((element) {x.add(element.data()["name"]);});

    return x.map((e) => SearchFieldListItem(e,child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(e),))).toList();

  }
}


