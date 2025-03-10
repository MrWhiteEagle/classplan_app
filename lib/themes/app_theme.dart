import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    tertiary: Colors.grey.shade400,
    secondary: Colors.grey.shade600,
    primary: Color(0xFFBD004E),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      overlayColor: Color(0xFFBD004E),
      iconColor: Color(0xFFBD004E),
      foregroundColor: Color(0xFFBD004E),
      surfaceTintColor: Color(0xFFBD004E),
      side: BorderSide(
        color: Color(0xFFBD004E),
      ),
    ),
    
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    tertiary: Colors.grey.shade700,
    secondary: Colors.grey.shade500,
    primary: Color(0xFF8D003B),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      overlayColor: Color(0xFF8D003B),
      iconColor: Color(0xFF8D003B),
      foregroundColor: Color(0xFF8D003B),
      surfaceTintColor: Color(0xFF8D003B),
      side: BorderSide(
        color: Color(0xFF8D003B),
      ),
    ),
    
  ),
);

TextStyle contentTextStyle(BuildContext context){
  return TextStyle(
  fontSize: 15,
  color: Theme.of(context).colorScheme.secondary,
  );
}

TextStyle higherContentTextStyle(BuildContext context){
  return TextStyle(
    fontSize: 17,
    color: Theme.of(context).colorScheme.primary,
  );
}

TextStyle onPrimaryColorHeaderTextStyle(BuildContext context){
  return TextStyle(
    fontSize: 25,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
}
