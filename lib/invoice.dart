import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:number_to_words_english/number_to_words_english.dart';


import 'package:printing/printing.dart';
class InvoicePage extends StatefulWidget {
  InvoicePage({super.key,required this.dv,required this.lis});
  String dv;
  DocumentSnapshot lis;
  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  final pdf = pw.Document();
  List<List<dynamic>> orders=[];
  String add="";
  String ph="";
  String words="";
  @override
  initState() {

    var x=widget.lis["order"];
    words=NumberToWordsEnglish.convert((widget.lis["price"]+widget.lis["gst"]).toInt());
    for(int i=0;i<x.length;i++){
      orders.add([x[i.toString()][0].toString(),x[i.toString()][1].toString(),x[i.toString()][2],x[i.toString()][3].toString(),x[i.toString()][4],x[i.toString()][5]]);
    }
    get();
    super.initState();
  }

  void get()async{
    var x=await FirebaseFirestore.instance.collection("Customers").doc("customers").collection("customers").doc(widget.lis["cusid"]).get();
    add= x["street"]+","+x["city"].toString()+","+x["post"];
    ph=x["phone"];
  print(add);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice Generator'),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 200,left: 10),
              child: Text(
                'Generate Invoice!',
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 23),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Center(
            child:Container(
              child: TextButton(
                onPressed:(){
                  generateInvoice();
                },
                child: Container(
                  width: 150.0,
                  height: 110.0,
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
                              Text("Generate Invoice",style:GoogleFonts.poppins(color: Colors.black, fontSize: 15,)),
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
            ),
          ),
        ],
      ),
    );
  }

  Future<void> generateInvoice() async {
    final invoice = Invoice(
      type: widget.lis["ptype"],
      vno: widget.lis["vno"],
      number: widget.lis.id,
      date: DateTime.now(),
      items: [
        for(int i=0;i<orders.length;i++)
          InvoiceItem(
              number: (i+1).toString(),
              name: orders[i][0],
              HSN: orders[i][5],
              qty: int.parse(orders[i][1]),
              rate: double.parse(orders[i][4].toString()),
              GST: orders[i][2],
              price: int.parse(orders[i][1])*double.parse(orders[i][4].toString())
          ),

      ],
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => buildInvoice(invoice),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/invoice.pdf");
    await file.writeAsBytes(await pdf.save());

    Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  pw.Widget buildInvoice(Invoice invoice) {
    return pw.Container(
        decoration: pw.BoxDecoration(
            color: PdfColors.white,
            border: pw.Border.all(color: PdfColors.black),
            borderRadius: pw.BorderRadius.circular(5)
        ),
        padding: pw.EdgeInsets.all(0),
        child:pw.Padding(
          padding: pw.EdgeInsets.all(0),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                      padding: pw.EdgeInsets.all(5),
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text(
                              'Industry',
                              style: pw.TextStyle(
                                fontSize: 15,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 10),
                            pw.Text(
                                "Your residential address\n\n\n",style: pw.TextStyle(
                                fontSize: 10
                            )
                            ),

                          ]
                      ),
                    ),
                    pw.Container(
                        padding: pw.EdgeInsets.all(5),
                        child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.Text('Inovice No   : ${invoice.number.toString()}',style: pw.TextStyle(
                                  fontSize: 10
                              )),
                              pw.SizedBox(height: 10),
                              pw.Text('Date         : ${invoice.date.toString()}',style: pw.TextStyle(
                                  fontSize: 10
                              )),
                              pw.SizedBox(height: 10),
                              pw.Text('Inovice Type : ${invoice.type.toString()}',style: pw.TextStyle(
                                  fontSize: 10
                              )),
                              pw.SizedBox(height: 10),
                              pw.Text('Vehicle No   : ${invoice.vno.toString()}',style: pw.TextStyle(
                                  fontSize: 10
                              )),
                              pw.SizedBox(height: 10),
                            ]
                        )
                    )

                  ]
              ),
              pw.SizedBox(height: 20),
              pw.Container(
                padding: pw.EdgeInsets.all(5),
                decoration: pw.BoxDecoration(
                    border: pw.Border(top:pw.BorderSide(color: PdfColors.black) )
                ),
                child:  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text(
                              "BILLING ADDRESS",
                              style: pw.TextStyle(
                                fontSize: 15,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 10),
                            pw.Text(add),
                            pw.Text('Phone : ${ph}'),
                            pw.SizedBox(height: 20),
                          ]
                      ),

                      pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: [
                            pw.Text(
                              "SHIPPING ADDRESS",
                              style: pw.TextStyle(
                                fontSize:15,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.SizedBox(height: 10),
                            pw.Text(' '),
                            pw.Text(' '),
                            pw.SizedBox(height: 20),
                          ]
                      )
                    ]
                ),
              ),




              pw.SizedBox(height: 20),
              pw.Padding(
                  padding: pw.EdgeInsets.all(5),
                  child: pw.Text(
                    'Items',
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  )
              )
              ,
              pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.black),
                  children: [
                    pw.TableRow(
                        children: [

                          pw.Padding(
                            padding: pw.EdgeInsets.all(10),
                            child: pw.Text('${"S.No"}'),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(10),
                            child: pw.Text('${"Particulars"}'),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(10),
                            child: pw.Text('${"HSN"}'),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(10),
                            child: pw.Text('${"Qty"}'),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(10),
                            child: pw.Text('${"Rate"}'),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(10),
                            child: pw.Text('${"GST"}'),
                          ),
                          pw.Padding(
                            padding: pw.EdgeInsets.all(10),
                            child: pw.Text('${"Price"}'),
                          ),
                        ]
                    ),
                    for(int i=0;i<invoice.items.length;i++)
                      pw.TableRow(
                          children: [

                            pw.Padding(
                              padding: pw.EdgeInsets.all(10),
                              child: pw.Text('${invoice.items[i].number}'),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(10),
                              child: pw.Text('${invoice.items[i].name}'),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(10),
                              child: pw.Text('${invoice.items[i].HSN}'),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(10),
                              child: pw.Text('${invoice.items[i].qty}'),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(10),
                              child: pw.Text('${invoice.items[i].rate}'),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(10),
                              child: pw.Text('${invoice.items[i].GST}'),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(10),
                              child: pw.Text('${invoice.items[i].price}'),
                            ),
                          ]
                      )
                  ]
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.SizedBox(

                    ),
                    pw.Container(
                        padding: pw.EdgeInsets.only(right: 5),
                        child:pw.Row(
                            children: [
                              pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [

                                    pw.Text(
                                      'Total Amount Before Gst: ',
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.Text(
                                      'Add : SGST ',
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.Text(
                                      'Add : CGST ',
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.Text(
                                      'Roundoff ',
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.Text(
                                      'CR/DR NOTE ',
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),

                                    pw.Text(
                                      'Total Amount After Gst: ',
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ]
                              ),
                              pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [

                                    pw.Text(
                                      '${widget.lis["price"]}',
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.Text(
                                      '${widget.lis["gst"]/2}',
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.Text(
                                      '${0.0}',
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.Text(
                                      '${widget.lis["gst"]/2}',
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                    pw.Text(
                                      '${0.00}',
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),

                                    pw.Text(
                                      '${widget.lis["price"]+widget.lis["gst"]}',
                                      style: pw.TextStyle(
                                        fontSize: 12,
                                        fontWeight: pw.FontWeight.bold,
                                      ),
                                    ),
                                  ]
                              )
                            ]
                        )

                    )
                  ]
              ),
              pw.SizedBox(
                  height: 10
              ),
              pw.Container(
                  decoration: pw.BoxDecoration(
                      border: pw.Border.symmetric(horizontal: pw.BorderSide(color: PdfColors.black))
                  ),
                  child: pw.Row(
                      children: [
                        pw.Container(
                            padding: pw.EdgeInsets.symmetric(horizontal: 20),

                            child: pw.Text("${words} only")
                        )
                      ]
                  )
              ),
              pw.SizedBox(
                  height: 10
              ),
              pw.Container(
                  padding: pw.EdgeInsets.all(5),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [

                            ]
                        ),
                        pw.Column(
                            children: [
                              pw.Text("For Industry"),
                              pw.SizedBox(height: 25),
                              pw.Text("Authorized Signatory")
                            ]
                        )
                      ]
                  )
              )
            ],
          ),
        )

    );
  }
}




class Invoice {
  final String number;
  final DateTime date;
  final String vno;
  final String type;
  final List<InvoiceItem> items;

  Invoice({required this.number, required this.date, required this.items,required this.vno,required this.type});

  double calculateTotal() {
    double total = 0;
    for (var item in items) {
      total += item.price;
    }
    return total;
  }
}

class InvoiceItem {
  final String number;
  final String name;
  final int HSN;
  final int qty;
  final double rate;
  final String GST;
  final double price;

  InvoiceItem({
    required this.number,
    required this.name,
    required this.HSN,
    required this.qty,
    required this.rate,
    required this.GST,
    required this.price
  });
}