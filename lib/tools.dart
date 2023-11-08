import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventorymanagement/camera.dart';
import 'package:inventorymanagement/signin.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'company.dart';

class Tools extends StatefulWidget {
  String dropdownvalue;
  List<CameraDescription>? cameras;
   Tools({super.key,required this.dropdownvalue,required this.cameras});

  @override
  State<Tools> createState() => _ToolsState();
}

class _ToolsState extends State<Tools> {
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
                PersistentNavBarNavigator.pushNewScreen(
                  context,

                  screen: Signin(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );},
              hoverColor: Colors.blueAccent,
              title: Text("Logout"),
            ),

            ListTile(
              onTap: ()async{

                PersistentNavBarNavigator.pushNewScreen(
                  context,

                  screen: Company(cameras: widget.cameras,),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );},
              hoverColor: Colors.blueAccent,
              title: Text("Change profile"),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Center(child: Text("Tools",style: TextStyle(
          color: Colors.black
        ),)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:20.0),
            child: Icon(Icons.notification_add,color: Colors.black,),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white60
          ),
          child: Column(
            children: [
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("quality check",style: GoogleFonts.aBeeZee(textStyle: TextStyle(
                      color: Colors.black,fontSize: 25
                    ),) ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[

                    Column(
                      children: [
                        Container(
                          width: 160.0,
                          height: 236.0,
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
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Center(child: Column(
                                    children: [

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(left:8.0),
                                              child: Container(height: 120,width: 120,
                                                child: Image.asset("images/sugar.jpg"),
                                              )),
                                        ],
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(left:8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("bagasse",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w600)),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top:25),
                                            child: Container(
                                              decoration:BoxDecoration(
                                      gradient: LinearGradient(
                                            colors: [
                                              Color.fromARGB(255,54, 209, 220),
                                            Color.fromARGB(150,91, 134, 229)
                                            //add more colors
                                            ]),
                                      borderRadius: BorderRadius.circular(15),
                    //                   boxShadow: <BoxShadow>[
                    //                   BoxShadow(
                    //                   color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                    // blurRadius: 5)]
                                      ),
                                              child: TextButton(
                                                onPressed: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TakePictureScreen(tar: "bagasse",cameras: widget.cameras,)));

                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 19.0),
                                                  child: Text("check",style:GoogleFonts.alef(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w500)),

                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 160.0,
                          height: 186.0,
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
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Center(child: Column(
                                    children: [

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(left:8.0),
                                              child: Container(height: 100,width: 100,
                                                child: Image.asset("images/shell.jpg"),
                                              )),
                                        ],
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(left:8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("Coconut shell",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w600)),
                                          ],
                                        ),
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top:6.0),
                                            child: Container(
                                              decoration:BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(150,255, 95, 109),
                                                      Color.fromARGB(255,255, 195, 113)
                                                      //add more colors
                                                    ]),
                                                borderRadius: BorderRadius.circular(15),
                                                //                   boxShadow: <BoxShadow>[
                                                //                   BoxShadow(
                                                //                   color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                                                // blurRadius: 5)]
                                              ),
                                              child: TextButton(
                                                onPressed: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TakePictureScreen(tar: "shell",cameras: widget.cameras,)));

                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 19.0),
                                                  child: Text("check",style:GoogleFonts.alef(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w500)),

                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  )),
                                ),
                              )
                            ],
                          ),
                          margin: EdgeInsets.all(8.0),
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        Container(
                          width: 160.0,
                          height: 186.0,
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
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Center(child: Column(
                                    children: [

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(left:8.0),
                                              child: Container(height: 100,width: 100,
                                                child: Image.asset("images/Coconut-husk.jpg"),
                                              )),
                                        ],
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(left:8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("coconut husk",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w600)),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top:6.0),
                                            child: Container(
                                              decoration:BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(150,255, 95, 109),
                                                      Color.fromARGB(255,255, 195, 113)
                                                      //add more colors
                                                    ]),
                                                borderRadius: BorderRadius.circular(15),
                                                //                   boxShadow: <BoxShadow>[
                                                //                   BoxShadow(
                                                //                   color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                                                // blurRadius: 5)]
                                              ),
                                              child: TextButton(
                                                onPressed: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TakePictureScreen(tar: "husk",cameras: widget.cameras,)));
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 19.0),
                                                  child: Text("check",style:GoogleFonts.alef(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w500)),

                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 160.0,
                          height: 236.0,
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
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Center(child: Column(
                                    children: [

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding: const EdgeInsets.only(left:8.0),
                                              child: Container(height: 120,width: 120,
                                                child: Image.asset("images/woodsaw.jpg"),
                                              )),
                                        ],
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(left:8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Text("wood saw dust",style:GoogleFonts.poppins(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w600)),
                                          ],
                                        ),
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top:30.0),
                                            child: Container(
                                              decoration:BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Color.fromARGB(255,54, 209, 220),
                                                      Color.fromARGB(150,91, 134, 229)
                                                      //add more colors
                                                    ]),
                                                borderRadius: BorderRadius.circular(15),
                                                //                   boxShadow: <BoxShadow>[
                                                //                   BoxShadow(
                                                //                   color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                                                // blurRadius: 5)]
                                              ),
                                              child: TextButton(
                                                onPressed: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TakePictureScreen(tar: "saw",cameras: widget.cameras,)));

                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 19.0),
                                                  child: Text("check",style:GoogleFonts.alef(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w500)),

                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  )),
                                ),
                              )
                            ],
                          ),
                          margin: EdgeInsets.all(8.0),
                        ),
                      ],
                    )


                    // Add more containers as needed
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
