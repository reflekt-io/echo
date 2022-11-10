import 'package:flutter/material.dart';
import 'package:about_us/screens/about_us.dart';
import 'package:echo/screens/home_page.dart';
import 'package:echo/screens/create_new_account.dart';
import 'package:echo/screens/login_screen.dart';
import 'package:journal/screens/add_journal_page.dart';
import 'package:journal/screens/journal_home_page.dart';
import 'package:kutipan/screens/add_kutipan_penyemangat_page.dart';
import 'package:kutipan/screens/kutipan_penyemangat_home.dart';
import 'package:pojok_curhat/screens/add_pojok_curhat_page.dart';
import 'package:pojok_curhat/screens/pojok_curhat_home.dart';
import 'package:deteksi_depresi/screens/phq9_page.dart';
import 'package:ide_kegiatan/screens/add_ide_kegiatan.dart';
import 'package:ide_kegiatan/screens/ide_kegiatan_home.dart';
import 'package:tembok_harapan/screens/add_tembok_harapan_page.dart';
import 'package:tembok_harapan/screens/tembok_harapan_home.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  /*
  Colors:
  - Backgrounds, navbar - black #24262a
  - Backgrounds - light gray #f7f9fb
  - Buttons, icons - blue #0b36a8
  - Headings text - black #24262a
  - Body text - dark gray #4d5055
  */

  // Custom colors
  static Map<int, Color> themeColor = {
    // 0xFF24262A
    50: const Color.fromRGBO(36, 38, 42, .1),
    100: const Color.fromRGBO(36, 38, 42, .2),
    200: const Color.fromRGBO(36, 38, 42, .3),
    300: const Color.fromRGBO(36, 38, 42, .4),
    400: const Color.fromRGBO(36, 38, 42, .5),
    500: const Color.fromRGBO(36, 38, 42, .6),
    600: const Color.fromRGBO(36, 38, 42, .7),
    700: const Color.fromRGBO(36, 38, 42, .8),
    800: const Color.fromRGBO(36, 38, 42, .9),
    900: const Color.fromRGBO(36, 38, 42, 1),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) {
          CookieRequest request = CookieRequest();

          return request;
        },
      child: MaterialApp(
          title: 'reflekt.io',
          theme: ThemeData(
            primarySwatch: MaterialColor(0xFF24262A, themeColor),
          ),
          home: const LoginScreen(),
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case HomePage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => const HomePage());
              case JournalHomePage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => const JournalHomePage());
              case AddJournalPage.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => const AddJournalPage());
              case LoginScreen.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => const LoginScreen());
              case CreateNewAccount.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (_) => const CreateNewAccount());
              case KutipanPenyemangatHomePage.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (_) => const KutipanPenyemangatHomePage());
              case AddKutipanPenyemangatPage.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (_) => const AddKutipanPenyemangatPage());
              case PojokCurhatHomePage.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (_) => const PojokCurhatHomePage());
              case AddPojokCurhatPage.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (_) => const AddPojokCurhatPage());
              case TembokHarapanHomePage.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (_) => const TembokHarapanHomePage());
              case AddTembokHarapanPage.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (_) => const AddTembokHarapanPage());
              case PHQ9.ROUTE_NAME:
                return MaterialPageRoute(builder: (_) => const PHQ9());
              case IdeKegiatanHomePage.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (_) => const IdeKegiatanHomePage());
              case AddRekomendasiKegiatanPage.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (_) => const AddRekomendasiKegiatanPage());
              case AboutUs.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (_) => const AboutUs());
              default:
                return MaterialPageRoute(
                  builder: (_) {
                    return const Scaffold(
                      body: Center(
                        child: Text('Page not found :('),
                      ),
                    );
                  },
                );
            }
          }),
    );
  }
}
