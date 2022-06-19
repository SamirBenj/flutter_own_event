import 'dart:io';

import 'package:ai_barcode/ai_barcode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_own_event/constants/fontsCustom.dart';
import 'package:flutter_own_event/screens/verifieQrCode.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../constants/colors.dart';
import 'loginScreen.dart';

class QrCodeListScreen extends StatefulWidget {
  const QrCodeListScreen({Key? key}) : super(key: key);

  @override
  State<QrCodeListScreen> createState() => _QrCodeListScreenState();
}

class _QrCodeListScreenState extends State<QrCodeListScreen> {
  var user;
  bool isAdmin = false;
  late final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // Barcode? result;
  // QRViewController? controller;
  // late ScannerController scannerController;
  // @override
  // void reassemble() {
  //   super.reassemble();
  //   if (Platform.isAndroid) {
  //     scannerController.startCamera();
  //   } else if (Platform.isIOS) {
  //     scannerController.startCamera();
  //   }
  // }
  bool showStreamBuilder = true;
  String qrCodeResult = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // scannerController = ScannerController(scannerResult: (r) => print(r));
    // // reassemble();
    // Future.delayed(Duration(seconds: 2))
    //     .whenComplete(() => scannerController.startCamera());

    user = FirebaseAuth.instance.currentUser;
  }

  checkAdmin() async {
    if (user.uid == "8TA0lUUjEvSVh5bPUXtOrjeEosJ2") {
      isAdmin = true;
    } else {
      isAdmin = false;
    }
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   // this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     setState(() {
  //       result = scanData;
  //       print(result);
  //     });
  //   });
  // }

  @override
  void dispose() {
    // controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      appBar: AppBar(
        leading: isAdmin
            ? null
            : GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VerifieQrCodeScreen(),
                    ),
                  );
                  // showDialog(
                  //     barrierDismissible: true,
                  //     context: context,
                  //     builder: (context) {
                  //       return Center(
                  //         child: Container(
                  //           color: Colors.white,
                  //           // height: 200,
                  //           // width: 200,
                  //           child: Column(
                  //             children: [
                  //               TextButton(
                  //                 child: Text('Start camera'),
                  //                 onPressed: () async {
                  //                   print('hello');

                  //                   // scannerController.startCamera();
                  //                 },
                  //               ),
                  //               // Container(
                  //               //   color: Colors.black26,
                  //               //   width: 400,
                  //               //   height: 400,
                  //               //   child: PlatformAiBarcodeScannerWidget(
                  //               //     platformScannerController:
                  //               //         scannerController,
                  //               //   ),
                  //               // ),
                  //               Container(
                  //                 color: Colors.black26,
                  //                 width: double.infinity,
                  //                 height: 600,
                  //                 child: Column(
                  //                   children: [
                  //                     Expanded(
                  //                       child: QRCodeDartScanView(
                  //                         typeCamera: TypeCamera.back,
                  //                         scanInvertedQRCode: true,
                  //                         resolutionPreset:
                  //                             QRCodeDartScanResolutionPreset
                  //                                 .ultraHigh,
                  //                         formats: const [
                  //                           BarcodeFormat.QR_CODE,
                  //                         ],
                  //                         onCapture: (Result result) {
                  //                           print(result.text.toString());
                  //                           if (result.text != "") {
                  //                             print('found it');

                  //                             showStreamBuilder = true;
                  //                             qrCodeResult =
                  //                                 result.text.toString();
                  //                             setState(() {});
                  //                           }
                  //                           // setState(() {
                  //                           //   showStreamBuilder = true;
                  //                           //   qrCodeResult =
                  //                           //       result.text.toString();
                  //                           // });
                  //                         },
                  //                       ),
                  //                     ),
                  //                     Text('edejk'),
                  //                     showStreamBuilder
                  //                         ? Text('found it')
                  //                         //  StreamBuilder(
                  //                         //     stream: FirebaseFirestore.instance
                  //                         //         .collection('AllQRCodes')
                  //                         //         .where('uniqueCode',
                  //                         //             isEqualTo: qrCodeResult
                  //                         //                 .toString())
                  //                         //         .snapshots(),
                  //                         //     builder: (BuildContext context,
                  //                         //         AsyncSnapshot snapshot) {
                  //                         //       return ListView.builder(
                  //                         //         itemCount:
                  //                         //             snapshot.data.docs.length,
                  //                         //         itemBuilder:
                  //                         //             (BuildContext context,
                  //                         //                 int index) {
                  //                         //           return Text('found it');
                  //                         //         },
                  //                         //       );
                  //                         //     },
                  //                         //   )
                  //                         : Text('no data'),
                  //                   ],
                  //                 ),
                  //               ),
                  //               // Expanded(
                  //               //   flex: 5,
                  //               //   child: QRView(
                  //               //     key: qrKey,
                  //               //     onQRViewCreated: _onQRViewCreated,
                  //               //   ),
                  //               // ),
                  //               // Expanded(
                  //               //   flex: 1,
                  //               //   child: Center(
                  //               //     child: (result != null)
                  //               //         ? Text(
                  //               //             'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  //               //         : Text('Scan a code'),
                  //               //   ),
                  //               // ),
                  //             ],
                  //           ),
                  //         ),
                  //       );
                  //     });
                },
                child: Icon(Icons.qr_code_scanner),
              ),
        actions: [
          IconButton(
              onPressed: () {
                // FirebaseAuth.instance.signOut();
                // checkIfLoggedIn();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                    (route) => false);
              },
              icon: Icon(Icons.logout_outlined))
        ],
        title: Text('Vos QRCode'),
        backgroundColor: PRIMARY_COLOR_LIGHT,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(user.uid.toString())
                  .collection('MesQrCode')
                  .snapshots(),
              // initialData: initialData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.data?.size == 0) {
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    var url = snapshot.data.docs[index]['urlQr'].toString();
                    var eventTitle =
                        snapshot.data.docs[index]['eventTitle'].toString();

                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 8.0,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30.0),
                              child: Image.network(url),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 30.0),
                              child: Text(
                                eventTitle.toString(),
                                style: MONTSERRAT_BOLD_PRIMARY_COLOR,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
