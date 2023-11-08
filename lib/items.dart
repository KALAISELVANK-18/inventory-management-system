

import 'dart:convert';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import 'package:inventorymanagement/edititems.dart';
import 'package:inventorymanagement/itemspage.dart';

class Items extends StatefulWidget {
  final String dropdownValue;

  const Items({required this.dropdownValue});

  @override
  State<Items> createState() => _ItemsState();
}
enum BestTutorSite { javatpoint, w3schools, tutorialandexample }

class _ItemsState extends State<Items> {
  String dropdownValue1 = 'Kilogram';
  BestTutorSite _site = BestTutorSite.javatpoint;
  int _selectedRadio = 0;
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



  // String shiftCharacter(String character) {
  //   int charCode = character.codeUnitAt(0);
  //   int shiftedCharCode = charCode + 1;
  //   String shiftedCharacter = String.fromCharCode(shiftedCharCode);
  //   return shiftedCharacter;
  // }
  List<int> cont=[];
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ItemsPage(dropdownValue: widget.dropdownValue)));
          },
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255,26, 26, 29),
        title: Center(child: Text("Items")),
      ),
      body:StreamBuilder<QuerySnapshot>(
        stream:(_searchController.text=="")?FirebaseFirestore.instance.collection(widget.dropdownValue).doc("items").collection("items").snapshots():FirebaseFirestore.instance.collection(widget.dropdownValue).doc("items").collection("items").orderBy("name").snapshots()
        //where("name",isLessThanOrEqualTo: _searchController.text.toString().substring(0,_searchController.text.toString().length-1)+shiftCharacter(_searchController.text.toString()[_searchController.text.toString().length-1]),isGreaterThanOrEqualTo: _searchController.text.toString()).snapshots(),



        ,builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasError)
          {
            return Text("${snapshot.error}");
          }
          else
          {
            if(snapshot.hasData) {
              List<DocumentSnapshot>nn=snapshot.data.docs;


              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: TextField(

                          controller: _searchController,
                          onChanged: (val){
                            List<int> cont1=[];
                            for(int i=0;i<nn.length;i++){
                              for (int j=0;j<nn[i]["name"].toString().length-_searchController.text.toString().length+1;j++){

                                if(nn[i]["name"].toString().substring(j,_searchController.text.length+j)==_searchController.text){
                                  cont1.add(i);
                                  break;

                                }
                              }}
                            setState(() {


                              cont=cont1;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Search Item',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),

                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: nn.length,
                      itemBuilder: (BuildContext context,ind){
                        return (cont.contains(ind) || _searchController.text.toString()=="")?Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: Column(
                            children: [
                              GestureDetector(

                                child: Container(

                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 5.0,
                                        blurRadius: 5.0,
                                        offset: Offset(0, 3), // changes the shadow position
                                      ),
                                    ],
                                  ),
                                  width: MediaQuery.of(context).size.width*0.9,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [

                                                Padding(
                                                  padding: const EdgeInsets.only(left:15.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                          width:200,
                                                          child: Text("${nn[ind]["name"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 13,fontWeight: FontWeight.bold))),
                                                      SizedBox(height: 5,),

                                                      Row(
                                                        children: [
                                                          Icon(Icons.currency_rupee_rounded,size: 15,),SizedBox(width: 5,),
                                                          Text("${nn[ind]["price"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,)),
                                                        ],
                                                      )
                                                      ,   SizedBox(height: 5,),
                                                      Text("Item type: ${nn[ind]["type"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,)),
                                                      SizedBox(height: 5,),
                                                      Text("Gst type: ${nn[ind]["gsttype"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,)),
                                                      SizedBox(height: 5,),
                                                      Text("Stock Available: ${nn[ind]["quantity"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,)),
                                                  SizedBox(height: 5,),
                                                Text("HSN No: ${nn[ind]["hsbn"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,)),
                                                      // SizedBox(height: 5,),
                                                      // Text("Type: ${nn[ind]["type"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,))

                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 10.0,left: 10),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          color: Color.fromARGB(255, 231,	245,	254),
                                                          borderRadius: BorderRadius.circular(15)
                                                      ),
                                                      child: TextButton(onPressed: (){
                                                        Navigator.of(context).push(
                                                          MaterialPageRoute(builder: (context) => EditItems(
                                                            name: nn[ind]["name"],
                                                            price: nn[ind]["price"],
                                                            type: nn[ind]["type"],
                                                            gsttype:nn[ind]["gsttype"],
                                                            quantity: nn[ind]["quantity"],
                                                            hsbn: nn[ind]["hsbn"],
                                                            dropdownValue: widget.dropdownValue,
                                                          )),
                                                        );
                                                      },child: Row(
                                                        children: [
                                                          Text("Edit",style: TextStyle(color: Colors.black)),
                                                          SizedBox(width: 10,),
                                                          Icon(Icons.edit,color: Colors.black,),
                                                        ],
                                                      ),)),


                                                  SizedBox(height: 5,),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Color.fromARGB(255, 231,	245,	254),
                                                        borderRadius: BorderRadius.circular(15)
                                                    ),
                                                    child: TextButton(onPressed: (){

                                                      showDialog<String>(

                                                          context: context,

                                                          builder: (BuildContext context) {

                                                            TextEditingController email=new TextEditingController();


                                                            return AlertDialog(

                                                              title: Column(
                                                                children: [

                                                                  Center(child: Text("Add Stock")),

                                                                  Padding(
                                                                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                                                                      child: TextFormField(
                                                                        validator: (value) {
                                                                          if (value!.isEmpty) {
                                                                            return "Add stock";
                                                                          }
                                                                          return null;
                                                                        },
                                                                        controller: email,

                                                                        decoration: InputDecoration(
                                                                            filled: true, //<-- SEE HERE
                                                                            fillColor: Colors.white,
                                                                            border: OutlineInputBorder(
                                                                                borderRadius: BorderRadius.circular(10)),
                                                                            hintText: 'Add Stock'),
                                                                        keyboardType: TextInputType.number,
                                                                      )),



                                                                  SizedBox(height: 10,),
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(20.0),
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: <Widget>[
                                                                        ElevatedButton(
                                                                          style: TextButton.styleFrom(
                                                                              backgroundColor: Colors.black),
                                                                          onPressed: () => Navigator.pop(context, 'Cancel'),
                                                                          child: const Text('Cancel',),
                                                                        ),
                                                                        ElevatedButton(
                                                                          style: TextButton.styleFrom(
                                                                              backgroundColor: Colors.black),
                                                                          onPressed:()async{

                                                                            var quan= await FirebaseFirestore.instance.collection(widget.dropdownValue).doc("items").collection("items").doc(nn[ind].id).get();
                                                                            var val=quan.get("quantity");
                                                                                    await FirebaseFirestore.instance.collection(widget.dropdownValue).doc("items").collection("items").doc(nn[ind].id).update({

                                                                              "quantity":int.parse(email.text.toString())+val,
                                                                            });
                                                                                    await FirebaseFirestore.instance.collection("Universal").doc(nn[ind].id).update({
                                                                                      "quantity":int.parse(email.text.toString())+val,
                                                                                    });

                                                                            //bo(nn[ind]["name"]);
                                                                            Navigator.pop(context, 'OK');
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(
                                                                                content: Text("Stock Added Successfully",style: GoogleFonts.poppins(color: Colors.white),),
                                                                              ),
                                                                            );
                                                                          },
                                                                          child: const Text('Confirm'),
                                                                        ),
                                                                       ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),


                                                            );}
                                                      );

                                                    },child: Text("Add stock",style: TextStyle(color: Colors.black),)),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onLongPress: ()async{
                                  bi(nn[ind]["name"],nn[ind]["price"],nn[ind]["quantity"],nn[ind]["hsbn"],nn[ind]["type"],nn[ind]["gsttype"]);
                                },
                              )
                            ],
                          ),
                        ):SizedBox();
                      },
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),



    );
  }
  Future <void> bo(String text)async {

    print(text);
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('Usertokens')
        .get();

    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data();
      if (data.containsKey('tokens') ) {
        String token = data['tokens'];
        print(token);
        sendmeassage(token, text, widget.dropdownValue+" posted new stocks");

      }
    });
  }
  Future <void> bi(String name,double price,int quantity,int hsbn,String type,String gsttype)async {
    return showModalBottomSheet<void>(

      context: context,
      builder: (BuildContext context) => SafeArea(
        child: SizedBox(
          height: 80,
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () async{
                  await FirebaseFirestore.instance.collection(widget.dropdownValue).doc("items").collection("items").doc(name).delete();
                  Navigator.of(context).pop();
                },
                child: const Align(
                  alignment: AlignmentDirectional.center,
                  child: Text('Delete',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.redAccent),),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
