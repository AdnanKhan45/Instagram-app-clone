import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:instagram_clone_app/consts.dart';
import 'package:instagram_clone_app/features/domain/entities/app_entity.dart';
import 'package:instagram_clone_app/features/domain/entities/posts/post_entity.dart';
import 'package:instagram_clone_app/features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:instagram_clone_app/features/presentation/cubit/post/get_single_post/get_single_post_cubit.dart';
import 'package:instagram_clone_app/features/presentation/cubit/post/post_cubit.dart';
import 'package:instagram_clone_app/features/presentation/page/post/widget/like_animation_widget.dart';
import 'package:instagram_clone_app/profile_widget.dart';
import 'package:intl/intl.dart';
import 'package:instagram_clone_app/injection_container.dart' as di;
class PostDetailMainWidget extends StatefulWidget {
  final String postId;
  const PostDetailMainWidget({Key? key, required this.postId}) : super(key: key);

  @override
  State<PostDetailMainWidget> createState() => _PostDetailMainWidgetState();
}

class _PostDetailMainWidgetState extends State<PostDetailMainWidget> {

  String _currentUid = "";

  @override
  void initState() {

    BlocProvider.of<GetSinglePostCubit>(context).getSinglePost(postId: widget.postId);

    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });
    super.initState();
  }

  bool _isLikeAnimating = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backGroundColor,
        title: Text("Post Detail"),
      ),
      backgroundColor: backGroundColor,
      body: BlocBuilder<GetSinglePostCubit, GetSinglePostState>(
        builder: (context, getSinglePostState) {
          if (getSinglePostState is GetSinglePostLoaded) {
            final singlePost = getSinglePostState.post;
            return Padding(
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
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: profileWidget(imageUrl: "${singlePost.userProfileUrl}"),
                            ),
                          ),
                          sizeHor(10),
                          Text(
                            "${singlePost.username}",
                            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      singlePost.creatorUid == _currentUid
                          ? GestureDetector(
                          onTap: () {
                            _openBottomModalSheet(context, singlePost);
                          },
                          child: Icon(
                            Icons.more_vert,
                            color: primaryColor,
                          ))
                          : Container(
                        width: 0,
                        height: 0,
                      )
                    ],
                  ),
                  sizeVer(10),
                  GestureDetector(
                    onDoubleTap: () {
                      _likePost();
                      setState(() {
                        _isLikeAnimating = true;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.30,
                          child: profileWidget(imageUrl: "${singlePost.postImageUrl}"),
                        ),
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 200),
                          opacity: _isLikeAnimating ? 1 : 0,
                          child: LikeAnimationWidget(
                              duration: Duration(milliseconds: 200),
                              isLikeAnimating: _isLikeAnimating,
                              onLikeFinish: () {
                                setState(() {
                                  _isLikeAnimating = false;
                                });
                              },
                              child: Icon(
                                Icons.favorite,
                                size: 100,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                  ),
                  sizeVer(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                              onTap: _likePost,
                              child: Icon(
                                singlePost.likes!.contains(_currentUid)
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                color: singlePost.likes!.contains(_currentUid)
                                    ? Colors.red
                                    : primaryColor,
                              )),
                          sizeHor(10),
                          GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, PageConst.commentPage,
                                    arguments:
                                    AppEntity(uid: _currentUid, postId: singlePost.postId));
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage()));
                              },
                              child: Icon(
                                Feather.message_circle,
                                color: primaryColor,
                              )),
                          sizeHor(10),
                          Icon(
                            Feather.send,
                            color: primaryColor,
                          ),
                        ],
                      ),
                      Icon(
                        Icons.bookmark_border,
                        color: primaryColor,
                      )
                    ],
                  ),
                  sizeVer(10),
                  Text(
                    "${singlePost.totalLikes} likes",
                    style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                  sizeVer(10),
                  Row(
                    children: [
                      Text(
                        "${singlePost.username}",
                        style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
                      ),
                      sizeHor(10),
                      Text(
                        "${singlePost.description}",
                        style: TextStyle(color: primaryColor),
                      ),
                    ],
                  ),
                  sizeVer(10),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PageConst.commentPage,
                            arguments: AppEntity(uid: _currentUid, postId: singlePost.postId));
                      },
                      child: Text(
                        "View all ${singlePost.totalComments} comments",
                        style: TextStyle(color: darkGreyColor),
                      )),
                  sizeVer(10),
                  Text(
                    "${DateFormat("dd/MMM/yyy").format(singlePost.createAt!.toDate())}",
                    style: TextStyle(color: darkGreyColor),
                  ),
                ],
              ),
            );

          }
          return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
  _openBottomModalSheet(BuildContext context, PostEntity post) {
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
                    onTap: _deletePost,
                    child: Text(
                      "Delete Post",
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, PageConst.updatePostPage, arguments: post);

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



  _deletePost() {
    BlocProvider.of<PostCubit>(context).deletePost(post: PostEntity(postId: widget.postId));
  }

  _likePost() {
    BlocProvider.of<PostCubit>(context).likePost(post: PostEntity(
        postId: widget.postId
    ));
  }
}
