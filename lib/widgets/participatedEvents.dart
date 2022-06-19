import 'package:flutter/material.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/constants/fontsCustom.dart';

class ParticipatedEvents extends StatelessWidget {
  const ParticipatedEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(20),
              color: PRIMARY_COLOR,
              child: ListTile(
                trailing: Icon(
                  Icons.check,
                  color: Colors.green,
                ),
                title: Text(
                  'Titre Évenement',
                  style: MONTSERRAT_BOLD_WHITE,
                ),
                subtitle: Text(
                  'PARTICPÉ',
                  style: MONTSERRAT_LIGHT_WHITE,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
