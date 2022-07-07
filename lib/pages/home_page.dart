import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_notes/data/db/notes_database.dart';
import 'package:simple_notes/data/model/notes_model.dart';
import 'package:simple_notes/pages/notes_add_edit_page.dart';
import 'package:simple_notes/provider/theme_provider.dart';
import 'package:simple_notes/shared/theme.dart';
import 'package:simple_notes/widgets/custom_app_bar_button.dart';
import 'package:simple_notes/widgets/notes_card.dart';
import 'package:simple_notes/widgets/show_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<bool> _isDark;
  late List<NoteModel> notes;
  bool isLoading = false;

  void toggleTheme(BuildContext context) async {
    final SharedPreferences prefs = await _prefs;
    final bool isDark = prefs.getBool('isDark') ?? true;

    setState(() {
      context.read<ThemeProvider>().toggleTheme();
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

    fetchAllNotes();

    super.initState();
  }

  Future<void> fetchAllNotes() async {
    setState(() => isLoading = true);
    notes = await NotesDatabase().readAllNotes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: FutureBuilder(
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
            //set default dark or light theme
            bool isDark = snapshot.data as bool;
            context.read<ThemeProvider>().setDefaultTheme(isDark);
            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Simple Notes',
                theme: isDark ? dark : light,
                home: Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 100,
                    actions: [
                      ShowDialog(toggleTheme: toggleTheme),
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
                    child: Builder(builder: (context) {
                      return FloatingActionButton(
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotesAddEditPage(),
                            ),
                          ).then((_) => fetchAllNotes());
                        },
                        child: const Icon(Icons.add),
                      );
                    }),
                  ),
                  body: RefreshIndicator(
                    onRefresh: () async {
                      fetchAllNotes();
                    },
                    child: notes.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 300,
                                  child: Image.asset(
                                      'assets/image_file_not_found.png'),
                                ),
                                Text(
                                  'Create Your First Note!',
                                  style: bodyTextStyle,
                                )
                              ],
                            ),
                          )
                        : MasonryGridView.count(
                            itemCount: notes.length,
                            crossAxisCount: 2,
                            itemBuilder: (context, index) {
                              return NotesCard(
                                note: notes[index],
                                color: colors[index % 7],
                                fetchAllNotes: fetchAllNotes,
                              );
                            },
                          ),
                  ),
                ),
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
