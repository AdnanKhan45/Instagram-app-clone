
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone_app/consts.dart';
import 'package:instagram_clone_app/features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone_app/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone_app/features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:instagram_clone_app/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:instagram_clone_app/features/presentation/cubit/post/post_cubit.dart';
import 'package:instagram_clone_app/features/presentation/cubit/user/get_single_other_user/get_single_other_user_cubit.dart';
import 'package:instagram_clone_app/features/presentation/cubit/user/get_single_user/get_single_user_cubit.dart';
import 'package:instagram_clone_app/features/presentation/cubit/user/user_cubit.dart';
import 'package:instagram_clone_app/features/presentation/widgets/button_container_widget.dart';
import 'package:instagram_clone_app/profile_widget.dart';
import 'package:instagram_clone_app/injection_container.dart' as di;
class SingleUserProfileMainWidget extends StatefulWidget {
  final String otherUserId;
  const SingleUserProfileMainWidget({Key? key, required this.otherUserId}) : super(key: key);

  @override
  State<SingleUserProfileMainWidget> createState() => _SingleUserProfileMainWidgetState();
}

class _SingleUserProfileMainWidgetState extends State<SingleUserProfileMainWidget> {
  String _currentUid = "";

  @override
  void initState() {
    BlocProvider.of<GetSingleOtherUserCubit>(context).getSingleOtherUser(otherUid: widget.otherUserId);
    BlocProvider.of<PostCubit>(context).getPosts(post: PostEntity());
    super.initState();

    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleOtherUserCubit, GetSingleOtherUserState>(
      builder: (context, userState) {
        if (userState is GetSingleOtherUserLoaded) {
          final singleUser = userState.otherUser;
          return Scaffold(
              backgroundColor: backGroundColor,
              appBar: AppBar(
                backgroundColor: backGroundColor,
                title: Text("${singleUser.username}", style: TextStyle(color: primaryColor),),
                actions: [
                  _currentUid == singleUser.uid ? Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: InkWell(
                        onTap: () {
                          _openBottomModalSheet(context: context, currentUser: singleUser);
                        },child: Icon(Icons.menu, color: primaryColor,)),
                  ) : Container()
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
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: profileWidget(imageUrl: singleUser.profileUrl),
                            ),
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text("${singleUser.totalPosts}", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),),
                                  sizeVer(8),
                                  Text("Posts", style: TextStyle(color: primaryColor),)
                                ],
                              ),
                              sizeHor(25),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, PageConst.followersPage, arguments: singleUser);

                                },
                                child: Column(
                                  children: [
                                    Text("${singleUser.totalFollowers}", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),),
                                    sizeVer(8),
                                    Text("Followers", style: TextStyle(color: primaryColor),)
                                  ],
                                ),
                              ),
                              sizeHor(25),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, PageConst.followingPage, arguments: singleUser);

                                },
                                child: Column(
                                  children: [
                                    Text("${singleUser.totalFollowing}", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),),
                                    sizeVer(8),
                                    Text("Following", style: TextStyle(color: primaryColor),)
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      sizeVer(10),
                      Text("${singleUser.name == ""? singleUser.username : singleUser.name}", style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),),
                      sizeVer(10),
                      Text("${singleUser.bio}", style: TextStyle(color: primaryColor),),
                      sizeVer(10),
                      _currentUid == singleUser.uid ? Container() :ButtonContainerWidget(
                        text: singleUser.followers!.contains(_currentUid) ?"UnFollow":"Follow",
                        color: singleUser.followers!.contains(_currentUid) ? secondaryColor.withOpacity(.4) : blueColor,
                        onTapListener: () {
                          BlocProvider.of<UserCubit>(context).followUnFollowUser(
                            user: UserEntity(
                              uid: _currentUid,
                              otherUid: widget.otherUserId
                            )
                          );
                        },
                      ),
                      sizeVer(10),
                      BlocBuilder<PostCubit, PostState>(
                        builder: (context, postState) {
                          if (postState is PostLoaded) {
                            final posts = postState.posts.where((post) => post.creatorUid == widget.otherUserId).toList();
                            return GridView.builder(
                                itemCount: posts.length,
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, PageConst.postDetailPage, arguments: posts[index].postId);

                                    },
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      child: profileWidget(imageUrl: posts[index].postImageUrl),
                                    ),
                                  );
                                });

                          }
                          return Center(child: CircularProgressIndicator(),);
                        },
                      )
                    ],
                  ),
                ),
              )
          );

        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }

  _openBottomModalSheet({required BuildContext context, required UserEntity currentUser}) {
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
                      Navigator.pushNamed(context, PageConst.editProfilePage, arguments: currentUser);
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
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<AuthCubit>(context).loggedOut();
                      Navigator.pushNamedAndRemoveUntil(context, PageConst.signInPage, (route) => false);
                    },
                    child: Text(
                      "Logout",
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
