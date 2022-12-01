
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone_app/consts.dart';
import 'package:instagram_clone_app/features/domain/entities/comment/comment_entity.dart';
import 'package:instagram_clone_app/features/presentation/cubit/comment/comment_cubit.dart';
import 'package:instagram_clone_app/features/presentation/page/profile/widgets/profile_form_widget.dart';
import 'package:instagram_clone_app/features/presentation/widgets/button_container_widget.dart';

class EditCommentMainWidget extends StatefulWidget {
  final CommentEntity comment;
  const EditCommentMainWidget({Key? key, required this.comment}) : super(key: key);

  @override
  State<EditCommentMainWidget> createState() => _EditCommentMainWidgetState();
}

class _EditCommentMainWidgetState extends State<EditCommentMainWidget> {

  TextEditingController? _descriptionController;

  bool _isCommentUpdating = false;

  @override
  void initState() {
    _descriptionController = TextEditingController(text: widget.comment.description);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        title: Text("Edit Comment"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: Column(
          children: [
            ProfileFormWidget(
              title: "description",
              controller: _descriptionController,
            ),
            sizeVer(10),
            ButtonContainerWidget(
              color: blueColor,
              text: "Save Changes",
              onTapListener: () {
                _editComment();
              },
            ),
            sizeVer(10),
            _isCommentUpdating == true?Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Updating...", style: TextStyle(color: Colors.white),),
                sizeHor(10),
                CircularProgressIndicator(),
              ],
            ) : Container(width: 0, height: 0,)
          ],
        ),
      ),
    );
  }

  _editComment() {
    setState(() {
      _isCommentUpdating = true;
    });
    BlocProvider.of<CommentCubit>(context).updateComment(comment: CommentEntity(
      postId: widget.comment.postId,
      commentId: widget.comment.commentId,
      description: _descriptionController!.text
    )).then((value) {
      setState(() {
        _isCommentUpdating = false;
        _descriptionController!.clear();
      });
      Navigator.pop(context);
    });
  }
}
