import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventorymanagement/editorder.dart';
import 'package:inventorymanagement/invoice.dart';
import 'package:inventorymanagement/newsales.dart';




class Orders extends StatefulWidget {
  final String dropdownValue;
  const Orders({required this.dropdownValue});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  final _formKey = GlobalKey<FormState>();

  int indi=-1;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>New(dv:widget.dropdownValue)));
        },
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255,26, 26, 29),
        title: Center(child: Text("Sales Orders")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream:FirebaseFirestore.instance.collection(widget.dropdownValue).doc("salesorder").collection("salesorder").orderBy("soid",descending: true).snapshots(),


              builder: (context, AsyncSnapshot snapshot) {
                if(snapshot.hasError)
                {
                  return Text("${snapshot.error}");
                }
                else
                {

                  if(snapshot.hasData) {
                    List<DocumentSnapshot>nn=snapshot.data.docs;
                    List<String> mm=["Ordered","Invoice"];
                    return SingleChildScrollView(
                      child: Column(
                        children: [


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
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Container(
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
                                                                SizedBox(width: 6,),(nn[ind]["level"]==1)?Icon(Icons.check_circle_rounded,color: Colors.greenAccent,):SizedBox()
                                                              ],
                                                            ),
                                                            SizedBox(height: 5,),
                                                            Text("${nn[ind]["cusname"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 25,)),
                                                            SizedBox(height: 5,),
                                                            Row(
                                                              children: [
                                                                Icon(Icons.currency_rupee_rounded),SizedBox(width: 5,),
                                                                Text("${nn[ind]["price"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,)),
                                                              ],
                                                            )
                                                            ,SizedBox(height: 5,),
                                                            // Text("Gst: ${nn[ind]["gst"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,))
                                                            // ,SizedBox(height: 5,),
                                                            // Text("Price with Gst: ${nn[ind]["price"]+nn[ind]["gst"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,))
                                                            // ,SizedBox(height: 6,),
                                                            Text("Quantity: ${nn[ind]["order"].length}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,))
                                                            ,SizedBox(height: 6,),

                                                            // ListView.builder(
                                                            // itemCount: nn[ind]["order"].length,
                                                            // itemBuilder: (context,i){
                                                            //   return Column(
                                                            //     children: [
                                                            //       Text("Name${nn[ind]["orders"][0]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 25,)),
                                                            //       SizedBox(height: 5,),
                                                            //       Text("Price: ${nn[ind]["orders"][1]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,))
                                                            //       ,SizedBox(height: 5,),
                                                            //       Text("Gst: ${nn[ind]["orders"][2]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,))
                                                            //       ,SizedBox(height: 5,),
                                                            //       Text("Price with Gst: ${nn[ind]["orders"][3]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,))
                                                            //       ,SizedBox(height: 6,),
                                                            //       Text("No of products: ${nn[ind]["orders"][4]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,))
                                                            //       ,SizedBox(height: 6,),
                                                            //     ],
                                                            //   );
                                                            // }),





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
                                                            child: TextButton(onPressed: (){
                                                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Newe(dv: widget.dropdownValue, lis: nn[ind])));
                                                            },child: Row(
                                                              children: [
                                                                Text("Edit",style: TextStyle(color: Colors.black)),
                                                                SizedBox(width: 10,),
                                                                Icon(Icons.edit,color: Colors.black,),
                                                              ],
                                                            ),)):SizedBox(),


                                                        SizedBox(height: 5,),
                                                        (nn[ind]["level"]==0)?Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors.red.shade50,
                                                                borderRadius: BorderRadius.circular(15)
                                                            ),
                                                            child: TextButton(onPressed: (){


                                                              if(nn[ind]["level"]==0){
                                                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>InvoicePage(dv: widget.dropdownValue,lis: nn[ind],)));
                                                             }


                                                            },child:Text("${mm[nn[ind]["level"]+1]} >>"))):SizedBox(),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10,),

                                          (ind==indi)?Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left:15.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text("Products"),
                                                  ],
                                                ),
                                              ),SizedBox(height: 8,),
                                              Padding(
                                                padding: const EdgeInsets.all(0),
                                                child: Table(
                                                  columnWidths: const <int, TableColumnWidth>{
                                                    0: IntrinsicColumnWidth(),
                                                    1: FixedColumnWidth(70),
                                                    2: IntrinsicColumnWidth(),
                                                    3: IntrinsicColumnWidth(),
                                                    4: IntrinsicColumnWidth(),
                                                    5: IntrinsicColumnWidth(),
                                                  },
                                                  border: TableBorder.all(color: Colors.white),

                                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                                  children: <TableRow>[


                                                    TableRow(children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(right:20.0),
                                                        child: Text("S.No", style: TextStyle(fontSize: 12.0),),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(right:20.0),
                                                        child: Text("Name", style: TextStyle(fontSize: 12.0),),
                                                      ),

                                                      Padding(
                                                        padding: const EdgeInsets.only(right:20.0),
                                                        child: Text("Rate", style: TextStyle(fontSize: 12.0),),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(right:20.0),
                                                        child: Text("Quantity", style: TextStyle(fontSize: 12.0),),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(right:8.0),
                                                        child: Text("GST", style: TextStyle(fontSize: 12.0),),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(right:8.0),
                                                        child: Text("Price", style: TextStyle(fontSize: 12.0),),
                                                      ),
                                                    ]),
                                                    for(int i=0;i<nn[ind]["order"].length;i++)
                                                      TableRow(children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(right:8.0),
                                                          child: Text((i+1).toString(), style: TextStyle(fontSize: 12.0),),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(right:8.0),
                                                          child: Text("${nn[ind]["order"][i.toString()][0]}", style: TextStyle(fontSize: 12.0),),
                                                        ),

                                                        Padding(
                                                          padding: const EdgeInsets.only(right:8.0),
                                                          child: Text("${nn[ind]["order"][i.toString()][4]}", style: TextStyle(fontSize: 12.0),),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(right:8.0),
                                                          child: Text("${nn[ind]["order"][i.toString()][1]}", style: TextStyle(fontSize: 12.0),),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(right:8.0),
                                                          child: Text("${nn[ind]["order"][i.toString()][2]}", style: TextStyle(fontSize: 12.0),),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(right:8.0),
                                                          child: Text("${double.parse(nn[ind]["order"][i.toString()][1].toString())*nn[ind]["order"][i.toString()][4]}", style: TextStyle(fontSize: 12.0),),
                                                        ),

                                                      ]),

                                                  ],
                                                ),
                                              ),
                                            ],
                                          ):SizedBox(),

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text("Ordered",style:GoogleFonts.poppins(color: Colors.black, fontSize: 10,)),

                                                (nn[ind]["level"]<0)?Icon(Icons.circle_outlined,color: Colors.black,size: 13,):Icon(Icons.circle,color: Colors.blue,size: 13,),SizedBox(width: 6,),
                                                Text("Invoiced",style:GoogleFonts.poppins(color: Colors.black, fontSize: 10,)),

                                                (nn[ind]["level"]<1)?Icon(Icons.circle_outlined,color: Colors.black,size: 13,):Icon(Icons.circle,color: Colors.blue,size: 13,), SizedBox(width: 6,),
                                                //   Text("Shipped",style:GoogleFonts.poppins(color: Colors.black, fontSize: 10,)),
                                                //
                                                //   (nn[ind]["level"]<3)?Icon(Icons.circle_outlined,color: Colors.black,size: 13,):Icon(Icons.circle,color: Colors.blue,size: 13,),SizedBox(width: 6,),
                                                //   Text("delivered",style:GoogleFonts.poppins(color: Colors.black, fontSize: 10,)),
                                                //
                                                //   (nn[ind]["level"]<4)?Icon(Icons.circle_outlined,color: Colors.black,size: 13,):Icon(Icons.circle,color: Colors.blue,size: 13,),SizedBox(width: 6,),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              (ind!=indi)?TextButton(
                                                onPressed: (){

                                                  setState(() {
                                                    indi=ind;

                                                  });

                                                },
                                                child:Row(
                                                  children: [
                                                    Text("Show more",style: TextStyle(color:Colors.black),),
                                                    SizedBox(width: 5,),
                                                    Icon(Icons.keyboard_arrow_down)
                                                  ],
                                                ) ,
                                              ):TextButton(
                                                onPressed: (){
                                                  setState(() {
                                                    indi=-1;
                                                  });
                                                },
                                                child:Row(
                                                  children: [
                                                    Text("Show less",style: TextStyle(color:Colors.black)),
                                                    SizedBox(width: 5,),
                                                    Icon(Icons.keyboard_arrow_up)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
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
          ],
        ),
      ),
    );
  }
}