import 'package:flutter/material.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/constants/fontsCustom.dart';
import 'package:flutter_own_event/screens/category.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class CategoryList extends StatefulWidget {
  CategoryList({Key? key}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List test = ['CONCERT', 'FESTIVAL', 'SEMINAIRE', 'CONFERENCE', 'EXPOSITIONS'];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10.h,
      child: ListView.builder(
          physics: ScrollPhysics(parent: BouncingScrollPhysics()),
          shrinkWrap: true,
          itemCount: test.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            print(test[index]);
            return GestureDetector(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryScreen(
                      title: test[index],
                    ),
                  ),
                )
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: PRIMARY_COLOR,
                  elevation: 10.0,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.w),
                    // margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          test[index],
                          style: GoogleFonts.montserrat(
                            color: PRIMARY_COLOR,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.festival_sharp,
                          color: PRIMARY_COLOR,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
