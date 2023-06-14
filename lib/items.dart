

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Items extends StatefulWidget {
  const Items({Key? key}) : super(key: key);

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {

  String shiftCharacter(String character) {
    int charCode = character.codeUnitAt(0);
    int shiftedCharCode = charCode + 1;
    String shiftedCharacter = String.fromCharCode(shiftedCharCode);
    return shiftedCharacter;
  }
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
          onPressed: () => showDialog<String>(

            context: context,

            builder: (BuildContext context) {
              TextEditingController email=new TextEditingController();
              TextEditingController pass=new TextEditingController();
              TextEditingController conpass=new TextEditingController();

              return AlertDialog(

              title: Column(
                children: [

                  Center(child: Text("Add Item")),
                  Padding(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Item name";
                          }
                          return null;
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
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter password";
                          }
                          return null;
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
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.number,

                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter valid input";

                          }

                          if(pass.text!=conpass.text){
                            return "please check the password";
                          }
                          if(pass.text.toString().length<6){
                            return "please enter long password";
                          }

                          return null;

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
                              await FirebaseFirestore.instance.collection(await FirebaseAuth.instance.currentUser!.email.toString()).doc("items").collection("items").doc(email.text).set({
                                "name":email.text,
                                "price":double.parse(pass.text.toString()),
                                "quantity":int.parse(conpass.text.toString())
                              });
                              Navigator.pop(context, 'OK');
                            },
                            child: const Text('Add'),
                          ),
                        ],
                    ),
                  )
                ],
              ),


            );}
          ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255,26, 26, 29),
        title: Center(child: Text("Items")),
      ),
      body:StreamBuilder<QuerySnapshot>(
        stream:(_searchController.text=="")?FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email.toString()).doc("items").collection("items").snapshots():FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email.toString()).doc("items").collection("items").where("name",isLessThanOrEqualTo: _searchController.text.toString().substring(0,_searchController.text.toString().length-1)+shiftCharacter(_searchController.text.toString()[_searchController.text.toString().length-1]),isGreaterThanOrEqualTo: _searchController.text.toString()).snapshots(),



        builder: (context, AsyncSnapshot snapshot) {
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
                            setState(() {

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
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: Column(
                            children: [
                              Container(
                                height: 103,
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
                                                Text("${nn[ind]["name"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 25,)),
                                                SizedBox(height: 5,),
                                                Text("Sales Price: rs.${nn[ind]["price"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,))
                                                ,SizedBox(height: 5,),
                                                Text("Stock Available: ${nn[ind]["quantity"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,))

                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                decoration: BoxDecoration(
                                                    color: Color.fromARGB(255, 231,	245,	254),
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: TextButton(onPressed: (){

                                                   showDialog<String>(

                                                      context: context,

                                                      builder: (BuildContext context) {

                                                        TextEditingController email=new TextEditingController(text: nn[ind]["name"].toString());
                                                        TextEditingController pass=new TextEditingController(text: nn[ind]["price"].toString());
                                                        TextEditingController conpass=new TextEditingController(text: nn[ind]["quantity"].toString());

                                                        return AlertDialog(

                                                          title: Column(
                                                            children: [

                                                              Center(child: Text("Edit Item")),
                                                              Padding(
                                                                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                                                                  child: TextFormField(
                                                                    validator: (value) {
                                                                      if (value!.isEmpty) {
                                                                        return "Enter Item name";
                                                                      }
                                                                      return null;
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
                                                                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                                                                  child: TextFormField(
                                                                    keyboardType: TextInputType.number,
                                                                    validator: (value) {
                                                                      if (value!.isEmpty) {
                                                                        return "Please enter password";
                                                                      }
                                                                      return null;
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
                                                                        await FirebaseFirestore.instance.collection(await FirebaseAuth.instance.currentUser!.email.toString()).doc("items").collection("items").doc(nn[ind]["name"]).delete();

                                                                        await FirebaseFirestore.instance.collection(await FirebaseAuth.instance.currentUser!.email.toString()).doc("items").collection("items").doc(email.text).set({
                                                                          "name":email.text,
                                                                          "price":double.parse(pass.text.toString()),
                                                                          "quantity":int.parse(conpass.text.toString()),
                                                                        });
                                                                        Navigator.pop(context, 'OK');
                                                                      },
                                                                      child: const Text('Edit'),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),


                                                        );}
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
                                              child: TextButton(onPressed: (){},child: Text("Add stock",style: TextStyle(color: Colors.black),)),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
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
}
