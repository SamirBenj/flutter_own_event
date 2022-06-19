import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/constants/fontsCustom.dart';
import 'package:flutter_own_event/functions/firebaseHelper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key, this.userData}) : super(key: key);
  final userData;
  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  bool switchValue = false;
  bool isFreeOrNot = false;
  String eventDate = '';
  String day = "";
  String month = "";
  late String _valueSelected = "Type d'Évenement";
  TextEditingController textEditingControllernNom = new TextEditingController();
  TextEditingController textEditingControllernDescr =
      new TextEditingController();
  TextEditingController textEditingControllerPrix = new TextEditingController();
  TextEditingController textEditingControllerNombrePersonne =
      new TextEditingController();
  TextEditingController textEditingControllerWebsite =
      new TextEditingController();
  TextEditingController textEditingControllerAdresse =
      new TextEditingController();
  late File image;
  final imagePicker = ImagePicker();
  List monthName = [
    'January',
    'February',
    'March',
    'April',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  Future getImagePic() async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = new File(pickedImage!.path);
      print('mon image' + image.toString());
    });

    // uploadPic(image, widget.userData);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return GestureDetector(
      onTapDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: PRIMARY_COLOR_LIGHT,
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: Text(
                      'MakeYourEvent 😃',
                      style: MONTSERRAT_BOLD_WHITE,
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      controller: textEditingControllernNom,
                      // scrollPadding: EdgeInsets.all(0),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: Icon(
                            Icons.title,
                            color: PRIMARY_COLOR,
                          ),
                          onPressed: () {
                            // setState(() {
                            //   searchText = searchTextController.text;
                            //   SystemChannels.textInput.invokeMethod('TextInput.hide');
                            // });
                          },
                          color: Colors.white,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        label: Text(
                          'Nom Évenenement . . . . .',
                          style: TextStyle(color: Colors.black),
                        ),
                        labelStyle: GoogleFonts.montserrat(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      controller: textEditingControllernDescr,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      maxLines: 5,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: Icon(
                            Icons.text_format,
                            color: PRIMARY_COLOR,
                          ),
                          onPressed: () {
                            // setState(() {
                            //   searchText = searchTextController.text;
                            //   SystemChannels.textInput.invokeMethod('TextInput.hide');
                            // });
                          },
                          color: Colors.white,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        label: Text('Description . . . . . . . '),
                        labelStyle: GoogleFonts.montserrat(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      controller: textEditingControllerAdresse,
                      // scrollPadding: EdgeInsets.all(0),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: Icon(
                            Icons.place,
                            color: PRIMARY_COLOR,
                          ),
                          onPressed: () {},
                          color: Colors.white,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        label: Text(
                          'Adresse ',
                          style: TextStyle(color: Colors.black),
                        ),
                        labelStyle: GoogleFonts.montserrat(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Date',
                              style: MONTSERRAT_LIGHT_WHITE,
                            ),
                            Text(
                              'PassSanitaire',
                              style: MONTSERRAT_LIGHT_WHITE,
                            ),
                            Text(
                              'Payant ?',
                              style: MONTSERRAT_LIGHT_WHITE,
                            ),
                            Text(
                              'Photo',
                              style: MONTSERRAT_LIGHT_WHITE,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(2020, 5, 5, 20, 50),
                                  maxTime: DateTime(2020, 6, 7, 05, 09),
                                  onChanged: (date) {
                                print('change $date in time zone ' +
                                    date.timeZoneOffset.inHours.toString());
                              }, onConfirm: (date) {
                                setState(() {
                                  eventDate = date.toString();
                                  day = date.day.toString();
                                  var monthNum = date.month;
                                  month = monthName[monthNum].toString();
                                });
                                print('confirm $date');
                              }, locale: LocaleType.fr);
                            },
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: PRIMARY_COLOR,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Icon(
                                  Icons.date_range,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Switch(
                              value: switchValue,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  switchValue = value;
                                });
                              }),
                          Switch(
                            value: isFreeOrNot,
                            onChanged: (value) {
                              isFreeOrNot = value;
                              setState(() {});
                            },
                            activeColor: Colors.green,
                          ),
                          Material(
                            borderRadius: BorderRadius.circular(20),
                            color: PRIMARY_COLOR,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: InkWell(
                                onTap: () {
                                  getImagePic();
                                },
                                child: Icon(
                                  Icons.add_a_photo_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            color: PRIMARY_COLOR,
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                ),
                                disabledHint: Text('hell'),
                                key: widget.key,
                                icon: Icon(
                                  Icons.arrow_drop_down_circle,
                                  color: Colors.white,
                                ),
                                dropdownColor: PRIMARY_COLOR,
                                style: MONTSERRAT_LIGHT_WHITE,
                                onChanged: (String? _newValue) {
                                  setState(() {
                                    _valueSelected = _newValue!;
                                  });
                                },
                                validator: (value) {
                                  print(value);
                                  if (value == "Type d'Évenement" ||
                                      value == null ||
                                      value.toString().isEmpty) {
                                    return 'Merci de choisir 😁';
                                  }
                                  return null;
                                },
                                value: _valueSelected,
                                items: [
                                  DropdownMenuItem(
                                    value: "Type d'Évenement",
                                    child: Text("Type Event"),
                                  ),
                                  DropdownMenuItem(
                                    value: 'CONCERT',
                                    child: Text('Concert'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'FESTIVAL',
                                    child: Text('Festival'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'SEMINAIRE',
                                    child: Text('Concert'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'CONFERENCE',
                                    child: Text('Conference'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'EXPOSITIONS',
                                    child: Text('Expositions'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: textEditingControllerWebsite,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          maxLines: 1,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            prefixIcon: IconButton(
                              icon: Icon(
                                Icons.price_change,
                                color: PRIMARY_COLOR,
                              ),
                              onPressed: () {
                                // setState(() {
                                //   searchText = searchTextController.text;
                                //   SystemChannels.textInput.invokeMethod('TextInput.hide');
                                // });
                              },
                              color: Colors.white,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            label: Text('Prix ?'),
                            labelStyle: GoogleFonts.montserrat(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    // width: 200,
                    // height: 50,
                    child: TextFormField(
                      controller: textEditingControllerNombrePersonne,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null) {
                          return 'Chiffre/Nombre Uniquement !';
                        }
                        return null;
                      },
                      // maxLines: 1,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          icon: Icon(
                            Icons.people,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                          color: Colors.white,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: PRIMARY_COLOR,
                        label: Text(
                          'Nombre de Personne',
                          style: MONTSERRAT_LIGHT_WHITE,
                        ),
                        labelStyle: GoogleFonts.montserrat(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('Publication en cours....')),
                        );
                        // String fileName = image.path.toString();
                        // print(fileName);
                        // if (image.toString() == "") {
                        //   print('hello image not null');
                        // } else {
                        //   print('is  null');
                        FirebaseHelper().createPost(
                          image,
                          textEditingControllernNom.text.toString(),
                          textEditingControllernDescr.text.toString(),
                          eventDate.toString(),
                          textEditingControllerPrix.text.toString(),
                          isFreeOrNot,
                          textEditingControllerNombrePersonne.text.toString(),
                          _valueSelected.toString(),
                          textEditingControllerAdresse.text.toString(),
                          day,
                          month,
                        );
                        setState(() {
                          textEditingControllernNom.text = "";
                          textEditingControllernDescr.text = "";
                          textEditingControllerPrix.text = "";
                          textEditingControllerNombrePersonne.text = "";
                          textEditingControllerAdresse.text = "";
                        });
                        FocusScope.of(context).unfocus();
                        // }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: PRIMARY_COLOR,
                    ),
                    icon: Icon(
                      Icons.publish,
                    ),
                    label: Text(
                      'PUBLIER',
                      style: MONTSERRAT_BOLD_WHITE,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
