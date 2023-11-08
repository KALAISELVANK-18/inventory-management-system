import 'package:flutter/material.dart';
import 'package:inventorymanagement/company.dart';
import 'package:inventorymanagement/presistant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventorymanagement/signup.dart';
import 'connect.dart';
import 'main.dart';


class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  MongoDatabasee obj=new MongoDatabasee();
  @override
  Widget build(BuildContext context) {
    TextEditingController email=new TextEditingController();
    TextEditingController pass=new TextEditingController();
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                    height: 200,
                    width: 200,
                    child: Image.asset('images/inventory.jpg')),
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'inven',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'EX',
                        style: GoogleFonts.poppins(
                            color: Colors.blueAccent,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'pert',
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                'Welcome back Again!',
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 23),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Enter Email'),
                )),
            Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFormField(
                  controller: pass,
                  decoration: InputDecoration(
                      filled: true, //<-- SEE HERE
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Enter Password'),
                )),
            Padding(
              padding: EdgeInsets.only(left: 220, top: 10),
              child: Text('Recovery Password',
                  style: GoogleFonts.poppins(
                      fontSize: 14, color: Colors.blueAccent)),
            ),
            Padding(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    padding: MaterialStateProperty.all(EdgeInsets.only(
                        top: 15, bottom: 15, right: 130, left: 130)),
                    backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async{
                    String vv=await obj.zz(email.text,pass.text);
                    if(vv=="success")
                    {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>Company(cameras: cameras,),
                        ),
                      );
                    }

                  },
                )),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Or continue with',
                style: GoogleFonts.poppins(fontSize: 15, color: Colors.white),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.only(top: 20),
            //       //child: Image.asset('assets/gg.png'),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.only(top: 20),
            //       //child: Image.asset('assets/apple.png'),
            //     ),
            //     Padding(
            //       padding: EdgeInsets.only(top: 20),
            //       //child: Image.asset('assets/fb.png'),
            //     ),
            //   ],
            // ),

            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Center(

                  child: Padding(

                    padding: EdgeInsets.only(top: 2),
                    child: Row(
                      children: [
                        Text('Not a user',
                            style: GoogleFonts.poppins(fontSize: 15, color: Colors.black)),
                        TextButton(onPressed:(){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Signup(),
                            ),
                          );
                        },
                          child: Text('Signup here',
                            style: GoogleFonts.poppins(fontSize: 17, color: Colors.deepPurpleAccent,fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ]),
        ),
      ),
    );
  }
}
