
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone_app/consts.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        title: SvgPicture.asset("assets/ic_instagram.svg", color: primaryColor, height: 32,),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(MaterialCommunityIcons.facebook_messenger, color: primaryColor,),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        shape: BoxShape.circle
                      ),
                    ),
                    sizeHor(10),
                    Text("Username", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),)
                  ],
                ),
                Icon(Icons.more_vert, color: primaryColor,)
              ],
            ),
            sizeVer(10),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.30,
              color: secondaryColor,
            ),
            sizeVer(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite, color: primaryColor,),
                    sizeHor(10),
                    Icon(Feather.message_circle, color: primaryColor,),
                    sizeHor(10),
                    Icon(Feather.send, color: primaryColor,),
                  ],
                ),
                Icon(Icons.bookmark_border, color: primaryColor,)

              ],
            ),
            sizeVer(10),
            Row(
              children: [
                Text("Username", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),),
                sizeHor(10),
                Text("some description", style: TextStyle(color: primaryColor),),
              ],
            ),
            sizeVer(10),
            Text("View all 10 comments", style: TextStyle(color: darkGreyColor),),
            sizeVer(10),
            Text("08/5/2022", style: TextStyle(color: darkGreyColor),),

          ],
        ),
      ),
    );
  }
}
