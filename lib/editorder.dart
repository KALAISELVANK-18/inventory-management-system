



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';




class Newe extends StatefulWidget {
  Newe({super.key,required this.dv,required this.lis});
  String dv;
  DocumentSnapshot lis;

  @override
  State<Newe> createState() => _NeweState();
}

class _NeweState extends State<Newe> {


  List<String> list = <String>["6%","12%","18%","28%"];
  List<String> li=<String>["Cash","Online","Credit"];
  TextEditingController _searchController = TextEditingController();
  TextEditingController conpass=TextEditingController();
  TextEditingController paytype=TextEditingController(text: "Cash");
  List<List<dynamic>> orders=[];
  List<List<dynamic>> order=[];
  bool ind=true;
  int count =0;
  int q=0,w=0,e=0,r=0,t=0,y=0,u=0,o=0;

  @override
  initState() {
    super.initState();
    var x=widget.lis["order"];

    count=x.length;
    paytype=TextEditingController(text:widget.lis["ptype"]);
    _searchController=TextEditingController(text:widget.lis["cusname"]);
    conpass=TextEditingController(text: widget.lis["vno"]);
    for(int i=0;i<x.length;i++){
      orders.add([TextEditingController(text:x[i.toString()][0].toString()),TextEditingController(text:x[i.toString()][1].toString()),x[i.toString()][2],TextEditingController(text:x[i.toString()][3].toString()),x[i.toString()][4],x[i.toString()][5]]);
      order.add([x[i.toString()][0].toString(),x[i.toString()][1].toString(),x[i.toString()][2],x[i.toString()][3].toString(),x[i.toString()][4],x[i.toString()][5]]);
    }

    print(orders);

  }

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





            orders.add([TextEditingController(text: ""),TextEditingController(text: ""),"6%",TextEditingController(text: ""),0,0]);
            count++;
          });

        },),
      ),

      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: Icon(Icons.arrow_back,)),
        title:Center(child: Text("Edit Order: ${widget.lis.id}")),
        elevation: 0,
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: ()async{

            for(int i=0;i<orders.length;i++){
              if(orders[i][0].text.toString().isEmpty){
                u=1;
              }
              u=0;
            }
            if(_searchController.text.isEmpty){
              o=1;
            }
            else{
              o=0;
            }
            if(q==1 && w==1 && e==1 && u==0 && o==0 ) {
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
                  orders[i][5]
                ];
                prices += orders[i][4] * int.parse(orders[i][1].text) as double;
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
              for(int i=0;i<order.length;i++)
                {
                  DocumentSnapshot data = await FirebaseFirestore.instance.collection(widget.dv).doc("items").collection("items").doc(order[i][0].toString()).get();
                  await FirebaseFirestore.instance.collection(widget.dv).doc("items").collection("items").doc(order[i][0].toString()).update({
                    "quantity":data["quantity"]+int.parse(order[i][1].toString())
                  });
                }
              for(int i=0;i<orders.length;i++)
                {
                  DocumentSnapshot data = await FirebaseFirestore.instance.collection(widget.dv).doc("items").collection("items").doc(orders[i][0].text.toString()).get();
                  await FirebaseFirestore.instance.collection(widget.dv).doc("items").collection("items").doc(orders[i][0].text.toString()).update({
                    "quantity":data["quantity"]-int.parse(orders[i][1].text.toString())
                  });
                }

              // print(ord);
              // print(gst);

              await FirebaseFirestore.instance.collection(widget.dv.toString())
                  .doc("salesorder").collection("salesorder").doc(widget.lis.id)
                  .update({

                "level": 0,
                "cusname": _searchController.text.toString(),
                "order": ord,
                "vno": conpass.text,
                "ptype": paytype.text,
                "price": prices,
                "gst": gst,
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Order Edited Successfully",style: GoogleFonts.poppins(color: Colors.white),),
                ),
              );


              Navigator.pop(context, 'OK');
            }
            else{
              print(q);
              print(w);
              print(e);
              print(u);
              print(o);

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

                            var m=snapshot.data;
                            m.docs.forEach((element) {x.add(element.data()["name"]);});
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
                                  onSuggestionTap: (cc){
                                    FocusManager.instance.primaryFocus?.unfocus();
                                    setState(() {
                                      ind=x.contains(_searchController.text.toString());
                                      print(ind);
                                    });
                                  },
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
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) {
                      if (value!.isEmpty) {
                        q=0;
                        return "Please enter Vehicle No";
                      }
                      else {
                        q=1;
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
                                                          List<List<dynamic>>x=[[],[],[],[]];

                                                          var m=snapshot.data;
                                                          m.docs.forEach((element) {x[0].add(element.data()["name"]);
                                                          x[1].add(element.data()["price"]);
                                                          x[2].add(element.data()["hsn"]);
                                                          x[3].add(element.data()["gst"]);
                                                          });
                                                          return  SearchField(
                                                              onSearchTextChanged: (xx){
                                                                setState(() {
                                                                  orders[i][4]=0;
                                                                  orders[i][5]=0;
                                                                  orders[i][2]="%6";
                                                                  if(x[0].contains(xx)){

                                                                    var ind=x[0].indexOf(xx);
                                                                    orders[i][4]=x[1][ind];
                                                                    orders[i][5]=x[2][ind];
                                                                    orders[i][2]=x[3][ind];

                                                                  }
                                                                });

                                                              },
                                                              onSuggestionTap: (xx){
                                                                setState(() {
                                                                  orders[i][4]=0;
                                                                  orders[i][5]=0;
                                                                  orders[i][2]="%6";
                                                                  if(x[0].contains(xx.searchKey)){

                                                                    var ind=x[0].indexOf(xx.searchKey);
                                                                    orders[i][4]=x[1][ind];
                                                                    orders[i][5]=x[2][ind];
                                                                    orders[i][2]=x[3][ind];

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
                                                        w=0;
                                                        return "Please enter password";
                                                      }
                                                      else {
                                                        w=1;
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
                                                        e=0;
                                                        return "Please enter password";
                                                      }
                                                      else {
                                                        e=1;
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