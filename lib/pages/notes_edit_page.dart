import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes/provider/theme_provider.dart';
import 'package:simple_notes/shared/theme.dart';
import 'package:simple_notes/widgets/custom_app_bar_button.dart';

class NotesEditPage extends StatefulWidget {
  const NotesEditPage({Key? key}) : super(key: key);

  @override
  State<NotesEditPage> createState() => _NotesEditPageState();
}

class _NotesEditPageState extends State<NotesEditPage> {
  late final bool isDark;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    isDark = context.read<ThemeProvider>().isDark;
    titleController.text =
        'Book Review : The Design of Everyday Things by Don Norman';
    descriptionController.text = '''    
The Design of Everyday Things is required reading for anyone who is interested in the user experience. I personally like to reread it every year or two.

Norman is aware of the durability of his work and the applicability of his principles to multiple disciplines. 

If you know the basics of design better than anyone else, you can apply them flawlessly anywhere.
''';
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            buttonIcon: const Icon(Icons.save),
            onTap: (context) {},
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
              TextField(
                controller: titleController,
                style: h3TextStyle,
                minLines: 2,
                maxLines: 5,
              ),
              TextField(
                controller: descriptionController,
                style: bodyTextStyle,
                minLines: 5,
                maxLines: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
