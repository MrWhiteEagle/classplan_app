import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  fontFamily: 'Actor',
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    //PRIMARY COLOR
    primary: Color(0xFFdfd7ff),
    onPrimary: Color(0xFF26195e),
    primaryContainer: Color(0xFF9287d2),
    onPrimaryContainer: Colors.black,

    //SECONDARY COLOR
    secondary: Color(0xFFffcfe6),
    onSecondary: Color(0xFF4e0037),
    secondaryContainer: Color(0xFFf152b8),
    onSecondaryContainer: Colors.black,

    //TERTIARY COLOR
    tertiary: Color(0xFF79eeee),
    onTertiary: Color(0xFF002b2b),
    tertiaryContainer: Color(0xFF0da1a1),
    onTertiaryContainer: Colors.black,

    //ERROR COLOR
    error: Color(0xFFffd2cc),
    onError: Color(0xFF540003),
    errorContainer: Color(0xFFff5449),
    onErrorContainer: Colors.black,

    //SURFACE COLOR
    surface: Color(0xFF141313),
    surfaceBright: Color(0xFF454444),
    surfaceDim: Color(0xFF141313),
    surfaceContainerLowest: Color(0xFF080707),
    surfaceContainerLow: Color(0xFF1e1d1d),
    surfaceContainer: Color(0xFF282828),
    surfaceContainerHigh: Color(0xFF333232),
    surfaceContainerHighest: Color(0xFF3e3d3d),
    onSurface: Colors.white,
    onSurfaceVariant: Color(0xFFdfdbe1),
    outline: Color(0xFFb4b0b6),
    outlineVariant: Color(0xFF928f95),

    //INVERSED COLORS
    inversePrimary: Color(0xFF493e83),
    inverseSurface: Color(0xFFe5e2e1),
    onInverseSurface: Color(0xFF2b2a2a),

    scrim: Colors.black,
    shadow: Colors.black,
  ),
);

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    //PRIMARY COLOR
    primary: Color(0xFF190852),
    onPrimary: Colors.white,
    primaryContainer: Color(0xFF2e2267),
    onPrimaryContainer: Color(0xFFbdb1ff),

    //SECONDARY COLOR
    secondary: Color(0xFF6b004d),
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFc32991),
    onSecondaryContainer: Colors.white,

    //TERTIARY COLOR
    tertiary: Color(0xFF003d3d),
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFF007a7a),
    onTertiaryContainer: Colors.white,

    //ERROR COLOR
    error: Color(0xFF740006),
    onError: Colors.white,
    errorContainer: Color(0xFFce0013),
    onErrorContainer: Colors.white,

    //SURFACE COLOR
    surface: Color(0xFFfdf8f8),
    surfaceBright: Color(0xFFfdf8f8),
    surfaceDim: Color(0xFFc9c6c5),
    surfaceContainerLowest: Colors.white,
    surfaceContainerLow: Color(0xFFf7f3f2),
    surfaceContainer: Color(0xFFebe7e7),
    surfaceContainerHigh: Color(0xFFe0dcdc),
    surfaceContainerHighest: Color(0xFFd4d1d0),
    onSurface: Colors.black,
    onSurfaceVariant: Color(0xFF37353a),
    outline: Color(0xFF545157),
    outlineVariant: Color(0xFF6f6c71),

    //INVERSED COLORS
    inversePrimary: Color(0xFFc9beff),
    inverseSurface: Color(0xFF313030),
    onInverseSurface: Color(0xFFf4f0ef),

    scrim: Colors.black,
    shadow: Colors.black,
  ),
);

//TEXSTYLES
TextStyle onSurfaceTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 17,
    color: Theme.of(context).colorScheme.onSurface,
  );
}

TextStyle higherContentTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 17,
    color: Theme.of(context).colorScheme.primary,
    fontWeight: FontWeight.bold,
  );
}

TextStyle onPrimaryBoldTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    color: Theme.of(context).colorScheme.onPrimary,
    fontWeight: FontWeight.bold,
  );
}

TextStyle onPrimaryTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    color: Theme.of(context).colorScheme.onPrimary,
  );
}

TextStyle onPrimaryContainerTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    color: Theme.of(context).colorScheme.onPrimaryContainer,
  );
}

TextStyle onPrimaryBoldContainerTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    color: Theme.of(context).colorScheme.onPrimaryContainer,
    fontWeight: FontWeight.bold,
  );
}

TextStyle onSecondaryTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    color: Theme.of(context).colorScheme.onSecondary,
  );
}

TextStyle onSecondaryBoldTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    color: Theme.of(context).colorScheme.onSecondary,
    fontWeight: FontWeight.bold,
  );
}

TextStyle onSecondaryContainerTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    color: Theme.of(context).colorScheme.onSecondaryContainer,
  );
}

TextStyle onSecondaryBoldContainerTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    color: Theme.of(context).colorScheme.onSecondaryContainer,
    fontWeight: FontWeight.bold,
  );
}

TextStyle primaryTextStyle(BuildContext context) {
  return TextStyle(fontSize: 25, color: Theme.of(context).colorScheme.primary);
}

TextStyle primaryBoldTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    color: Theme.of(context).colorScheme.primary,
    fontWeight: FontWeight.bold,
  );
}

TextStyle secondaryTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    color: Theme.of(context).colorScheme.secondary,
  );
}

TextStyle secondaryBoldTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    color: Theme.of(context).colorScheme.secondary,
    fontWeight: FontWeight.bold,
  );
}

TextStyle tertiaryTextStyle(BuildContext context) {
  return TextStyle(fontSize: 25, color: Theme.of(context).colorScheme.tertiary);
}

TextStyle tertiaryBoldTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    color: Theme.of(context).colorScheme.tertiary,
    fontWeight: FontWeight.bold,
  );
}

TextStyle primaryContainerTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    color: Theme.of(context).colorScheme.primaryContainer,
  );
}

TextStyle primaryBoldContainerTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    color: Theme.of(context).colorScheme.primaryContainer,
    fontWeight: FontWeight.bold,
  );
}

TextStyle secondaryContainerTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    color: Theme.of(context).colorScheme.secondaryContainer,
  );
}

TextStyle secondaryBoldContainerTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    color: Theme.of(context).colorScheme.secondaryContainer,
    fontWeight: FontWeight.bold,
  );
}

TextStyle tertiaryContainerTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    color: Theme.of(context).colorScheme.tertiaryContainer,
  );
}

TextStyle tertiaryBoldContainerTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    color: Theme.of(context).colorScheme.tertiaryContainer,
    fontWeight: FontWeight.bold,
  );
}

TextStyle errorBoldTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: 25,
    color: Theme.of(context).colorScheme.error,
    fontWeight: FontWeight.bold,
  );
}

TextStyle errorTextStyle(BuildContext context) {
  return TextStyle(fontSize: 25, color: Theme.of(context).colorScheme.error);
}
