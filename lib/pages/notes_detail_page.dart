import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes/data/db/notes_database.dart';
import 'package:simple_notes/data/model/notes_model.dart';
import 'package:simple_notes/pages/notes_add_edit_page.dart';
import 'package:simple_notes/provider/theme_provider.dart';
import 'package:simple_notes/shared/theme.dart';
import 'package:simple_notes/widgets/custom_app_bar_button.dart';

class NotesDetailPage extends StatelessWidget {
  final NoteModel note;
  final Future<void> Function()? fetchAllNotes;

  NotesDetailPage({
    Key? key,
    required this.note,
    this.fetchAllNotes,
  }) : super(key: key);

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
                MaterialPageRoute(
                  builder: (context) => NotesAddEditPage(
                    fetchAllNotes: fetchAllNotes,
                    note: note,
                  ),
                ),
              ).then((value) => fetchAllNotes!());
              ;
            },
            isDark: isDark,
          ),
          CustomAppBarButton(
            buttonIcon: const Icon(Icons.delete),
            onTap: (context) {
              NotesDatabase().delete(note.id!);
              Navigator.pop(context);
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title,
                style: h2TextStyle,
              ),
              Text(
                'category - ${note.category}',
                style: h3TextStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                note.description,
                style: bodyTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
