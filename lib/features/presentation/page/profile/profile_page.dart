
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/consts.dart';

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
            child: Icon(Icons.menu, color: primaryColor,),
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
}
