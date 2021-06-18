import 'package:flutter/material.dart';
import 'package:my_note/const/colors.dart';
import 'package:my_note/const/strings.dart';
import 'package:my_note/util/color_util.dart';
import 'dart:developer' as developer;

class MyAppBarAdd extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final String title;
  final String hexCardBackgroundColor;

  MyAppBarAdd(this.title, this.hexCardBackgroundColor);

  @override
  _MyAppBarAddState createState() =>
      _MyAppBarAddState(this.title, this.hexCardBackgroundColor);
}

class _MyAppBarAddState extends State<MyAppBarAdd> {
  final String title;
  final String hexCardBackgroundColor;
  Color secondPaletteColor;

  final List<Map<String, String>> colors = MyColors.getHexMapColors();

  _MyAppBarAddState(this.title, this.hexCardBackgroundColor);

  void initPaletteColor() {
    for (int i = 0; i < colors.length; i++) {
      if (colors[i]['cardBackgroundColor'] == hexCardBackgroundColor) {
        secondPaletteColor = HexColor(
            colors[(i == colors.length - 1) ? 0 : i + 1]
                ['cardBackgroundColor']);
      }
    }
  }

  @override
  void initState() {
    initPaletteColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final templateHeight = kToolbarHeight * 0.4;
    final Size size = MediaQuery.of(context).size;
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
                  width: templateHeight,
                  height: templateHeight,
                  color: secondPaletteColor,
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return colorPaletteDialog(context, size.height, size.width);
                      },
                    );
                  },
                  child: Container(
                    width: templateHeight,
                    height: templateHeight,
                    color: HexColor(hexCardBackgroundColor),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget colorPaletteDialog(BuildContext context, height, width) => Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: Container(
          color: Colors.red,
          height: height,
          width: width,
          child: Text("test"),
        ),
      );
}
