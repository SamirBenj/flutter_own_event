import 'package:flutter/material.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/constants/fontsCustom.dart';

class SelectionEventType extends StatefulWidget {
  SelectionEventType({
    Key? key,
  }) : super(key: key);
  @override
  State<SelectionEventType> createState() => _SelectionEventTypeState();
}

class _SelectionEventTypeState extends State<SelectionEventType> {
  late String _valueSelected = "Type d'Évenement";
  @override
  Widget build(BuildContext context) {
    return Material(
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
              borderSide: BorderSide(color: Colors.transparent),
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
          },
          value: _valueSelected,
          items: [
            DropdownMenuItem(
              value: "Type d'Évenement",
              child: Text("Type d'Évenement"),
            ),
            DropdownMenuItem(
              value: 'Concert',
              child: Text('Concert'),
            ),
          ],
        ),
      ),
    );
  }
}
