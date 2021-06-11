import 'package:flutter/material.dart';
import 'package:my_note/const/strings.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(kAppName),
      actions: [
        PopupMenuButton(
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
        ),
      ],
    );
  }
}

class MyAppBarDetail extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(kAppName),
      actions: [
        IconButton(
            icon: Icon(
          Icons.edit_outlined,
          color: Colors.blue,
        )),
        IconButton(
            icon: Icon(
          Icons.delete_forever_outlined,
          color: Colors.red,
        )),
      ],
    );
  }
}

class MyAppBarAdd extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final String title;

  MyAppBarAdd(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(title),
      actions: [
        Container(
          width: kToolbarHeight,
          margin: EdgeInsets.all(10),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Positioned(
                child: Container(
                  width: kToolbarHeight *0.5,
                  height: kToolbarHeight *0.5,
                  color: Colors.red,
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: Container(
                  width: kToolbarHeight *0.5,
                  height: kToolbarHeight *0.5,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
