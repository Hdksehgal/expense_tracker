import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((fn) {
  //   runApp(MyApp());
  // });

  //the above method is used set up fixed orientation of the
  // screen even on rotation of it

  runApp(MyApp());
}

ColorScheme kcolorScheme = ColorScheme.fromSeed(
    seedColor: Color(0xfffc5ba6) , background: Color(0xffb8bdf2));

ColorScheme kdarkscheme = ColorScheme.fromSeed(seedColor: Color(0xffb81140), brightness: Brightness.dark, background: Color(0xffb81140));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kdarkscheme,

        cardTheme: CardTheme().copyWith(
          color: kdarkscheme.secondaryContainer
        ),

        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kdarkscheme.onPrimaryContainer,
          foregroundColor: kdarkscheme.primaryContainer
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kdarkscheme.onSecondaryContainer,
            foregroundColor: kdarkscheme.secondaryContainer
          )
        )

      ),

      debugShowCheckedModeBanner: false,

      theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kcolorScheme,

          cardTheme: CardTheme( color:Color(0xfff2b8bd) ),


          appBarTheme: AppBarTheme(backgroundColor: Color(0xffd4f2b8)),

          bottomSheetTheme: BottomSheetThemeData(backgroundColor: Color(0xfff2b8bd)),

          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            textStyle: TextStyle(color: Colors.white),
                backgroundColor: Color(0xffd4f2b8),
                foregroundColor: Colors.black54,
          ))),
      themeMode: ThemeMode.system,
      home: Expenses(),
    );
  }
}
