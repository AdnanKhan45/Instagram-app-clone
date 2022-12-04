
import 'package:flutter/material.dart';
import 'package:instagram_clone_app/consts.dart';
import 'package:instagram_clone_app/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_clone_app/features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:instagram_clone_app/features/presentation/widgets/form_container_widget.dart';
import 'package:instagram_clone_app/profile_widget.dart';
import 'package:intl/intl.dart';
import 'package:instagram_clone_app/injection_container.dart' as di;

class SingleCommentWidget extends StatefulWidget {
  final CommentEntity comment;
  final VoidCallback? onLongPressListener;
  final VoidCallback? onLikeClickListener;
  const SingleCommentWidget({Key? key, required this.comment, this.onLongPressListener, this.onLikeClickListener}) : super(key: key);

  @override
  State<SingleCommentWidget> createState() => _SingleCommentWidgetState();
}

class _SingleCommentWidgetState extends State<SingleCommentWidget> {

  String _currentUid = "";

  @override
  void initState() {
    di.sl<GetCurrentUidUseCase>().call().then((value) {
      setState(() {
        _currentUid = value;
      });
    });
    super.initState();
  }

  bool _isUserReplaying = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: widget.onLongPressListener,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: profileWidget(imageUrl: widget.comment.userProfileUrl),
              ),
            ),
            sizeHor(10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${widget.comment.username}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: primaryColor),),
                        GestureDetector(onTap: widget.onLikeClickListener,child: Icon(widget.comment.likes!.contains(_currentUid) ? Icons.favorite :Icons.favorite_outline, size: 20, color: widget.comment.likes!.contains(_currentUid) ? Colors.red : darkGreyColor,))
                      ],
                    ),
                    sizeVer(4),
                    Text("${widget.comment.description}", style: TextStyle(color: primaryColor),),
                    sizeVer(4),
                    Row(
                      children: [
                        Text("${DateFormat("dd/MMM/yyy").format(widget.comment.createAt!.toDate())}", style: TextStyle(color: darkGreyColor),),
                        sizeHor(15),
                        GestureDetector(onTap: () {
                          setState(() {
                            _isUserReplaying = !_isUserReplaying;
                          });
                        },child: Text("Replay", style: TextStyle(color: darkGreyColor, fontSize: 12),)),
                        sizeHor(15),
                        Text("View Replays", style: TextStyle(color: darkGreyColor, fontSize: 12),),

                      ],
                    ),
                    _isUserReplaying == true? sizeVer(10) : sizeVer(0),
                    _isUserReplaying == true? Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        FormContainerWidget(hintText: "Post your replay..."),
                        sizeVer(10),
                        Text(
                          "Post",
                          style: TextStyle(color: blueColor),
                        )
                      ],
                    ) : Container(width: 0, height: 0,)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
