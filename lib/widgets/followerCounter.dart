import 'package:flutter/material.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/constants/fontsCustom.dart';

class FollowerCounter extends StatelessWidget {
  const FollowerCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 60.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: PRIMARY_COLOR,
          elevation: 2.0,
          borderRadius: BorderRadius.circular(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '213',
                      style: MONTSERRAT_BOLD_WHITE,
                    ),
                    Text(
                      'Events',
                      style: MONTSERRAT_LIGHT_WHITE,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '1.5M',
                      style: MONTSERRAT_BOLD_WHITE,
                    ),
                    Text(
                      'Following',
                      style: MONTSERRAT_LIGHT_WHITE,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '300',
                      style: MONTSERRAT_BOLD_WHITE,
                    ),
                    Text(
                      'Following',
                      style: MONTSERRAT_LIGHT_WHITE,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
