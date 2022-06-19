import 'package:animated_check/animated_check.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/constants/fontsCustom.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

class VerifieQrCodeScreen extends StatefulWidget {
  VerifieQrCodeScreen({Key? key}) : super(key: key);

  @override
  State<VerifieQrCodeScreen> createState() => _VerifieQrCodeScreenState();
}

class _VerifieQrCodeScreenState extends State<VerifieQrCodeScreen>
    with SingleTickerProviderStateMixin {
  bool showStreamBuilder = true;
  String qrCodeResult = "";
  var user;

  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    _animation = new Tween<double>(begin: 0, end: 1).animate(
        new CurvedAnimation(
            parent: _animationController, curve: Curves.easeInOutCirc));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: Text(
          'Verfication QRCodes',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Expanded(
          //   flex: 1,
          //   child: QRCodeDartScanView(
          //     widthPreview: double.infinity,
          //     heightPreview: 500,
          //     typeCamera: TypeCamera.back,
          //     scanInvertedQRCode: true,
          //     resolutionPreset: QRCodeDartScanResolutionPreset.high,
          //     formats: const [
          //       BarcodeFormat.QR_CODE,
          //     ],
          //     onCapture: (Result result) {
          //       print(result.text.toString());
          //       if (result.text != "") {
          //         print('qr code repérer');

          //         showStreamBuilder = true;
          //         qrCodeResult = result.text.toString();
          //         setState(() {});
          //       }
          //       // setState(() {
          //       //   showStreamBuilder = true;
          //       //   qrCodeResult =
          //       //       result.text.toString();
          //       // });
          //     },
          //   ),
          // ),
          // Text('edejk'),
          // showStreamBuilder
          //     ?
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('AllQRCodes')
                .where('uniqueCode', isEqualTo: 'qrCodeResult.toString()')
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // print(snapshot.data());
              print('QRCODE RESULT' + qrCodeResult.toString());
              if (!snapshot.hasData) {
                print('searching');

                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                ));
              } else {
                print('data found');
                // void _showCheck() {
                // _animationController.forward();
// }
                // return Icon(Icons.verified);
                return snapshot.data.docs.map((e) => {Text('')});
              }
            },
          )
          // : Padding(
          //     padding: const EdgeInsets.only(bottom: 60.0),
          //     child: Text(
          //       'Veuillez scanner',
          //       style: MONTSERRAT_BOLD_PRIMARY_COLOR,
          //     ),
          //   ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showStreamBuilder = false;
          qrCodeResult = "";
          setState(() {});
        },
        label: Icon(
          Icons.refresh,
        ),
      ),
    );
  }
}
