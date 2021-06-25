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
    final double boxColorSize = 50;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(5.0),
        child: Wrap(
          children: colors.map((color) {
            return InkWell(
              child: Container(
                height: boxColorSize,
                width: boxColorSize,
                color: HexColor(color['cardBackgroundColor']),
              ),
              onTap: (){
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
