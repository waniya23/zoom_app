import 'package:flutter/material.dart';
import 'package:zoom_app/utils/colors.dart';

class MeetingOptions extends StatelessWidget {
  final bool isMute;
  final Function(bool) onChange;
  final String text;
  const MeetingOptions({super.key,required this.text, required this.isMute, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: secondaryBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text,style:const  TextStyle(fontSize: 16),),
          ),
          Switch.adaptive(value: isMute, onChanged: onChange)

        ],
      ),
    );
  }
}
