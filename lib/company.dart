import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventorymanagement/main.dart';
import 'package:inventorymanagement/presistant.dart';
class Company extends StatefulWidget {
  List<CameraDescription>? cameras;
  Company({Key? key,required this.cameras}) : super(key: key);

  @override
  State<Company> createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  List<String> buttons = ['Button 1', 'Button 2', 'Button 3'];
  String dropdownValue = "Company 1";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: ()async=>false,
      child: Scaffold(
        body: Container(

          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 200,left: 80),
                    child: Icon(Icons.data_exploration,color: Colors.deepPurple,size: 50,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'inven',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'EX',
                          style: GoogleFonts.poppins(
                              color: Colors.blueAccent,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'pert',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20,left: 10),
                child: Text(
                  'Select Company!',
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 23),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,top: 20,right: 20),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder( //<-- SEE HERE
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    focusedBorder: OutlineInputBorder( //<-- SEE HERE
                      borderSide: BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(15)
                    ),

                    fillColor: Colors.greenAccent,
                  ),

                  // dropdownColor: Colors.grey,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black),
                  value: dropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: <String>['Company 1','Company 2'].map<DropdownMenuItem<String>>((String value) {
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
                  padding: EdgeInsets.only(
                    top: 20,
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(

                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                      padding: MaterialStateProperty.all(EdgeInsets.only(
                          top: 15, bottom: 15, right: 130, left: 130)),
                      backgroundColor: MaterialStateProperty.all(Colors.purple),
                    ),
                    child: Text(
                      'Done',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () async{
                        print(dropdownValue);
                        if(dropdownValue!=""){
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>  MyHomePage1(dropdownValue: dropdownValue.toString(),cameras: widget.cameras,),
                          ),
                        );
                      }
                        }

                  )),
            ],
          ),
        ),
      ),
    );
  }
}
