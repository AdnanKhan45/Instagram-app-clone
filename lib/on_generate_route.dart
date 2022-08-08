


import 'package:flutter/material.dart';
import 'package:instagram_clone_app/consts.dart';
import 'package:instagram_clone_app/features/presentation/page/credential/sign_in_page.dart';
import 'package:instagram_clone_app/features/presentation/page/credential/sign_up_page.dart';
import 'package:instagram_clone_app/features/presentation/page/post/comment/comment_page.dart';
import 'package:instagram_clone_app/features/presentation/page/post/update_post_page.dart';
import 'package:instagram_clone_app/features/presentation/page/profile/edit_profile_page.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;

    switch(settings.name) {
      case PageConst.editProfilePage: {
        return routeBuilder(EditProfilePage());
      }
      case PageConst.updatePostPage: {
        return routeBuilder(UpdatePostPage());
      }
      case PageConst.commentPage: {
        return routeBuilder(CommentPage());
      }
      case PageConst.signInPage: {
        return routeBuilder(SignInPage());
      }
      case PageConst.signUpPage: {
        return routeBuilder(SignUpPage());
      }
      case PageConst.signUpPage: {
        return routeBuilder(SignUpPage());
      }
      default: {
        NoPageFound();
      }
    }
  }
}

dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page not found"),
      ),
      body: Center(child: Text("Page not found"),),
    );
  }
}

