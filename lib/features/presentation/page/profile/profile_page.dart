
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/consts.dart';
import 'package:instagram_clone_app/features/presentation/page/profile/edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        title: Text("Username", style: TextStyle(color: primaryColor),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
            onTap: () {
              _openBottomModalSheet(context);
            },child: Icon(Icons.menu, color: primaryColor,)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      shape: BoxShape.circle
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text("0", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),),
                          sizeVer(8),
                         Text("Posts", style: TextStyle(color: primaryColor),)
                        ],
                      ),
                      sizeHor(25),
                      Column(
                        children: [
                          Text("54", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),),
                          sizeVer(8),
                          Text("Followers", style: TextStyle(color: primaryColor),)
                        ],
                      ),
                      sizeHor(25),
                      Column(
                        children: [
                          Text("123", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),),
                          sizeVer(8),
                          Text("Following", style: TextStyle(color: primaryColor),)
                        ],
                      )
                    ],
                  )
                ],
              ),
              sizeVer(10),
              Text("Name", style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),),
              sizeVer(10),
              Text("The bio of user", style: TextStyle(color: primaryColor),),
              sizeVer(10),
              GridView.builder(itemCount: 32, physics: ScrollPhysics(), shrinkWrap: true,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5), itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  height: 100,
                  color: secondaryColor,
                );
              })
            ],
          ),
        ),
      )
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, PageConst.editProfilePage);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                    },
                    child: Text(
                      "Edit Profile",
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: primaryColor),
                    ),
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
                  child: Text(
                    "Logout",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: primaryColor),
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
