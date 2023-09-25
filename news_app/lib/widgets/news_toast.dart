import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:test_app/themes/color_pallete.dart";
import "package:test_app/themes/text_theme.dart";

class NewsToast extends StatelessWidget {
  final FToast fToast;
  final String msg;

  const NewsToast({Key? key, required this.fToast, required this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 16, right: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: NewsColors.textPrimary.withOpacity(0.7),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                msg,
                style: NewsTextTheme.regular16.copyWith(color: Colors.white),
              ),
            ),
            IconButton(
              onPressed: () => fToast.removeCustomToast(),
              icon: Icon(
                Icons.close,
                color: NewsColors.textPrimary.withOpacity(0.9),
              ),
            )
          ],
        ),
      );
}
