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
                GestureDetector(onTap: () {
                  _openBottomModalSheet(context);
                },child: Icon(Icons.more_vert, color: primaryColor,))
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
                    GestureDetector(onTap: () {
                      Navigator.pushNamed(context, PageConst.commentPage);
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                    },child: Icon(Feather.message_circle, color: primaryColor,)),
                    sizeHor(10),
                    Icon(Feather.send, color: primaryColor,),
                  ],
                ),
                Icon(Icons.bookmark_border, color: primaryColor,)

              ],
            ),
            sizeVer(10),
            Text("34 likes", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),),
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

  _openBottomModalSheet(BuildContext context) {
    return showModalBottomSheet(context: context, builder: (context) {
      return Container(
        height: 150,
        decoration: BoxDecoration(color: backGroundColor.withOpacity(.8)),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "More Options",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: primaryColor),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  thickness: 1,
                  color: secondaryColor,
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "Delete Post",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: primaryColor),
                  ),
                ),
                sizeVer(7),
                Divider(
                  thickness: 1,
                  color: secondaryColor,
                ),
                sizeVer(7),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, PageConst.updatePostPage);

                      // Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePostPage()));

                    },
                    child: Text(
                      "Update Post",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: primaryColor),
                    ),
                  ),
                ),
                sizeVer(7),
              ],
            ),
          ),
        ),
      );
    });
  }
}
