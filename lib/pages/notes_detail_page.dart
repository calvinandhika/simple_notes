import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes/pages/notes_edit_page.dart';
import 'package:simple_notes/provider/theme_provider.dart';
import 'package:simple_notes/shared/theme.dart';
import 'package:simple_notes/widgets/custom_app_bar_button.dart';

class NotesDetailPage extends StatelessWidget {
  NotesDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = context.read<ThemeProvider>().isDark;

    return Scaffold(
      appBar: AppBar(
        leading: CustomAppBarButton(
          buttonIcon: const Icon(Icons.arrow_back_ios_new_rounded),
          onTap: (context) {
            return Navigator.of(context).pop();
          },
          isDark: isDark,
          margin: const EdgeInsets.all(0),
        ),
        leadingWidth: 85,
        toolbarHeight: 100,
        actions: [
          CustomAppBarButton(
            buttonIcon: const Icon(Icons.edit_outlined),
            onTap: (context) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotesEditPage()),
              );
            },
            isDark: isDark,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Text(
                'Book Review : The Design of Everyday Things by Don Norman',
                style: h2TextStyle,
              ),
              Text(
                '''
            
The Design of Everyday Things is required reading for anyone who is interested in the user experience. I personally like to reread it every year or two.

Norman is aware of the durability of his work and the applicability of his principles to multiple disciplines. 

If you know the basics of design better than anyone else, you can apply them flawlessly anywhere.

''',
                style: bodyTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
