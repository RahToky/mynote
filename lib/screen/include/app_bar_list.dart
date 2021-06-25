import 'package:flutter/material.dart';
import 'package:my_note/const/strings.dart';

class MySliverAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double _appBarHeight;
    return SliverAppBar(
      actions: [
        /*popupMenus(context)*/
        IconButton(
          icon: Icon(Icons.info_outline),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => aboutDialog(context));
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

  Widget popupMenus(context) => PopupMenuButton(
        //don't specify icon if you want 3 dot menu
        itemBuilder: (context) => [
          PopupMenuItem<int>(
            value: 0,
            child: Text(
              kAbout,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
          PopupMenuItem<int>(
            value: 0,
            child: Text(
              'Help',
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
        onSelected: (item) => {
          showDialog(
              context: context,
              builder: (context) {
                return const AboutDialog();
              }),
        },
      );

  Widget aboutDialog(BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: Container(
          height: 300.0,
          width: 300.0,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.red,
                child: Icon(Icons.file_copy),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Cool',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Awesome',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 50.0)),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Got It!',
                        style: TextStyle(color: Colors.purple, fontSize: 18.0),
                      ))
                ],
              ),
            ],
          ),
        ),
      );
}
