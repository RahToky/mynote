import 'package:flutter/material.dart';
import 'package:my_note/const/strings.dart';
import 'package:my_note/screen/dialog/about_dialog.dart';

class MySliverAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double _appBarHeight;
    return SliverAppBar(
      actions: [
        IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => MyAboutDialog());
          },
        )
      ],
      backgroundColor: Colors.black,
      pinned: true,
      floating: true,
      expandedHeight: size.height * 0.3,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          _appBarHeight = constraints.biggest.height;
          return FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: Container(color: Colors.black),
            centerTitle: true,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_appBarHeight > kToolbarHeight + 40)
                  Column(
                    children: [
                      Image.asset("assets/icon/logo.png",width: 50),
                    ],
                  ),
                Text(
                  kAppName,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
