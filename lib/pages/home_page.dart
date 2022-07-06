import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_notes/shared/theme.dart';
import 'package:simple_notes/widgets/custom_app_bar_button.dart';
import 'package:simple_notes/widgets/notes_card.dart';

List<String> titles = [
  'How to make personale brand',
  'how to',
  'good boi yiha',
  'nah ini agak panjang jadinya gimana ni hasilnya?',
  'How to make personale brand',
  'how to',
  'good boi yiha',
  'nah ini agak panjang jadinya gimana ni hasilnya?',
  'How to make personale brand',
  'how to',
  'good boi yiha',
  'nah ini agak panjang jadinya gimana ni hasilnya?',
  'plepce kiga ua'
];

List<Color> colors = [
  kPeachColor,
  kOrangeColor,
  kBlueColor,
  kGreenColor,
  kPurpleColor,
  kPinkColor,
  kToscaColor,
];

class SimpleNotes extends StatefulWidget {
  const SimpleNotes({Key? key}) : super(key: key);

  @override
  State<SimpleNotes> createState() => _SimpleNotesState();
}

class _SimpleNotesState extends State<SimpleNotes> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<bool> _isDark;

  Future<void> toggleTheme() async {
    final SharedPreferences prefs = await _prefs;
    final bool isDark = prefs.getBool('isDark') ?? true;

    setState(() {
      _isDark = prefs.setBool('isDark', !isDark).then((_) {
        return !isDark;
      });
    });
  }

  @override
  void initState() {
    _isDark = _prefs.then((prefs) {
      return prefs.getBool('isDark') ?? true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _isDark,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          bool isDark = snapshot.data as bool;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Simple Notes',
            theme: isDark ? dark : light,
            home: Scaffold(
              appBar: AppBar(
                toolbarHeight: 100,
                actions: [
                  CustomAppBarButton(
                    buttonIcon: const Icon(Icons.search),
                    onTap: () {},
                    isDark: isDark,
                  ),
                  CustomAppBarButton(
                    buttonIcon: const Icon(Icons.info_outline),
                    onTap: toggleTheme,
                    isDark: isDark,
                  ),
                ],
                title: Text(
                  'Notes',
                  style: h1TextStyle,
                ),
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                  bottom: 20,
                ),
                child: FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.add),
                ),
              ),
              body: RefreshIndicator(
                onRefresh: () async {},
                child: MasonryGridView.count(
                  physics: const BouncingScrollPhysics(),
                  itemCount: titles.length,
                  crossAxisCount: 2,
                  itemBuilder: (context, index) {
                    return NotesCard(
                      title: titles[index],
                      color: colors[index % 7],
                    );
                  },
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
