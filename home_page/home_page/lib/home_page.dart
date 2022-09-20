import 'package:flutter/material.dart';
import 'package:home_page/home_contents.dart';
import 'package:home_page/my_navigation_bar.dart';
import 'package:home_page/website_title.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: const <Widget>[
        MyNavigationBar(),
        SizedBox(height: 50,),
        WebsiteTitle(),
        SizedBox(height: 50,),
        HomeContents(),
      ],),
    );
  }
}