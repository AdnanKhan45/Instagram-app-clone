
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/consts.dart';
import 'package:instagram_clone_app/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone_app/features/domain/usecases/firebase_usecases/user/get_single_user_usecase.dart';
import 'package:instagram_clone_app/profile_widget.dart';
import 'package:instagram_clone_app/injection_container.dart' as di;

class FollowingPage extends StatelessWidget {
  final UserEntity user;
  const FollowingPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        title: Text("Following"),
        backgroundColor: backGroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          children: [
            Expanded(
              child: user.following!.isEmpty? _noFollowersWidget() :  ListView.builder(itemCount: user.following!.length,itemBuilder: (context, index) {
                return StreamBuilder<List<UserEntity>>(
                  stream: di.sl<GetSingleUserUseCase>().call(user.following![index]),
                  builder: (context, snapshot) {
                    if (snapshot.hasData == false) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.data!.isEmpty) {
                      return Container();
                    }
                    final singleUserData = snapshot.data!.first;
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PageConst.singleUserProfilePage, arguments: singleUserData.uid);

                      },
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: 40,
                            height: 40,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: profileWidget(imageUrl: singleUserData.profileUrl),
                            ),
                          ),
                          sizeHor(10),
                          Text("${singleUserData.username}", style: TextStyle(color: primaryColor, fontSize: 15, fontWeight: FontWeight.w600),)
                        ],
                      ),
                    );
                  }
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  _noFollowersWidget() {
    return Center(
      child: Text("No Following", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
    );
  }
}
