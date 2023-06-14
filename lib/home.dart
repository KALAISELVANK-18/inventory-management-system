import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventorymanagement/customer.dart';
import 'package:inventorymanagement/items.dart';
import 'package:inventorymanagement/order.dart';
import 'package:inventorymanagement/signin.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(

        backgroundColor: Colors.white,
        width: 180,
        child: ListView(
          children: [
            DrawerHeader(decoration: BoxDecoration(color: Colors.white),
              child:Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: Row(

                  children: [
                    Icon(Icons.data_exploration,color: Colors.deepPurple,),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'inven',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'EX',
                            style: GoogleFonts.poppins(
                                color: Colors.blueAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'pert',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),


            ListTile(
              onTap: ()async{
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Signin(),
                ),
              );},
              hoverColor: Colors.blueAccent,
              title: Text("Logout"),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255,26, 26, 29),
        title: Center(child: Text("Kalai's Inventory")),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:20.0),
            child: Icon(Icons.notification_add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255,26, 26, 29)
              ),
              height: 252,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    height: 220,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(

                            children: [
                              Icon(Icons.scatter_plot,color: Colors.blueAccent,),
                              Text("Get Managed",style: GoogleFonts.poppins(color: Colors.black, fontSize: 18),),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Row(
                            children: [
                              Text("     Welcome to Expert inventory! We are here\nto manage your inventory you can run your\nbusiness well using our EXpert!!",
                              style: GoogleFonts.poppins(color: Colors.black, fontSize: 14,)),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 231,	245,	254),
                                borderRadius: BorderRadius.circular(15)
                            ),

                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Your Company's current Status!",),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right:10.0,top: 7,bottom: 7),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        child: TextButton(onPressed: (){}, child: Text("Explore",style: GoogleFonts.poppins(color: Colors.deepOrange[300], fontSize: 14,fontWeight: FontWeight.w400)))),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Manage All",style: GoogleFonts.poppins(color: Colors.black, fontSize: 18,)),

                ],),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  TextButton(
                    onPressed:(){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Items(),
                        ),
                      );
                  },
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5.0,
                            blurRadius: 5.0,
                            offset: Offset(0, 3), // changes the shadow position
                          ),

                        ],
                      ),
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: Column(
                                children: [
                                  Text("Items",style:GoogleFonts.poppins(color: Colors.black, fontSize: 15,)),
                                  SizedBox(height: 10,),
                                  Padding(
                                    padding: const EdgeInsets.only(left:8.0),
                                    child: Container(height: 50,width: 50,
                                        child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhS0I_z93xg5Y-g3SmgqwqesxlqH9rvp3lvILcA0MQAbkSH5SR589_3cgce6kVpkFg-Jzi8tOfbxY&usqp=CAU&ec=48665699'),
                                  )),
                                ],
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed:(){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Customer(),
                        ),
                      );
                    },
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5.0,
                            blurRadius: 5.0,
                            offset: Offset(0, 3), // changes the shadow position
                          ),

                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: Text("Customers",style:GoogleFonts.poppins(color: Colors.black, fontSize: 14,))),
                            ),
                          ),

                          Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Container(height: 60,width: 60,
                                child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQeOqJlZbM83qVeuyEM_qAjL3yu1SX5yhWKuM9L2pMYCA&usqp=CAU&ec=48665699'),
                              )),
                        ],
                      ),
                      margin: EdgeInsets.all(8.0),
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Orders(),
                        ),
                      );
                    },
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5.0,
                            blurRadius: 5.0,
                            offset: Offset(0, 3), // changes the shadow position
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: Text("Orders",style:GoogleFonts.poppins(color: Colors.black, fontSize: 15,))),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Container(height: 50,width: 50,
                                child: Image.network('https://cdn-icons-png.flaticon.com/512/1356/1356594.png'),
                              )),
                        ],
                      ),
                      margin: EdgeInsets.all(8.0),
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Orders(),
                        ),
                      );
                    },
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5.0,
                            blurRadius: 5.0,
                            offset: Offset(0, 3), // changes the shadow position
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(child: Text("Packages",style:GoogleFonts.poppins(color: Colors.black, fontSize: 15,))),
                            ),
                          ),
                          SizedBox(height: 0,),
                          Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Container(height: 60,width: 60,
                                child: Image.network('https://media.istockphoto.com/id/1266320680/vector/courier-delivers-the-parcel-to-the-addressee-illustration-smartphones-tablets-user-interface.jpg?s=612x612&w=0&k=20&c=IvzvJ4cnZIrdoaNpdGPjaUJZAY7ucRvtiLg0jGOTp8M='),
                              )),
                        ],
                      ),
                      margin: EdgeInsets.all(8.0),
                    ),
                  ),

                  // Add more containers as needed
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Sales Activity",style: GoogleFonts.poppins(color: Colors.black, fontSize: 18,)),
                  Icon(Icons.refresh)
                ],),
            ),
            ListView.builder(

                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,

                itemCount: 4,
                itemBuilder: (context,index){
                  List<String> a=["https://static.vecteezy.com/system/resources/previews/004/461/894/original/invoice-payments-flat-illustration-bill-pay-online-receipt-cartoon-concept-internet-banking-account-ebanking-user-credit-cards-transactions-instant-money-transfer-by-click-metaphor-vector.jpg",
                    "https://media.istockphoto.com/id/1445750699/pt/vetorial/welcoming-cartoon-parcel-delivery-service-vector-illustration.jpg?s=612x612&w=0&k=20&c=THGXX2WGlbMCZxA58p1yzPByB2dKEn6v_Es_FBA7LSs=","https://thumbs.dreamstime.com/z/logistic-delivery-shipping-cartoon-logistic-delivery-shipping-truck-carrying-merchandise-gps-location-tracing-153494330.jpg",
                    "https://as1.ftcdn.net/jpg/04/54/12/20/160_F_454122065_01Z0YnH4IKgJHKuvrsfRDs6yyHcjywco.jpg",
                    ];

                  List<String> b=["Quantity to be invoiced","Quantity to be packed","Packages to be shipped","Packages to be delivered",];


                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      children: [
                        Container(
                          height: 100,
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
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Container(height: 70,width: 70,
                                          child: Image.network(a[index])),

                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left:15.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                              StreamBuilder(
                                  stream:FirebaseFirestore.instance
                                          .collection(FirebaseAuth.instance.currentUser!.email.toString()).doc("salesorder").collection("salesorder").where("level",isEqualTo: index).snapshots(),
                                  builder:(context,AsyncSnapshot snapshot){

                                  if(snapshot.hasData) {

                                    return Text("${snapshot.data.docs.length}",style:GoogleFonts.poppins(color: Colors.black, fontSize: 30,));
                                  }
                                  else
                                  return CircularProgressIndicator();


                                  }),
                                    SizedBox(height: 5,),
                                    Text(b[index],style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Icon(Icons.arrow_forward_ios),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),


          ],
        ),
      ),
    );
  }
}
