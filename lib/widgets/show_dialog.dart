import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes/provider/theme_provider.dart';
import 'package:simple_notes/shared/theme.dart';
import 'package:simple_notes/widgets/custom_app_bar_button.dart';

class ShowDialog extends StatelessWidget {
  Function toggleTheme;

  ShowDialog({
    Key? key,
    required this.toggleTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppBarButton(
      buttonIcon: const Icon(Icons.info_outline),
      isDark: context.read<ThemeProvider>().isDark,
      onTap: (context) => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Proudly Made By\nCalvin Andhika',
            style: h3TextStyle,
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 2.5,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email:\ncalvin.andhika@gmail.com\n',
                    style: body2TextStyle,
                  ),
                  Text(
                    'GitHub:\ngithub.com/calvinandhika/simple_notes',
                    style: body2TextStyle,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Toggle Dark Theme',
                      style: bodyTextStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<ThemeProvider>(
                    builder: (context, value, child) {
                      return CustomAppBarButton(
                          onTap: toggleTheme,
                          buttonIcon: value.isDark
                              ? Icon(Icons.toggle_on_outlined)
                              : Icon(Icons.toggle_off_rounded),
                          isDark: true);
                    },
                  )
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Close'),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
