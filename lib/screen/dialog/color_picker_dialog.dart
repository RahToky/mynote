import 'package:flutter/material.dart';
import 'package:my_note/callback/color_picker_callback.dart';
import 'package:my_note/const/colors.dart';
import 'package:my_note/util/color_util.dart';

class ColorPickerDialog extends StatelessWidget {
  final ColorsPickerListener _listener;
  final List<Map<String, String>> colors = MyColors.getHexMapColors();

  ColorPickerDialog(this._listener);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final axisCount = 5;
    final boxWidth = size.width * 0.8;
    final boxHeight = (colors.length/axisCount).ceil() * (boxWidth/axisCount);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        height: boxHeight,
        width: boxWidth,
        child: GridView.count(
          crossAxisCount: axisCount,
          children: colors.map((color) {
            return InkWell(
              child: Container(
                color: HexColor(color['cardBackgroundColor']),
              ),
              onTap: () {
                _listener.onPick(color);
                Navigator.of(context).pop(false);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
