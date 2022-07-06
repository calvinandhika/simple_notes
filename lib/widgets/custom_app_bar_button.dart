import 'package:flutter/material.dart';
import 'package:simple_notes/shared/theme.dart';

class CustomAppBarButton extends StatelessWidget {
  final Function onTap;
  final Icon buttonIcon;
  final bool isDark;
  final EdgeInsets? margin;

  const CustomAppBarButton({
    Key? key,
    required this.onTap,
    required this.buttonIcon,
    required this.isDark,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          onTap(context);
        },
        child: Container(
          width: 50,
          height: 50,
          margin: (margin == null) ? const EdgeInsets.only(right: 15) : margin,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            border: Border.all(color: kLightGreyColor),
            color: isDark ? kLightGreyColor : kWhiteColor,
          ),
          child: buttonIcon,
        ),
      ),
    );
  }
}
