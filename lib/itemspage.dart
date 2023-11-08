import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
class ItemsPage extends StatefulWidget {
  final String dropdownValue;

  const ItemsPage({required this.dropdownValue});

  @override
  State<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {

  sendmeassage(String token,String boy,String title)async{


    try{
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String,String>{
          'Content-Type':'application/json',
          'Authorization':'key=AAAAhmr0PVk:APA91bEde76jMDfSZDio6CW47zJ39-a9ImTMNIA-osnuhaUsjoCoifdn6YbPmJZmhzywD10yjiLNP5FwVWyKQuqxzLrqrAHOjwR5sKHincYvoJLraorqCV7NcRk6qrB8-p6j7CDnzalB'
        },
        body: jsonEncode(
          <String,dynamic>{
            'priority':'high',
            'data':<String,dynamic>{
              'click_action':'FLUTTER_NOTIFICATION_CLICK',
              'status':'done',
              'body':boy,
              'title':title,

            },
            "notification":<String,dynamic>{
              "title":title,
              "body":boy,
              "android_channel_id":"dbnoti"
            },
            "to":token,
          },
        ),
      );
    }

    catch(e){
      if(kDebugMode){
        print("error push notification");

      }
    }
  }
  TextEditingController email=new TextEditingController();
  TextEditingController pass=new TextEditingController();
  TextEditingController conpass=new TextEditingController();
  TextEditingController hsbn=new TextEditingController();
  String dropdownValue1 = "Kilogram";
  String dropdownValue2 ="5%";
  int i=0,j=0,k=0,l=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Items"),
        backgroundColor: Colors.black,
      ),
      body:SingleChildScrollView(
        child: Container(

          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(child: Text("Add Item",style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold),)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  children: [
                    Text("Product name",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {

                        return "Please Enter Item name";
                      }
                      else {
                        i = 1;
                        return null;
                      }

                    },
                    controller: email,
                    decoration: InputDecoration(
                        filled: true, //<-- SEE HERE
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'Enter Item name'),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  children: [
                    Text("Price",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter price";
                      }
                      else {
                        j = 1;
                        return null;
                      }

                    },
                    controller: pass,
                    decoration: InputDecoration(
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Enter Sales Price',
                    ),

                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  children: [
                    Text("Product type",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,top: 10,right: 20),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder( //<-- SEE HERE
                        borderSide: BorderSide(color: Colors.black54, width: 2),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    focusedBorder: OutlineInputBorder( //<-- SEE HERE
                        borderSide: BorderSide(color: Colors.black54, width: 2),
                        borderRadius: BorderRadius.circular(15)
                    ),

                    fillColor: Colors.greenAccent,
                  ),

                  // dropdownColor: Colors.grey,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400,color: Colors.black),
                  value: dropdownValue1,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue1 = newValue!;
                    });
                  },
                  items: <String>['Kilogram', 'Nos', 'Set', 'Plate'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  children: [
                    Text("GST type",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,top: 10,right: 20),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder( //<-- SEE HERE
                        borderSide: BorderSide(color: Colors.black54, width: 2),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    focusedBorder: OutlineInputBorder( //<-- SEE HERE
                        borderSide: BorderSide(color: Colors.black54, width: 2),
                        borderRadius: BorderRadius.circular(15)
                    ),

                    fillColor: Colors.greenAccent,
                  ),

                  // dropdownColor: Colors.grey,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w400,color: Colors.black),
                  value: dropdownValue2,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue2 = newValue!;
                    });
                  },
                  items: <String>['5%', '12%', '18%', '28%'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  children: [
                    Text("Quantity",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,

                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter initial quantity";
                    }
                    else {
                      k = 1;
                      return null;
                    }
                  },


                  controller: conpass,
                  decoration: InputDecoration(
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Enter Initial Quantity'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  children: [
                    Text("HSN no",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Hsn no";
                    }
                    else {
                      l = 1;
                      return null;
                    }
                  },
                  controller: hsbn,
                  decoration: InputDecoration(
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Enter HSBN No'),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 40,top: 20,right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    ElevatedButton(
                      style: ButtonStyle(

                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                        padding: MaterialStateProperty.all(EdgeInsets.only(
                            top: 15, bottom: 15, right: 130, left: 130)),
                        backgroundColor: MaterialStateProperty.all(Colors.black),
                      ),

                      onPressed:()async{
                        if(i==1 && j==1 && k==1 && l==1) {
                          await FirebaseFirestore.instance.collection(
                              widget.dropdownValue).doc("items").collection(
                              "items").doc(email.text).set({
                            "name": email.text,
                            "price": double.parse(pass.text.toString()),
                            "quantity": int.parse(conpass.text.toString()),
                            "iquantity": int.parse(conpass.text.toString()),
                            "type": dropdownValue1.toString(),
                            "gsttype": dropdownValue2.toString(),
                            "hsbn": int.parse(hsbn.text.toString()),
                            "timestamp": Timestamp.now()
                          }).then((value) => bo(email.text));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Items Added",style: GoogleFonts.poppins(color: Colors.white),),
                            ),
                          );

                          print(widget.dropdownValue);

                          Navigator.pop(context, 'OK');
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                               Text("Please enter all fields",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                      color: Colors.red),),

                            ),
                          );
                        }
                      },
                      child: const Text('Add',style: TextStyle(fontSize: 15,),),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  Future <void> bo(String text)async {
    String user =await FirebaseAuth.instance.currentUser!.email.toString();
    print(text);
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('Usertokens')
        .get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data();
      if (data.containsKey('tokens') ) {
        String token = data['tokens'];
        print(token);
        sendmeassage(token, text, widget.dropdownValue+"posted new stocks");

      }
    });
  }
  Future <void> boo(String name,String price,String quan,String hsbn,String dropdownValue3,String gst )async{
    DocumentSnapshot data=await FirebaseFirestore.instance.collection(await FirebaseAuth.instance.currentUser!.email.toString()).doc("personinfo").get();
    await FirebaseFirestore.instance.collection("Universal").doc(name).set({
      "firstname":widget.dropdownValue,
      "name":name,
      "price":double.parse(price),
      "quantity":int.parse(quan),
      "iquantity":int.parse(quan),
      "type":dropdownValue3,
      "gsttype":gst,
      "hsbn":int.parse(hsbn.toString()),
      "timestamp": Timestamp.now()
    });
  }
}
