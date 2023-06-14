import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventorymanagement/connect.dart';

import 'package:searchfield/searchfield.dart';
import 'package:textfield_search/textfield_search.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  TextEditingController _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  MongoDatabasee obj=new MongoDatabasee();

  static Future<List<dynamic>> getData() async {
    List<String>x=[];
    var m=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email.toString()).doc("items").collection("items").get();
    m.docs.forEach((element) {x.add(element.data()["name"]);});
    print(x);
    return x;
  }
  static Future<List<dynamic>> getData1() async {
    List<String>x=[];
    var m=await FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email.toString()).doc("customers").collection("customers").get();
    m.docs.forEach((element) {x.add(element.data()["name"]);});
    print(x);
    return x;
  }

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
              Future<List<dynamic>> _statesOfIndia=getData();
              Future<List<dynamic>> _statesOfIndia2=getData1();
              return AlertDialog(

                title: Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      Center(child: Text("New Sales Order")),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Customer name",style: TextStyle(fontSize: 15),),
                          ],
                        ),
                        SizedBox(height: 5,),
                        TextFieldSearch(


              textStyle: TextStyle(color: Colors.black),
              decoration: InputDecoration(

              enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
                borderRadius:   BorderRadius.circular(10)
              ),
              focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
                  borderRadius:   BorderRadius.circular(10),
              )
              ),

              minStringLength: 0,
              future: () {
              return _statesOfIndia2;
              },

              label: "Customer name",
              controller: email,
              ),
                      ],
                    ),
                  ),

                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Product name",style: TextStyle(fontSize: 15),),
                              ],
                            ),
                            SizedBox(height: 5,),
                            TextFieldSearch(


                              textStyle: TextStyle(color: Colors.black),
                              decoration: InputDecoration(

                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                      borderRadius:   BorderRadius.circular(10)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                      borderRadius:   BorderRadius.circular(10)
                                  )
                              ),

                              minStringLength: 0,
                              future: () {
                                return _statesOfIndia;
                              },

                              label: "Customer name",
                              controller: pass,
                            ),
                          ],
                        ),
                      ),

                      Padding(
                          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter password";
                              }
                              return null;
                            },
                            controller: conpass,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(

                                  color: Colors.black.withOpacity(0.8),
                                ),
                              ),
                              filled: true, //<-- SEE HERE
                              fillColor: Colors.white,
                              border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(10)),
                              hintText: 'Enter quantity',
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

                                final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =  await FirebaseFirestore.instance
                                    .collection(await FirebaseAuth.instance.currentUser!.email.toString())
                                    .doc("salesorder").get();
                                var b;
                                try{b=documentSnapshot.get("id");
                                  b+=1;
                               }
                                catch(e){
                                  b=0;
                                }
                                QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
                                      .collection(await FirebaseAuth.instance.currentUser!.email.toString())
                                      .doc("items")
                                      .collection("items")
                                      .where("name", isEqualTo: pass.text.toString())
                                      .get();

                                  List<DocumentSnapshot<Map<String, dynamic>>> documents = querySnapshot.docs;



                              await FirebaseFirestore.instance.collection(await FirebaseAuth.instance.currentUser!.email.toString()).doc("salesorder").collection("salesorder").doc(b.toString()).set({
                              "soid":b,
                                "level":0,
                                "cusname":email.text,
                              "product":pass.text.toString(),
                              "quantity":int.parse(conpass.text.toString()),
                              "price":documents[0]["price"]*int.parse(conpass.text.toString()),
                              });

                                await FirebaseFirestore.instance.collection(await FirebaseAuth.instance.currentUser!.email.toString()).doc("salesorder").set({
                                  "id":b,

                                });
                              await FirebaseFirestore.instance.collection(await FirebaseAuth.instance.currentUser!.email.toString()).doc("items").collection("items").doc(pass.text.toString()).update({"quantity":documents[0]["quantity"]-int.parse(conpass.text.toString())});
                              Navigator.pop(context, 'OK');
                              },

                              child: const Text('Add'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),


              );}
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255,26, 26, 29),
        title: Center(child: Text("Sales Orders")),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:FirebaseFirestore.instance.collection(FirebaseAuth.instance.currentUser!.email.toString()).doc("salesorder").collection("salesorder").orderBy("soid").snapshots(),


        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasError)
          {
            return Text("${snapshot.error}");
          }
          else
          {
            if(snapshot.hasData) {
              List<DocumentSnapshot>nn=snapshot.data.docs;
              List<String> mm=["Invoice","Pack","Shipped","Delivered"];
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
                          onChanged: (val){},
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
                                height: 203,
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
                                                Row(
                                                  children: [
                                                    Text("Soid: ${nn[ind]["soid"]}",style:GoogleFonts.poppins(color: Colors.grey, fontSize: 25,)),
                                                    SizedBox(width: 6,),(nn[ind]["level"]==4)?Icon(Icons.check_circle_rounded,color: Colors.greenAccent,):SizedBox()
                                                  ],
                                                ),
                                                SizedBox(height: 5,),
                                                Text("${nn[ind]["cusname"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 25,)),
                                                 SizedBox(height: 5,),
                                                Text("Product: ${nn[ind]["product"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,))
                                                ,SizedBox(height: 5,),
                                                Text("Quantity: ${nn[ind]["quantity"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,))
                                                ,SizedBox(height: 5,),
                                                Text("Price: ${nn[ind]["price"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,))
                                                ,SizedBox(height: 6,),
                                                Row(
                                                  children: [
                                                    Text("Invoiced",style:GoogleFonts.poppins(color: Colors.black, fontSize: 10,)),

                                                    (nn[ind]["level"]<1)?Icon(Icons.circle_outlined,color: Colors.black,size: 13,):Icon(Icons.circle,color: Colors.blue,size: 13,),SizedBox(width: 6,),
                                                    Text("Packed",style:GoogleFonts.poppins(color: Colors.black, fontSize: 10,)),

                                                    (nn[ind]["level"]<2)?Icon(Icons.circle_outlined,color: Colors.black,size: 13,):Icon(Icons.circle,color: Colors.blue,size: 13,), SizedBox(width: 6,),
                                                    Text("Shipped",style:GoogleFonts.poppins(color: Colors.black, fontSize: 10,)),

                                                    (nn[ind]["level"]<3)?Icon(Icons.circle_outlined,color: Colors.black,size: 13,):Icon(Icons.circle,color: Colors.blue,size: 13,),SizedBox(width: 6,),
                                                    Text("delivered",style:GoogleFonts.poppins(color: Colors.black, fontSize: 10,)),

                                                    (nn[ind]["level"]<4)?Icon(Icons.circle_outlined,color: Colors.black,size: 13,):Icon(Icons.circle,color: Colors.blue,size: 13,),SizedBox(width: 6,),
                                                  ],
                                                )
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
                                            (nn[ind]["level"]==0)?Container(
                                                decoration: BoxDecoration(
                                                    color: Color.fromARGB(255, 231,	245,	254),
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: TextButton(onPressed: (){},child: Row(
                                                  children: [
                                                    Text("Edit",style: TextStyle(color: Colors.black)),
                                                    SizedBox(width: 10,),
                                                    Icon(Icons.edit,color: Colors.black,),
                                                  ],
                                                ),)):SizedBox(),


                                            SizedBox(height: 5,),
                                            (nn[ind]["level"]<=3)?Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.red.shade50,
                                                  borderRadius: BorderRadius.circular(15)
                                              ),
                                              child: TextButton(onPressed: (){

                                                if(nn[ind]["level"]==0){
                                            showDialog<String>(

                                            context: context,

                                            builder: (BuildContext context) {

                                            return AlertDialog(

                                            title: Form(
                                            key: _formKey,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Text("Customer: ${nn[ind]["cusname"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 25,)),
                                              SizedBox(height: 6,),
                                              Text("Product: ${nn[ind]["product"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,))
                                              ,SizedBox(height: 6,),
                                              Text("Quantity: ${nn[ind]["quantity"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,))
                                              ,SizedBox(height: 6,),
                                              Text("Price: rs.${nn[ind]["price"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,))
                                              ,SizedBox(height: 6,),

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

                                                        final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =  await FirebaseFirestore.instance
                                                            .collection(await FirebaseAuth.instance.currentUser!.email.toString())
                                                            .doc("invoice").get();
                                                        var b;
                                                        try{b=documentSnapshot.get("id");
                                                        b+=1;
                                                        }
                                                        catch(e){
                                                          b=0;
                                                        }
                                                        await FirebaseFirestore.instance.collection(await FirebaseAuth.instance.currentUser!.email.toString()).doc("invoice").collection("invoice").doc(b.toString()).set({
                                                          "inid":b,
                                                          "ref_so":ind
                                                        });

                                                        await FirebaseFirestore.instance.collection(await FirebaseAuth.instance.currentUser!.email.toString()).doc("invoice").set({
                                                          "id":b,

                                                        });
                                                        await FirebaseFirestore.instance.collection(await FirebaseAuth.instance.currentUser!.email.toString()).doc("salesorder").collection("salesorder").doc("${nn[ind]["soid"]}").update({"level":1});
                                                        Navigator.pop(context, 'OK');
                                                      },

                                                      child: const Text('Invoice'),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ])));});
                                                }
                                                else if(nn[ind]["level"]==1){
                                                  showDialog<String>(

                                                      context: context,

                                                      builder: (BuildContext context) {

                                                        return AlertDialog(

                                                            title: Form(
                                                                key: _formKey,
                                                                child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [

                                                                      Text("Customer: ${nn[ind]["cusname"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 25,)),
                                                                      SizedBox(height: 6,),
                                                                      Text("Product: ${nn[ind]["product"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,))
                                                                      ,SizedBox(height: 6,),
                                                                      Text("Quantity: ${nn[ind]["quantity"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,))
                                                                      ,SizedBox(height: 6,),
                                                                      Text("Price: rs.${nn[ind]["price"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,))
                                                                      ,SizedBox(height: 6,),

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

                                                                                final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =  await FirebaseFirestore.instance
                                                                                    .collection(await FirebaseAuth.instance.currentUser!.email.toString())
                                                                                    .doc("package").get();
                                                                                var b;
                                                                                try{b=documentSnapshot.get("id");
                                                                                b+=1;
                                                                                }
                                                                                catch(e){
                                                                                  b=0;
                                                                                }
                                                                                await FirebaseFirestore.instance.collection(await FirebaseAuth.instance.currentUser!.email.toString()).doc("package").collection("package").doc(b.toString()).set({
                                                                                  "pkid":b,
                                                                                  "ref_so":ind
                                                                                });

                                                                                await FirebaseFirestore.instance.collection(await FirebaseAuth.instance.currentUser!.email.toString()).doc("package").set({
                                                                                  "id":b,

                                                                                });
                                                                                await FirebaseFirestore.instance.collection(await FirebaseAuth.instance.currentUser!.email.toString()).doc("salesorder").collection("salesorder").doc("${nn[ind]["soid"]}").update({"level":2});
                                                                                Navigator.pop(context, 'OK');
                                                                              },

                                                                              child: const Text('Invoice'),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ])));});
                                                }
                                                else if(nn[ind]["level"]==2){
                                                  showDialog<String>(

                                                      context: context,

                                                      builder: (BuildContext context) {

                                                        return AlertDialog(

                                                            title: Form(
                                                                key: _formKey,
                                                                child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [

                                                                      Text("Make sure that the package is shipped",style:GoogleFonts.poppins(color: Colors.black, fontSize: 25,)),


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



                                                                                await FirebaseFirestore.instance.collection(await FirebaseAuth.instance.currentUser!.email.toString()).doc("salesorder").collection("salesorder").doc("${nn[ind]["soid"]}").update({"level":3});
                                                                                Navigator.pop(context, 'OK');
                                                                              },

                                                                              child: const Text('Mark as shipped'),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ])));});
                                                }
                                                else if(nn[ind]["level"]==3){
                                                  showDialog<String>(

                                                      context: context,

                                                      builder: (BuildContext context) {

                                                        return AlertDialog(

                                                            title: Form(
                                                                key: _formKey,
                                                                child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [

                                                                      Text("Make sure that the package is shipped and delivered",style:GoogleFonts.poppins(color: Colors.black, fontSize: 25,)),


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



                                                                                await FirebaseFirestore.instance.collection(await FirebaseAuth.instance.currentUser!.email.toString()).doc("salesorder").collection("salesorder").doc("${nn[ind]["soid"]}").update({"level":4});
                                                                                Navigator.pop(context, 'OK');
                                                                              },

                                                                              child: const Text('Mark as delivered'),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ])));});
                                                }

                                              },child: (nn[ind]["level"]<2)?Text("${mm[nn[ind]["level"]]} >>",style: TextStyle(color: Colors.black,fontSize: 12),):(nn[ind]["level"]<=3)?Text("mark as\n${mm[nn[ind]["level"]]}",style: TextStyle(color: Colors.black,fontSize: 13),):SizedBox()),
                                            ):SizedBox(),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

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
