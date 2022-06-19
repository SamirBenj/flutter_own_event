import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/constants/fontsCustom.dart';
import 'package:flutter_own_event/navigationsBar/naviagationBar.dart';
import 'package:flutter_own_event/screens/splashScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key, required this.eventTitle}) : super(key: key);
  final String eventTitle;
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final ConfettiController _controllerCenter;

  final GlobalKey key = GlobalKey();
  late FToast fToast;
  var userdata;
  saveQrCode() async {
    print('pressed');
    // try {
    final RenderRepaintBoundary boundary =
        key.currentContext?.findRenderObject() as RenderRepaintBoundary;

    final ui.Image image = await boundary.toImage();
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    // print(pngBytes);
    print(userdata.email);
    Reference reference = await FirebaseStorage.instance
        .ref('Users')
        .child(userdata.email)
        .child('QrCode')
        .child(DateTime.now().millisecondsSinceEpoch.toString() +
            userdata.displayName.toString());

    UploadTask uploadTask = reference.putData(pngBytes);
    await uploadTask.whenComplete(() async {
      String urlImage = await uploadTask.snapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userdata.uid)
          .collection('MesQrCode')
          .add({
        'username': userdata.displayName,
        'urlQr': urlImage,
        'eventTitle': widget.eventTitle,
      });
      await FirebaseFirestore.instance.collection('AllQRCodes').add({
        'username': userdata.displayName,
        'urlQr': urlImage,
        'eventTitle': widget.eventTitle,
        'uniqueCode': DateTime.now().microsecondsSinceEpoch.toString() +
            userdata.displayName.toString(),
      });
    });

    fToast.showToast(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: PRIMARY_COLOR, borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            'Votre paiment à était effectué',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => PaymentScreen(
                  eventTitle: widget.eventTitle,
                )),
        (route) => false);
    // } catch (e) {
    //   print(e.toString());
    // }
  }

  @override
  void initState() {
    fToast = FToast();
    userdata = FirebaseAuth.instance.currentUser;
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenter.play();
    super.initState();
    print(userdata);
    // saveQrCode();
    Future.delayed(Duration(seconds: 1)).whenComplete(() => saveQrCode());
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: Text('PAIMENT'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            child: ConfettiWidget(
              confettiController: _controllerCenter,
              // blastDirection: pi, // radial value - LEFT
              particleDrag: 0.05, // apply drag to the confetti
              emissionFrequency: 0.05, // how often it should emit
              numberOfParticles: 20, // number of particles to emit
              gravity: 0.05, // gravity - or fall speed
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink
              ], // manually specify the colors to be used
              strokeWidth: 1,
              strokeColor: Colors.white,
            ),
          ),
          Text(
            'Votre QRCode !',
            style: MONTSERRAT_BOLD_WHITE,
          ),
          Center(
            child: RepaintBoundary(
              key: key,
              child: Container(
                width: 150,
                height: 150,
                child: SfBarcodeGenerator(
                  value: DateTime.now().microsecondsSinceEpoch.toString() +
                      userdata.displayName.toString(),
                  symbology: QRCode(),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => {
              // saveQrCode(),
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => NavigationBottomBar(),
                ),
              )
            },
            child: Container(
              width: 130,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'ACCUEIL',
                    style: MONTSERRAT_LIGHT_WHITE,
                  ),
                  Icon(
                    Icons.arrow_circle_right,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
