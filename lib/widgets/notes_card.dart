import 'package:flutter/material.dart';
import 'package:simple_notes/data/model/notes_model.dart';
import 'package:simple_notes/pages/notes_detail_page.dart';
import 'package:simple_notes/shared/theme.dart';
import 'package:intl/intl.dart';

class NotesCard extends StatelessWidget {
  final NoteModel note;
  final Future<void> Function()? fetchAllNotes;
  Color? color;

  NotesCard({
    Key? key,
    required this.note,
    this.fetchAllNotes,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotesDetailPage(
              note: note,
              fetchAllNotes: fetchAllNotes,
            ),
          ),
        ).then((value) => fetchAllNotes!());
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: (color != null) ? color : kWhiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: h3TextStyle.copyWith(
                color: kBlackColor,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              DateFormat('MMM dd, yyyy').format(note.date),
              style: bodyTextStyle.copyWith(
                color: kLightGreyColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
