import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

const Color blackClr = Color.fromARGB(0, 0, 0, 0);
const primaryClr = greenClr;

const Color greenClr = Color.fromARGB(255, 0, 173, 40);
const Color pinkClr = Color.fromRGBO(28, 72, 88, 1);
const Color blueClr = Color.fromARGB(237, 68, 55, 249);
const Color ambarClr = Color.fromARGB(214, 33, 33, 97);
const Color orageClr = Color.fromARGB(255, 91, 4, 4);

class Themes {
  static final light = ThemeData(
    primaryColor: const Color.fromARGB(255, 10, 77, 12),
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    primaryColor: Colors.green,
    brightness: Brightness.dark,
  );
}

TextStyle get subTituloStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Get.isDarkMode ? Colors.grey[400] : Colors.grey),
  );
}

TextStyle get TituloStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.grey[800],
    ),
  );
}

TextStyle get Titulo {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ),
  );
}


