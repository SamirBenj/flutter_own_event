import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_own_event/constants/colors.dart';
import 'package:flutter_own_event/constants/fontsCustom.dart';
import 'package:flutter_own_event/screens/eventDetailsPage.dart';
import 'package:flutter_own_event/widgets/bottomSheetComment.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sizer/sizer.dart';

class UserPostWidget extends StatefulWidget {
  const UserPostWidget({
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
  });
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
  State<UserPostWidget> createState() => _UserPostWidgetState();
}

class _UserPostWidgetState extends State<UserPostWidget> {
  bool isReadmore = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  child: CircleAvatar(
                      radius: 20,
                      backgroundColor: PRIMARY_COLOR,
                      child: FancyShimmerImage(
                        imageUrl: AVATAR_TEST,
                        boxFit: BoxFit.cover,
                      )),
                ),
                Text(
                  widget.username,
                  style: MONTSERRAT_LIGHT,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.nomEvenement,
              style: MONTSERRAT_BOLD_PRIMARY_COLOR,
            ),
          ),
          Stack(
            alignment: Alignment.topRight,
            children: [
              FancyShimmerImage(
                width: double.infinity,
                height: 30.h,
                boxFit: BoxFit.cover,
                // imageUrl:
                //     "https://i1.adis.ws/i/canon/canon-get-inspired-party-1-1920?qlt=80&w=100%&sm=aspect&aspect=16:9&fmt=jpg&fmt.options=interlaced&bg=rgb(255,255,255)",
                imageUrl: widget.postPicture,
                errorWidget: Image.network(
                    'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),

                // shimmerBaseColor: Colors.red,
                // shimmerDuration: Duration(seconds: 3),

                // shimmerHighlightColor: randomColor(),
                // shimmerBackColor: randomColor(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 8.w),
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.eventDay.toString(),
                        style: MONTSERRAT_BOLD_WHITE,
                      ),
                      Text(
                        widget.eventMonth.toString(),
                        style: MONTSERRAT_LIGHT_WHITE,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Image.network(
          //   "https://www.aphp.fr/sites/default/files/styles/grande_image_896_x_504/public/concert.jpg?itok=2fdSXurJ",
          // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.username,
                  style: MONTSERRAT_LIGHT,
                ),
                SizedBox(
                  width: 1.h,
                ),
                Text(
                  "il y'a 10 minutes",
                  style: MONTSERRAT_LIGHT_GREEN,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.h),
            child: InkWell(
              onTap: () {
                setState(() {
                  isReadmore = !isReadmore;
                });
              },
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 300,
                        child: Text(
                          widget.description.toString(),
                          textAlign: TextAlign.start,
                          maxLines: isReadmore ? 2 : 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.h, vertical: 1.0.h),
                        child: Text(
                          isReadmore ? 'Voir Plus' : 'Voir Moins',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 2.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Ionicons.heart_circle_sharp,
                  color: PRIMARY_COLOR,
                  size: 10.w,
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        useRootNavigator: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        )),
                        context: context,
                        builder: (context) =>
                            BottomSheetCommentSection(docId: widget.docId));
                  },
                  child: Icon(
                    Ionicons.chatbox,
                    color: Colors.red,
                    size: 10.w,
                  ),
                ),
                InkWell(
                  onTap: () {
                    FlutterShare.share(
                      title: widget.nomEvenement,
                      text: widget.description,
                    );
                  },
                  child: Icon(
                    Ionicons.share_social,
                    size: 10.w,
                    color: PRIMARY_COLOR,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: PRIMARY_COLOR,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailsPage(
                    date: widget.date,
                    description: widget.description,
                    nomEvenement: widget.nomEvenement,
                    payant: widget.payant,
                    prix: widget.prix,
                    postPicture: widget.postPicture,
                    username: widget.username,
                    docId: widget.docId,
                    eventDay: widget.eventDay,
                    eventMonth: widget.eventMonth,
                    nbPers: widget.nbPers,
                    adress: widget.adress,
                  ),
                ),
              );
            },
            child: Text(
              'Participer',
              style: MONTSERRAT_BOLD_WHITE,
            ),
          )
        ],
      ),
    );
  }
}
