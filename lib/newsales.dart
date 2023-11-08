import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';

List<String> list = <String>["6%","12%","18%","28%"];
List<String> li=<String>["Cash","Online","Credit"];


class New extends StatefulWidget {
  New({super.key,required this.dv});
  String dv;
  @override
  State<New> createState() => _NewState();
}

class _NewState extends State<New> {

  TextEditingController _searchController = TextEditingController();

  TextEditingController conpass=new TextEditingController();
  TextEditingController newemail=new TextEditingController();
  TextEditingController city=new TextEditingController();
  TextEditingController post=new TextEditingController();
  TextEditingController newpass=new TextEditingController();
  TextEditingController paytype=new TextEditingController(text: "Cash");
  List<List<dynamic>> orders=[];
  bool ind=true;
  int count =0;
  String custid="";

  final _formKey = GlobalKey<FormState>();
  int n=0,q=0,w=0,e=0,r=0,t=0,y=0,u=0,o=0,p=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding:  EdgeInsets.only(bottom:count<=1?0:115,right: 10),
        child: FloatingActionButton(backgroundColor: Colors.redAccent,child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.add,),
        ),onPressed: (){

          setState(() {
            orders.add([TextEditingController(text: ""),TextEditingController(text: ""),"6%",TextEditingController(text: ""),0,0,""]);
            count++;
          });


        },),
      ),

      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: Icon(Icons.arrow_back,)),
        title:Center(child: Text("New Sales Order")),
        elevation: 0,
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: ()async{
            for(int i=0;i<orders.length;i++){
              if(orders[i][0].text.toString().isEmpty){
                n=1;
              }
              n=0;
            }
            if(_searchController.text.isEmpty){
              p=1;
            }
            else{
              p=0;
            }



            print(ind);
            if(n==0 && t==1 && y==1 && u==1) {
              if (ind == false) {
                if (q == 1 && w == 1 && e == 1 && r == 1 && p == 0) {
                  o=0;
                  await FirebaseFirestore.instance.collection("Customers").doc(
                      "customers").collection("customers").doc(
                      _searchController.text + newpass.text.toString()).set({
                    "cusid": _searchController.text + newpass.text.toString(),

                    "name": _searchController.text,
                    "street": newemail.text.toString(),
                    "city": city.text.toString(),
                    "post": post.text.toString(),
                    "phone": newpass.text.toString(),

                  });
                }
                else{
                  o=1;
                }
              }
              if(o==0) {
                final DocumentSnapshot<Map<String,
                    dynamic>> documentSnapshot = await FirebaseFirestore
                    .instance
                    .collection(widget.dv)
                    .doc("salesorder").get();
                var b;
                try {
                  b = documentSnapshot.get("id");
                  b += 1;
                }
                catch (e) {
                  b = 0;
                }
                double prices = 0;
                double gst = 0;
                Map<String, List<dynamic>> ord = {};
                for (int i = 0; i < orders.length; i++) {
                  ord[i.toString()] = [
                    orders[i][0].text,
                    int.parse(orders[i][1].text),
                    orders[i][2],
                    orders[i][3].text,
                    orders[i][4],
                    orders[i][5],
                    orders[i][6]
                  ];
                  prices +=
                      orders[i][4] * int.parse(orders[i][1].text) as double;
                  if (orders[i][2] == "12%")
                    gst += (orders[i][4] * int.parse(orders[i][1].text)) *
                        0.12 as double;
                  else if (orders[i][2] == "18%")
                    gst += (orders[i][4] * int.parse(orders[i][1].text)) *
                        0.18 as double;
                  else if (orders[i][2] == "28%")
                    gst += (orders[i][4] * int.parse(orders[i][1].text)) *
                        0.28 as double;
                  else if (orders[i][2] == "6%")
                    gst += (orders[i][4] * int.parse(orders[i][1].text)) *
                        0.06 as double;
                }
                print(b);
                print(ord);
                print(gst);
                await FirebaseFirestore.instance.collection(
                    widget.dv.toString())
                    .doc("salesorder").collection("salesorder").doc(b.toString())
                    .set({
                  "soid": b,
                  "level": 0,
                  "cusname": _searchController.text.toString(),
                  "order": ord,
                  "vno": conpass.text,
                  "ptype": paytype.text,
                  "price": prices,
                  "gst": gst,
                  "cusid":custid,
                });

                for(int i=0;i<orders.length;i++){
                  DocumentSnapshot data= await FirebaseFirestore.instance.collection(widget.dv).doc("items").collection("items").doc(orders[i][0].text.toString()).get();
                  await FirebaseFirestore.instance.collection(widget.dv).doc("items").collection("items").doc(orders[i][0].text.toString()).update({
                    "quantity": data["quantity"]-int.parse(orders[i][1].text.toString())
                  });
                }
                for(int i=0;i<orders.length;i++){
                  DocumentSnapshot data= await FirebaseFirestore.instance.collection("Universal").doc(orders[i][0].text.toString()).get();
                  await FirebaseFirestore.instance.collection("Universal").doc(orders[i][0].text.toString()).update({
                    "quantity": data["quantity"]-int.parse(orders[i][1].text.toString())
                  });
                }

                await FirebaseFirestore.instance.collection(widget.dv).doc(
                    "salesorder").set({
                  "id": b,

                });
                // await FirebaseFirestore.instance.collection(await FirebaseAuth.instance.currentUser!.email.toString()).doc("items").collection("items").doc(pass.text.toString()).update({"quantity":documents[0]["quantity"]-int.parse(conpass.text.toString())});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Order Placed Successfully",
                      style: GoogleFonts.poppins(color: Colors.white),),
                  ),
                );
                Navigator.pop(context, 'OK');
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Please enter all fields",style: GoogleFonts.poppins(color: Colors.red),),
                  ),
                );
              }

            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Please enter all fields",style: GoogleFonts.poppins(color: Colors.red),),
                ),
              );
            }
          }, icon: Icon(Icons.keyboard_arrow_right_sharp))
        ],
      ),
      body:SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [

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
                    StreamBuilder<QuerySnapshot>(
                        stream:FirebaseFirestore.instance.collection("Customers").doc("customers").collection("customers").snapshots(),

                        builder: (context,AsyncSnapshot snapshot){

                          if(snapshot.hasData){

                            List<String>x=[];
                            List<String> y=[];

                            var m=snapshot.data;
                            m.docs.forEach((element) {x.add(element.data()["name"]);});
                            m.docs.forEach((element) {y.add(element.data()["cusid"]);});
                            print(x);
                            return  Column(
                              children: [
                                SearchField(
                                  controller:_searchController,
                                  onSearchTextChanged: (xx){
                                    setState(() {
                                      ind=x.contains(_searchController.text.toString());
                                      print(ind);
                                    });
                                  },

                                  suggestions: x
                                      .map((e) => SearchFieldListItem(e))
                                      .toList(),
                                  suggestionState: Suggestion.expand,

                                  textInputAction: TextInputAction.next,
                                  hint: 'Customer Name',
                                  searchStyle: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                                  // validator: (x) {
                                  //   if (!_statesOfIndia.contains(x) || x!.isEmpty) {
                                  //     return 'Please Enter a valid State';
                                  //   }
                                  //   return null;
                                  // },


                                  searchInputDecoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                  ),
                                  maxSuggestionsInViewPort: 3,
                                  itemHeight: 50,
                                  onSuggestionTap:  (xx){
                                    setState(() {

                                      if(x.contains(xx.searchKey)){

                                        var ind=x.indexOf(xx.searchKey);
                                        custid=y[ind];

                                      }
                                    });

                                  },
                                ),

                                (_searchController.text!=""&&!x.contains(_searchController.text.toString()))?Container(child: Column(
                                  children: [
                                    SizedBox(height: 80,),
                                    Text("You are adding the new customer",style: TextStyle(
                                        fontSize: 19
                                    ),),SizedBox(height: 10,),
                                    Row(
                                      children: [
                                        Text("Street/Door No",style: TextStyle(fontSize: 15),),
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.start,
                                    ),SizedBox(height: 5,),
                                    TextFormField(
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (value) {

                                        if (value!.isEmpty) {
                                          return "Please enter street/Door no";
                                        }
                                        else {
                                          q=1;
                                          return null;
                                        }

                                      },
                                      controller: newemail,
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
                                        hintText: 'Enter Street/Door No',
                                      ),

                                    ),
                                    Row(
                                      children: [
                                        Text("City",style: TextStyle(fontSize: 15),),
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.start,
                                    ),SizedBox(height: 5,),
                                    TextFormField(
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (value) {

                                        if (value!.isEmpty) {
                                          return "Please enter city";
                                        }
                                        else {
                                          w=1;
                                          return null;
                                        }

                                      },
                                      controller: city,
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
                                        hintText: 'Enter City',
                                      ),

                                    ),
                                    Row(
                                      children: [
                                        Text("Postal Code",style: TextStyle(fontSize: 15),),
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.start,
                                    ),SizedBox(height: 5,),
                                    TextFormField(
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter postal code";
                                        }
                                        else if(value.toString().length  !=6){
                                          return "Please enter valid postal code";
                                        }
                                        else {
                                          e=1;
                                          return null;
                                        }

                                      },
                                      controller: post,
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
                                        hintText: 'Enter Postal Code',
                                      ),

                                    ),
                                    SizedBox(height: 10,),
                                    Row(

                                      children: [
                                        Text("Phoneno",style: TextStyle(fontSize: 15),),
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.start,
                                    ),SizedBox(height: 5,),
                                    TextFormField(
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter phone no";
                                        }
                                        else if(value.toString().length  !=10){
                                          return "Please enter valid phone no";
                                        }
                                        else {
                                          r=1;
                                          return null;
                                        }

                                      },
                                      controller: newpass,
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
                                        hintText: 'Enter Phoneno',
                                      ),

                                    ),

                                  ],
                                )):SizedBox(

                                ),



                              ],
                            );
                          }
                          else{
                            return CircularProgressIndicator();
                          }
                        }
                    )
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
                        Text("Payment Mode",style: TextStyle(fontSize: 15),),
                      ],
                    ),

                  ],
                ),
              ),
              SizedBox(height: 5,),
              Container(
                height:56,width: MediaQuery.of(context).size.width*0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius
                        .circular(7),
                    border: Border.all(
                        color: Colors
                            .black)),
                child: DropdownButtonHideUnderline(
                  child: Container(
                    margin:EdgeInsets.only(left:5),
                    decoration: BoxDecoration(border: Border.all(color: Color.fromARGB(255,255, 255, 255),),borderRadius: BorderRadius.circular(8)),
                    child: DropdownButton(
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      // Initial Value
                      value: paytype.text,

                      // Down Arrow Icon
                      icon: const Icon(Icons
                          .keyboard_arrow_down,color:  Colors.black,),

                      // Array list of items
                      items: li.map((
                          String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,style: TextStyle(color:Colors.black),),
                        );
                      }).toList(), onChanged: (String? value) {
                      setState(() {
                        paytype.text=value!;
                      });

                    },
                      // After selecting the desired option,it will
                      // change button value to selected value

                    ),
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Vehicle No",style: TextStyle(fontSize: 15),),
                      ],
                    ),

                  ],
                ),
              ),

              Padding(
                  padding: EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter Vehicle No";
                      }
                      else if(value.toString().length !=10){
                        return "Please enter valid vehicle no";
                      }
                      else {
                        t=1;
                        return null;
                      }

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
                      hintText: 'Vehicle No',
                    ),

                  )),

              SizedBox(height: 10,),

              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: <Widget>[
              //       ElevatedButton(
              //         style: TextButton.styleFrom(
              //             backgroundColor: Colors.black),
              //         onPressed: () => Navigator.pop(context, 'Cancel'),
              //         child: const Text('Cancel',),
              //       ),
              //       ElevatedButton(
              //         style: TextButton.styleFrom(
              //             backgroundColor: Colors.black),
              //         onPressed:()async{
              //           print(ind);
              //           if(ind==false){
              //             final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =  await FirebaseFirestore.instance
              //                 .collection(await FirebaseAuth.instance.currentUser!.email.toString())
              //                 .doc("customers").get();
              //             var b;
              //             try{b=documentSnapshot.get("id");
              //             b+=1;
              //             }
              //             catch(e){
              //               b=0;
              //             }
              //
              //             await FirebaseFirestore.instance.collection(await FirebaseAuth.instance.currentUser!.email.toString()).doc("customers").collection("customers").doc(b.toString()).set({
              //               "cusid":b,
              //
              //               "name":_searchController.text,
              //               "phone":newpass.text.toString(),
              //               "address":newemail.text.toString(),
              //
              //             });
              //
              //             await FirebaseFirestore.instance.collection(await FirebaseAuth.instance.currentUser!.email.toString()).doc("customers").set({
              //               "id":b,
              //
              //             });
              //           }
              //
              //           final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =  await FirebaseFirestore.instance
              //               .collection(await FirebaseAuth.instance.currentUser!.email.toString())
              //               .doc("salesorder").get();
              //           var b;
              //           try{b=documentSnapshot.get("id");
              //           b+=1;
              //           }
              //           catch(e){
              //             b=0;
              //           }
              //           QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
              //               .collection(await FirebaseAuth.instance.currentUser!.email.toString())
              //               .doc("items")
              //               .collection("items")
              //               .where("name", isEqualTo: pass.text.toString())
              //               .get();
              //
              //           List<DocumentSnapshot<Map<String, dynamic>>> documents = querySnapshot.docs;
              //
              //
              //
              //           await FirebaseFirestore.instance.collection(await FirebaseAuth.instance.currentUser!.email.toString()).doc("salesorder").collection("salesorder").doc(b.toString()).set({
              //             "soid":b,
              //             "level":0,
              //             "cusname":_searchController.text,
              //             "product":pass.text.toString(),
              //             "quantity":int.parse(conpass.text.toString()),
              //             "price":documents[0]["price"]*int.parse(conpass.text.toString()),
              //           });
              //
              //           await FirebaseFirestore.instance.collection(await FirebaseAuth.instance.currentUser!.email.toString()).doc("salesorder").set({
              //             "id":b,
              //
              //           });
              //           await FirebaseFirestore.instance.collection(await FirebaseAuth.instance.currentUser!.email.toString()).doc("items").collection("items").doc(pass.text.toString()).update({"quantity":documents[0]["quantity"]-int.parse(conpass.text.toString())});
              //           Navigator.pop(context, 'OK');
              //         },
              //
              //         child: const Text('Add'),
              //       ),
              //     ],
              //   ),
              // ),

              ListView.builder(
                  shrinkWrap: true,

                  physics: NeverScrollableScrollPhysics(),
                  itemCount: count,
                  itemBuilder: (context, i) {
                    List<String>ele=[];
                    for (int i=0;i<orders.length;i++){
                      ele.add(orders[i][0].text);
                    }
                    return Column(
                        children: [

                          SizedBox(height: i==0?40:20,),
                          Container(
                            margin:EdgeInsets.all(10),
                            child: Material(

                              borderRadius: BorderRadius.circular(20.0),
                              elevation: 8.0,
                              child: DecoratedBox(
                                position: DecorationPosition.background,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      20),gradient: LinearGradient(colors: [Colors.white,Colors.white]),),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 7,right: 20),
                                          child: IconButton(color: Colors.black,onPressed: () {
                                            setState(() {


                                              orders.removeAt(i);
                                              count--;

                                            });
                                          }, icon: Icon(Icons.close)),
                                        ),
                                        Text("Item ${i+1}",style: TextStyle(color: Colors.black,fontSize: 20)),
                                        SizedBox(width: 50,)

                                      ],),
                                    SizedBox(height: 0,),
                                    Container(
                                      child:Row(
                                        children: [

                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        decoration: BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize
                                              .max,
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          children: [


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
                                                  StreamBuilder<QuerySnapshot>(
                                                      stream:FirebaseFirestore.instance.collection(widget.dv).doc("items").collection("items").where("name",whereNotIn: ele).snapshots(),

                                                      builder: (context,AsyncSnapshot snapshot){

                                                        if(snapshot.hasData){
                                                          List<List<dynamic>>x=[[],[],[],[],[]];

                                                          var m=snapshot.data;
                                                          m.docs.forEach((element) {x[0].add(element.data()["name"]);
                                                          x[1].add(element.data()["price"]);
                                                          x[2].add(element.data()["hsbn"]);
                                                          x[3].add(element.data()["gsttype"]);
                                                          x[4].add(element.data()["type"]);
                                                          });
                                                          return  SearchField(
                                                              onSearchTextChanged:  (xx){
                                                                setState(() {
                                                                  orders[i][4]=0;
                                                                  orders[i][5]=0;
                                                                  orders[i][2]="%6";
                                                                  orders[i][6]="";
                                                                  if(x[0].contains(xx)){

                                                                    var ind=x[0].indexOf(xx);
                                                                    orders[i][4]=x[1][ind];
                                                                    orders[i][5]=x[2][ind];
                                                                    orders[i][2]=x[3][ind];
                                                                    orders[i][6]=x[4][ind];

                                                                  }
                                                                });

                                                              },
                                                              onSuggestionTap:  (xx){
                                                                setState(() {
                                                                  orders[i][4]=0;
                                                                  orders[i][5]=0;
                                                                  orders[i][2]="%6";
                                                                  orders[i][6]="";
                                                                  if(x[0].contains(xx.searchKey)){

                                                                    var ind=x[0].indexOf(xx.searchKey);
                                                                    orders[i][4]=x[1][ind];
                                                                    orders[i][5]=x[2][ind];
                                                                    orders[i][2]=x[3][ind];
                                                                    orders[i][6]=x[4][ind];

                                                                  }
                                                                });

                                                              },
                                                              controller: orders[i][0],
                                                              suggestions: x[0]
                                                                  .map((e) => SearchFieldListItem(e))
                                                                  .toList(),
                                                              suggestionState: Suggestion.expand,
                                                              textInputAction: TextInputAction.next,
                                                              hint: 'Product Name',
                                                              searchStyle: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors.black.withOpacity(0.8),
                                                              ),
                                                              // validator: (x) {
                                                              //   if (!_statesOfIndia.contains(x) || x!.isEmpty) {
                                                              //     return 'Please Enter a valid State';
                                                              //   }
                                                              //   return null;
                                                              // },
                                                              searchInputDecoration: InputDecoration(
                                                                focusedBorder: OutlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                    color: Colors.black.withOpacity(0.8),
                                                                  ),
                                                                ),
                                                                border: OutlineInputBorder(
                                                                  borderSide: BorderSide(color: Colors.red),
                                                                ),
                                                              ),
                                                              maxSuggestionsInViewPort: 3,
                                                              itemHeight: 50,
                                                              onSubmit: (xx){
                                                                setState(() {
                                                                  orders[i][4]=0;
                                                                  orders[i][5]=0;
                                                                  print("hhghgh");
                                                                  if(x[0].contains(xx)){
                                                                    print("fdff");
                                                                    var ind=x[0].indexOf(xx);
                                                                    orders[i][4]=x[1][ind];
                                                                    orders[i][5]=x[2][ind];
                                                                    print(orders);
                                                                  }
                                                                });

                                                              }
                                                          );
                                                        }
                                                        else{
                                                          return CircularProgressIndicator();
                                                        }
                                                      }),
                                                  SizedBox(height: 10,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text("Enter quantity",style: TextStyle(fontSize: 15),),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5,),
                                                  TextFormField(
                                                    autovalidateMode: AutovalidateMode.always,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        y=0;
                                                        return "Please enter quantity";
                                                      }
                                                      else {
                                                        y=1;
                                                        return null;
                                                      }
                                                    },
                                                    controller: orders[i][1],
                                                    onChanged: (v){
                                                      setState(() {

                                                      });
                                                    },
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

                                                  ),


                                                  SizedBox(height: 10,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text("Enter Description",style: TextStyle(fontSize: 15),),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5,),
                                                  TextFormField(
                                                    autovalidateMode: AutovalidateMode.always,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        u=0;
                                                        return "Please enter password";
                                                      }
                                                      else {
                                                        u=1;
                                                        return null;
                                                      }
                                                    },
                                                    controller: orders[i][3],
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
                                                      hintText: 'Enter description',
                                                    ),

                                                  ),
                                                  SizedBox(height: 15,),
                                                  Row(
                                                    children: [
                                                      (orders[i][1].text!="" &&orders[i][0].text!="")?Text("Rate: ${orders[i][4]*int.parse(orders[i][1].text)}"):Text("Rate: 0"),
                                                    ],mainAxisAlignment: MainAxisAlignment.start,
                                                  )
                                                ],
                                              ),
                                            ),


                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,)

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]
                    );
                  }

              )
            ],
          ),
        ),
      ),
    );
  }
}