import 'package:flutter/material.dart';
import 'package:mvvm_app/res/color.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;

  const RoundButton({
    Key? key,
    required this.title,
    required this.onPress,

    // এটা অপশনাল। কিছু না দিলে অটোমেটিক 'false' ধরে নেবে।
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: loading
              ? CircularProgressIndicator()
              : Text(title, style: TextStyle(color: AppColors.blackColor)),
        ),
      ),
    );
  }
}
