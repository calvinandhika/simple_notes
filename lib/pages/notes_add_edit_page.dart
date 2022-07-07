import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_notes/data/db/notes_database.dart';
import 'package:simple_notes/data/model/notes_model.dart';
import 'package:simple_notes/provider/theme_provider.dart';
import 'package:simple_notes/shared/theme.dart';
import 'package:simple_notes/widgets/custom_app_bar_button.dart';

class NotesAddEditPage extends StatefulWidget {
  final NoteModel? note;
  final Future<void> Function()? fetchAllNotes;

  const NotesAddEditPage({
    Key? key,
    this.note,
    this.fetchAllNotes,
  }) : super(key: key);

  @override
  State<NotesAddEditPage> createState() => _NotesAddEditPageState();
}

class _NotesAddEditPageState extends State<NotesAddEditPage> {
  late final bool isDark;
  TextEditingController titleController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    isDark = context.read<ThemeProvider>().isDark;
    titleController.text = widget.note?.title ?? '';
    descriptionController.text = widget.note?.description ?? '';
    categoryController.text = widget.note?.category ?? '';

    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomAppBarButton(
          buttonIcon: const Icon(Icons.arrow_back_ios_new_rounded),
          onTap: (context) {
            return Navigator.pop(context, true);
          },
          isDark: isDark,
          margin: const EdgeInsets.all(0),
        ),
        leadingWidth: 85,
        toolbarHeight: 100,
        actions: [
          CustomAppBarButton(
            buttonIcon: const Icon(Icons.save),
            onTap: (context) {
              if (widget.note == null) {
                createNote();
              } else {
                updateNote();
              }
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                notesField(
                  title: 'Title',
                  minLines: 2,
                  maxLines: 5,
                  controller: titleController,
                ),
                const SizedBox(
                  height: 20,
                ),
                notesField(
                  title: 'Category',
                  minLines: 1,
                  maxLines: 3,
                  controller: categoryController,
                ),
                const SizedBox(
                  height: 20,
                ),
                notesField(
                  title: 'Description',
                  minLines: 5,
                  maxLines: 50,
                  controller: descriptionController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createNote() async {
    NoteModel note = NoteModel(
      title: titleController.text,
      description: descriptionController.text,
      category: categoryController.text,
    );
    await NotesDatabase().create(note);
    await widget.fetchAllNotes!();
  }

  void updateNote() async {
    final note = widget.note?.copy(
      title: titleController.text,
      description: descriptionController.text,
      category: categoryController.text,
    );

    await NotesDatabase().update(note!);
    await widget.fetchAllNotes!();
  }

  Widget notesField({
    required String title,
    required int minLines,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      style: h3TextStyle,
      minLines: minLines,
      maxLines: maxLines,
      decoration: InputDecoration(
        label: Text(
          title,
          style: bodyTextStyle,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 3,
            color: kPinkColor,
          ),
        ),
      ),
    );
  }
}
