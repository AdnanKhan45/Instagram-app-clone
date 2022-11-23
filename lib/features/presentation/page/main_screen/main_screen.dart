import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:instagram_clone_app/features/presentation/page/activity/activity_page.dart';
import 'package:instagram_clone_app/features/presentation/page/post/upload_post_page.dart';
import 'package:instagram_clone_app/features/presentation/page/profile/profile_page.dart';
import 'package:instagram_clone_app/features/presentation/page/search/search_page.dart';
import '../../../../consts.dart';
import '../../cubit/user/get_single_user/get_single_user_cubit.dart';
import '../home/home_page.dart';

class MainScreen extends StatefulWidget {
  final String uid;

  const MainScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _currentIndex = 0;

  late PageController pageController;

  @override
  void initState() {
    BlocProvider.of<GetSingleUserCubit>(context).getSingleUser(uid: widget.uid);
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigationTapped(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
      builder: (context, getSingleUserState) {
        if (getSingleUserState is GetSingleUserLoaded) {
          final currentUser = getSingleUserState.user;
          return Scaffold(
            backgroundColor: backGroundColor,
            bottomNavigationBar: CupertinoTabBar(
              backgroundColor: backGroundColor,
              items: [
                BottomNavigationBarItem(icon: Icon(MaterialCommunityIcons.home_variant, color: primaryColor), label: ""),
                BottomNavigationBarItem(icon: Icon(Ionicons.md_search, color: primaryColor), label: ""),
                BottomNavigationBarItem(icon: Icon(Ionicons.md_add_circle, color: primaryColor), label: ""),
                BottomNavigationBarItem(icon: Icon(Icons.favorite, color: primaryColor), label: ""),
                BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined, color: primaryColor), label: ""),

              ],
              onTap: navigationTapped,
            ),
            body: PageView(
              controller: pageController,
              children: [
                HomePage(),
                SearchPage(),
                UploadPostPage(currentUser: currentUser),
                ActivityPage(),
                ProfilePage(currentUser: currentUser,)
              ],
              onPageChanged: onPageChanged,
            ),
          );
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }
}
