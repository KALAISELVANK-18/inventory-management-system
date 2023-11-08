import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Customertrash extends StatefulWidget {
  final String dropdownValue;
  const Customertrash({required this.dropdownValue});

  @override
  State<Customertrash> createState() => _CustomertrashState();
}

class _CustomertrashState extends State<Customertrash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:FirebaseFirestore.instance.collection("Customers").doc("customerstrash").collection("customerstrash").snapshots(),


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
                      padding: const EdgeInsets.only(top: 15),
                      child: Align(alignment: Alignment.center,
                          child: Text("Trash For Customers",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 16),)),
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
                                                  Text("${nn[ind]["name"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 20,fontWeight: FontWeight.w600)),
                                                  SizedBox(height: 5,),
                                                  Row(
                                                    children: [
                                                      Icon(Icons.location_on,size: 20,),SizedBox(width: 5,),
                                                      Column(
                                                        children: [
                                                          Text("street: ${nn[ind]["street"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 12,)),
                                                          Text("city: ${nn[ind]["city"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 12,)),
                                                          Text("pin: ${nn[ind]["post"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 12,)),
                                                        ],
                                                      ),

                                                    ],
                                                  )
                                                  ,SizedBox(height: 5,),

                                                  Row(
                                                    children: [
                                                      Icon(Icons.phone_android_outlined,size: 20,),SizedBox(width: 5,),
                                                      Text("${nn[ind]["phone"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,))

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
                                              Container(
                                                  decoration: BoxDecoration(
                                                      color: Color.fromARGB(255, 231,	245,	254),
                                                      borderRadius: BorderRadius.circular(15)
                                                  ),
                                                  child: TextButton(onPressed: ()async{
                                                    await FirebaseFirestore.instance.collection("Customers").doc("customers").collection("customers").doc(nn[ind]["name"]+nn[ind]["phone"]).set({
                                                      "cusid":nn[ind]["name"]+nn[ind]["phone"],
                                                      "name":nn[ind]["name"],
                                                      "street":nn[ind]["street"],
                                                      "city":nn[ind]["city"],
                                                      "post":nn[ind]["post"],
                                                      "phone":nn[ind]["phone"]

                                                    });
                                                    await FirebaseFirestore.instance.collection("Customers").doc("customerstrash").collection("customerstrash").doc(nn[ind]["name"]+nn[ind]["phone"]).delete();

                                                  },child: Row(
                                                    children: [
                                                      Text("Restore",style: TextStyle(color: Colors.black)),
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
                                                  child: TextButton(onPressed: ()async{
                                                    await FirebaseFirestore.instance.collection("Customers").doc("customerstrash").collection("customerstrash").doc(nn[ind]["name"]).delete();
                                                  },child: Row(
                                                    children: [
                                                      Text("Delete",style: TextStyle(color: Colors.black)),
                                                      SizedBox(width: 5,),
                                                      Icon(Icons.remove_red_eye,color: Colors.black,),
                                                    ],
                                                  ),)),

                                            ],
                                          ),
                                        )
                                      ],
                                    ),
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
