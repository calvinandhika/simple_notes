import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_notes/provider/theme_provider.dart';
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

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<bool> _isDark;

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
    super.initState();
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
                      onTap: (context) {},
                      isDark: isDark,
                    ),
                    CustomAppBarButton(
                      buttonIcon: const Icon(Icons.info_outline),
                      // onTap: toggleTheme,
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
                                          isDark: isDark);
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
      ),
    );
  }
}
