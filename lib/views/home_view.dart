import 'dart:io';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  PageController controller = PageController(initialPage: 0, viewportFraction: 0.8);
  List<Color> colors = [Colors.red, Colors.green, Colors.blue];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffede7e6),
      body: PageView.builder(
          controller: controller,
          itemCount: colors.length,
          itemBuilder: (context, index) => Center()
      ),
    );
  }
}
