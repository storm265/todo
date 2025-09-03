import 'package:flutter/material.dart';
import 'package:todo/screens/widgets/gradient_color.dart';

class BodyColors {
  static const emptyTaskBody = BoxDecoration(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10,
      )
    ],
    color: Colors.white,
  );

  static const gradientTaskBody = BoxDecoration(
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10,
      )
    ],
    gradient: LinearGradient(
      colors: Gradients.classicGradientLightMode,
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
  );

  static const schreduleBodyLight = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10,
      )
    ],
    gradient: LinearGradient(
      colors: Gradients.classicGradientLightMode,
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
  );

  static const schreduleBodyDark = BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    boxShadow: [
      BoxShadow(
        color: Colors.white24,
        blurRadius: 10,
      )
    ],
    gradient: LinearGradient(
      colors: Gradients.classicGradientDarkMode,
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
  );
}
