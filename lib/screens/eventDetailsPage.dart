import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/constants/fontsCustom.dart';
import 'package:flutter_own_event/screens/paymentScreen.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:pay/pay.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sizer/sizer.dart';
// import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class EventDetailsPage extends StatefulWidget {
  const EventDetailsPage({
    Key? key,
    required this.date,
    required this.description,
    required this.nomEvenement,
    required this.payant,
    required this.prix,
    required this.postPicture,
    required this.username,
    required this.docId,
    required this.eventDay,
    required this.eventMonth,
    required this.nbPers,
    required this.adress,
  }) : super(key: key);
  final String date;
  final String description;
  final String nomEvenement;
  final bool payant;
  final String prix;
  final String postPicture;
  final String username;
  final String docId;
  final String eventDay;
  final String eventMonth;
  final String nbPers;
  final String adress;

  @override
  State<EventDetailsPage> createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  static bool anOtherMenuActive = false; // out of build
  late FToast fToast;
  final GlobalKey key = GlobalKey();
  var userData;
  var long;
  var lat;

  @override
  void initState() {
    FirebaseFirestore.instance;
    // TODO: implement initState
    super.initState();
    fToast = FToast();

    fToast.init(context);
    userData = FirebaseAuth.instance.currentUser;
    getCoordinates();
  }

  final bool showQrCode = false;
  getCoordinates() async {
    print(widget.adress.toString());
    try {
// From a query
      final query = "1600 Amphiteatre Parkway, Mountain View";
      List<Location> locations =
          await locationFromAddress("Gronausestraat 710, Enschede");
      print(locations.map((e) {
        lat = e.latitude;
        long = e.longitude;
        setState(() {});
      }));
    } catch (e) {
      print(e);
    }
    print('test');
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            true;
            break;
          case ScrollDirection.reverse:
            false;
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  final _paymentItems = [
    PaymentItem(
      label: 'Total',
      amount: '99.99',
      status: PaymentItemStatus.final_price,
    )
  ];
  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        // key: key,
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          title: Text('DETAILS'),
          toolbarHeight: 6.h,
        ),
        backgroundColor: PRIMARY_COLOR_LIGHT,
        body: SingleChildScrollView(
          child: Column(
            children: [
              FancyShimmerImage(
                width: double.infinity,
                height: 20.h,
                boxFit: BoxFit.cover,
                imageUrl:
                    "https://i1.adis.ws/i/canon/canon-get-inspired-party-1-1920?qlt=80&w=100%&sm=aspect&aspect=16:9&fmt=jpg&fmt.options=interlaced&bg=rgb(255,255,255)",
                errorWidget: Image.network(
                    'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 1.5.h),
                child: Text(
                  widget.nomEvenement.toString(),
                  style: MONTSERRAT_BOLD_WHITE,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 2.5.h, vertical: 2.0.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Date & Heure',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 18,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: Offset(6, 7),
                                blurRadius: 10,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.0.h, vertical: 2.0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Text(
                          //   'Samedi 20 Janvier 22H00',
                          //   style: MONTSERRAT_LIGHT_WHITE,
                          // ),
                          Text(
                            widget.date.toString(),
                            style: MONTSERRAT_LIGHT_WHITE,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 18,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: Offset(6, 7),
                                blurRadius: 10,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.0.h, vertical: 2.0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                widget.description.toString(),
                                style: MONTSERRAT_LIGHT_WHITE,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Localisation',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 18,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: Offset(6, 7),
                                blurRadius: 10,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.0.h, vertical: 2.0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(),
                            width: 200,
                            height: 130,
                            child: FlutterMap(
                              options: MapOptions(
                                center: LatLng(51.5, -0.09),
                                zoom: 15.0,
                              ),
                              layers: [
                                TileLayerOptions(
                                  urlTemplate:
                                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                  subdomains: ['a', 'b', 'c'],
                                  attributionBuilder: (_) {
                                    return Text("© OpenStreetMap contributors");
                                  },
                                ),
                                MarkerLayerOptions(
                                  markers: [
                                    Marker(
                                      width: 80.0,
                                      height: 80.0,
                                      point: LatLng(51.5, -0.09),
                                      builder: (ctx) => Container(
                                        child: Icon(
                                          Icons.place,
                                          color: PRIMARY_COLOR,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Material(
                          color: PRIMARY_COLOR,
                          borderRadius: BorderRadius.circular(15),
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.w),
                          child: Text(
                            widget.nbPers.toString(),
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 18,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset(6, 7),
                                  blurRadius: 10,
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.h),
                          child: Text(
                            'Pers',
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                fontSize: 18,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: Offset(6, 7),
                                    blurRadius: 10,
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Pass Sanitaire',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 18,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: Offset(6, 7),
                                blurRadius: 10,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'OUI',
                            style: MONTSERRAT_LIGHT_WHITE,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0.0, bottom: 30.0),
                child: GooglePayButton(
                  width: 300,
                  height: 60,
                  paymentConfigurationAsset: 'gpay.json',
                  onPaymentResult: onGooglePayResult,
                  paymentItems: _paymentItems,
                  style: GooglePayButtonStyle.white,
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  margin: const EdgeInsets.only(top: 15.0),
                ),
              ),
              // QrImage(
              //   data: userData.uid +
              //       DateTime.now().microsecondsSinceEpoch.toString() +
              //       userData.displayName,
              //   version: QrVersions.auto,
              //   size: 200.0,
              // ),

              Padding(
                padding: const EdgeInsets.only(top: 0.0, bottom: 30.0),
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.payment_sharp,
                    size: 20,
                    color: PRIMARY_COLOR,
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 5.0,
                    primary: Colors.white,
                    padding: EdgeInsets.only(
                      left: 5.w,
                      right: 5.w,
                      top: 2.h,
                      bottom: 2.h,
                    ),
                  ),
                  onPressed: () async {
                    print('pressed');
                    // try {
                    //   final RenderRepaintBoundary boundary = key.currentContext!
                    //       .findRenderObject()! as RenderRepaintBoundary;

                    //   final ui.Image image = await boundary.toImage();
                    //   final ByteData? byteData = await image.toByteData(
                    //       format: ui.ImageByteFormat.png);
                    //   final Uint8List pngBytes = byteData!.buffer.asUint8List();
                    //   // print(pngBytes);
                    //   FirebaseStorage.instance.ref('QrCode').putData(pngBytes);
                    //   fToast.showToast(
                    //     child: Container(
                    //       padding: EdgeInsets.all(20),
                    //       decoration: BoxDecoration(
                    //           color: PRIMARY_COLOR,
                    //           borderRadius: BorderRadius.circular(20)),
                    //       child: Center(
                    //         child: Text(
                    //           'Votre paiment à était effectué',
                    //           style: TextStyle(
                    //             fontWeight: FontWeight.bold,
                    //             color: Colors.white,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   );
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PaymentScreen(eventTitle: widget.nomEvenement)),
                        (route) => false);
                    // } catch (e) {
                    //   print(e.toString());
                    // }
                  },
                  label: Text(
                    'Test',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: PRIMARY_COLOR,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
