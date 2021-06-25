
import 'package:flutter/material.dart';
import 'package:my_note/callback/color_picker_callback.dart';
import 'package:my_note/screen/dialog/color_picker_dialog.dart';

class MyAppBarAdd extends StatelessWidget implements PreferredSizeWidget, ColorsPickerListener{
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final String title;
  final Color _hexFirstColor;
  final Color _hexSecondColor;
  final ColorsPickerListener _colorsPickerListener;

  MyAppBarAdd(this.title, this._hexFirstColor,this._hexSecondColor,this._colorsPickerListener);

  @override
  Widget build(BuildContext context) {
    final templateHeight = kToolbarHeight * 0.4;
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
                  color: _hexSecondColor,
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
                        return ColorPickerDialog(this);
                      },
                    );
                  },
                  child: Container(
                    width: templateHeight,
                    height: templateHeight,
                    color: _hexFirstColor,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  void onPick(Map<String, String> colorMap) {
    _colorsPickerListener.onPick(colorMap);
  }
}
