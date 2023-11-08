import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class EditItems extends StatefulWidget {
  final String name;
  final double price;
  final String type;
  final String gsttype;
  final int quantity;
  final int hsbn;
  final String dropdownValue;

  EditItems({
    required this.name,
    required this.price,
    required this.type,
    required this.gsttype,
    required this.quantity,
    required this.hsbn,
    required this.dropdownValue,
  });

  @override
  State<EditItems> createState() => _EditItemsState(name: name,price: price,quantity: quantity,hsbn: hsbn,type: type,gsttype: gsttype);
}

class _EditItemsState extends State<EditItems> {
  TextEditingController email= new TextEditingController();
  TextEditingController pass=new TextEditingController();
  TextEditingController conpass=new TextEditingController();
  TextEditingController hsbn1=new TextEditingController();
  String dropdownvalue2 = "";
  String dropdownvalue4="";
  _EditItemsState({required String name,required double price,required int quantity,required int hsbn,required String type,required String gsttype}) {
    email.text = name;
    pass.text = price.toString();
    conpass.text = quantity.toString();
    hsbn1.text= hsbn.toString();// Set
    dropdownvalue2= type;
    dropdownvalue4= gsttype;
    // the value of email text controller
  }
  int i=0,j=0,k=0,l=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Items"),
        backgroundColor: Colors.black,
      ),
      body:SingleChildScrollView(
        child: Container(

          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(child: Text("Edit Item",style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold),)),
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
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Item name";
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
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter price";
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
                  value: dropdownvalue2,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue2 = newValue!;
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
                  value: dropdownvalue4,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue4 = newValue!;
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
                    Text("Qunatity",style: GoogleFonts.poppins(fontSize: 15,fontWeight: FontWeight.w500),),
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.always,

                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter initial quantity";
                    }
                    else {
                      k=1;
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
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter HSN no";
                    }
                    else {
                      l=1;
                      return null;
                    }
                  },
                  controller: hsbn1,
                  decoration: InputDecoration(
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Enter HSBN No'),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left:40,top: 20,right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                              "items").doc(widget.name).delete();
                          await FirebaseFirestore.instance.collection(
                              widget.dropdownValue).doc("items").collection(
                              "items").doc(email.text).set({
                            "name": email.text,
                            "price": double.parse(pass.text.toString()),
                            "quantity": int.parse(conpass.text.toString()),
                            "type": dropdownvalue2.toString(),
                            "gsttype": dropdownvalue4.toString(),
                            "hsbn": int.parse(hsbn1.text.toString()),
                            "timestamp": Timestamp.now()
                          });
                          await FirebaseFirestore.instance.collection(
                              "Universal").doc(widget.name).delete();
                          await FirebaseFirestore.instance.collection(
                              "Universal").doc(email.text).set({
                            "firstname": widget.dropdownValue,
                            "name": email.text,
                            "price": double.parse(pass.text.toString()),
                            "quantity": int.parse(conpass.text.toString()),
                            "iquantity": int.parse(conpass.text.toString()),
                            "type": dropdownvalue2.toString(),
                            "gsttype": dropdownvalue4.toString(),
                            "hsbn": int.parse(hsbn1.text.toString()),
                            "timestamp": Timestamp.now()
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Items Edited Successfully",style: GoogleFonts.poppins(color: Colors.white),),
                            ),
                          );
                          print(widget.dropdownValue);

                          Navigator.pop(context, 'OK');
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please Enter all the Fields!",style: GoogleFonts.poppins(color: Colors.red),),
                            ),
                          );
                        }
                      },
                      child: const Text('Edit',style: TextStyle(fontSize: 15),),
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
}
