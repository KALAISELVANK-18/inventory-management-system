import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class EditCustomer extends StatefulWidget {
  final String name;
  final String street;
  final String city;
  final String post;
  final String phone;
  final String dropdownValue;
   EditCustomer({
     required this.name,
     required this.street,
     required this.city,
     required this.post,
     required this.phone,
     required this.dropdownValue,
   });

  @override
  State<EditCustomer> createState() => _EditCustomerState(name: name,street: street,city: city,post: post,phone: phone);
}

class _EditCustomerState extends State<EditCustomer> {
  TextEditingController email=new TextEditingController();
  TextEditingController pass=new TextEditingController();
  TextEditingController conpass=new TextEditingController();
  TextEditingController city1=new TextEditingController();
  TextEditingController post1=new TextEditingController();
  _EditCustomerState({required String name,required String street,required String city,required String post,required String phone}) {
    email.text = name;
    pass.text = street;
    city1.text=city;
    post1.text=post;
    conpass.text = phone;
    // the value of email text controller
  }
  int i=0,k=0,j=0,l=0,m=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Customers"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(child: Text("Edit Customer",style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold),)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Row(
                children: [
                  Text("Customer name",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Customer name";
                    }
                    else {
                      i=1;
                      return null;
                    }
                  },
                  controller: email,
                  decoration: InputDecoration(
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Enter Customer name'),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Row(
                children: [
                  Text("Street/Door no",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter street/door no";
                    }
                    else {
                      j=1;
                      return null;
                    }
                  },
                  controller: pass,
                  decoration: InputDecoration(
                    filled: true, //<-- SEE HERE
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Enter Street/Door No',
                  ),

                )),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Row(
                children: [
                  Text("City",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter city";
                    }
                    else {
                      k=1;
                      return null;
                    }
                  },
                  controller: city1,
                  decoration: InputDecoration(
                    filled: true, //<-- SEE HERE
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Enter City',
                  ),

                )),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Row(
                children: [
                  Text("Postal code",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter password";
                    }
                    else if(value.toString().length!=6){
                      return "please enter valid post code";
                    }

                    else {
                      l=1;
                      return null;
                    }
                  },
                  controller: post1,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true, //<-- SEE HERE
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Enter Postal Code',
                  ),

                )),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Row(
                children: [
                  Text("Phone no",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.always,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter phone no";

                  }
                  else if(value.toString().length!=10){
                    return "please enter valid phoneno";
                  }

                  else {
                    m=1;
                    return null;
                  }

                },
                keyboardType: TextInputType.number,
                controller: conpass,
                decoration: InputDecoration(
                    filled: true, //<-- SEE HERE
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Enter Phoneno'),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20,right: 5,left: 35),
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
                      if(i==1 && j==1 && k==1 && m==1 && l==1) {
                        await FirebaseFirestore.instance.collection("Customers")
                            .doc("customers").collection("customers").doc(widget
                            .name + widget.phone)
                            .delete();
                        await FirebaseFirestore.instance.collection("Customers")
                            .doc("customers").collection("customers").doc(email
                            .text + conpass.text.toString())
                            .set({
                          "cusid": email.text + conpass.text.toString(),
                          "name": email.text,
                          "street": pass.text.toString(),
                          "city": city1.text.toString(),
                          "post": post1.text.toString(),
                          "phone": conpass.text.toString()
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Customer Edited Successfully",style: GoogleFonts.poppins(color: Colors.white),),
                          ),
                        );
                        Navigator.pop(context, 'OK');
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please Enter all the Fields",style: GoogleFonts.poppins(color: Colors.red),),
                          ),
                        );
                      }
                    },

                    child: const Text('Edit'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),

    );
  }
}
