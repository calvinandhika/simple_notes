import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_notes/shared/theme.dart';
import 'package:simple_notes/widgets/custom_app_bar_button.dart';

class SimpleNotes extends StatefulWidget {
  const SimpleNotes({Key? key}) : super(key: key);

  @override
  State<SimpleNotes> createState() => _SimpleNotesState();
}

class _SimpleNotesState extends State<SimpleNotes> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<bool> _isDark;

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
                    onTap: () {},
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
                  child: Icon(Icons.add),
                ),
              ),
              body: Center(
                child: Container(
                  child: Text('Hello World'),
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
