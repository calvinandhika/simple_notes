import 'package:flutter/material.dart';
import 'package:simple_notes/shared/theme.dart';

class CustomAppBarButton extends StatelessWidget {
  final Function onTap;
  final Icon buttonIcon;
  final bool isDark;

  const CustomAppBarButton({
    Key? key,
    required this.onTap,
    required this.buttonIcon,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () async {
          return onTap();
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 50,
          height: 50,
          margin: const EdgeInsets.only(right: 15),
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
