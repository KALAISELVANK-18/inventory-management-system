import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventorymanagement/customerspage.dart';
import 'package:inventorymanagement/editcustomer.dart';

class Customer extends StatefulWidget {
  final String dropdownValue;
  const Customer({required this.dropdownValue});

  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
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
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CustomerPage(dropdownValue: widget.dropdownValue)));
        },
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255,26, 26, 29),
        title: Center(child: Text("Customers")),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:(_searchController.text=="")?FirebaseFirestore.instance.collection("Customers").doc("customers").collection("customers").snapshots():FirebaseFirestore.instance.collection("Customer").doc("customers").collection("customers").where("name",isLessThanOrEqualTo: _searchController.text.toString().substring(0,_searchController.text.toString().length-1)+shiftCharacter(_searchController.text.toString()[_searchController.text.toString().length-1]),isGreaterThanOrEqualTo: _searchController.text.toString()).snapshots(),


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
                            labelText: 'Search Customer',
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
                                                  child: SingleChildScrollView(
                                                    scrollDirection: Axis.horizontal,
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
                                                                Container(
                                                                    width:200,
                                                                    child: Text("${nn[ind]["street"]},${nn[ind]["city"]},${nn[ind]["post"]}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 12,))),

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
                                                          MaterialPageRoute(builder: (context) => EditCustomer(
                                                            name: nn[ind]["name"],
                                                            street: nn[ind]["street"],
                                                            city: nn[ind]["city"],
                                                            post: nn[ind]["post"],
                                                            phone: nn[ind]["phone"],
                                                            dropdownValue: widget.dropdownValue,
                                                          )),
                                                        );

                                                      },child: Row(
                                                        children: [
                                                          Text("Edit",style: TextStyle(color: Colors.black)),
                                                          SizedBox(width: 10,),
                                                          Icon(Icons.edit,color: Colors.black,),
                                                        ],mainAxisAlignment: MainAxisAlignment.end,
                                                      ),)),
                                                  SizedBox(height: 5,),



                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onLongPress: ()=>{
                                  bi(nn[ind]["name"],nn[ind]["street"],nn[ind]["city"],nn[ind]["post"],nn[ind]["phone"])
                                },
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
  Future <void> bi(String name,String street,String city,String post,String phone)async {
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
                  await FirebaseFirestore.instance.collection("Customers").doc("customers").collection("customers").doc(name+phone).delete();
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
