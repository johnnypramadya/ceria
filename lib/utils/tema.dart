import 'package:flutter/material.dart';

class Tema {
  static Color _colorUtama = Color(0xFF5352EC);
  static Color _colorGrey = Color(0xFFF4F4F4);
  static Color _colorAqua = Color(0xFF57BDC9);

  Color get colorUtama => _colorUtama;

  Color get colorGrey => _colorGrey;

  Color get colorAqua => _colorAqua;

  // boxDecorationTextFormField
  static BoxDecoration _boxDecorationTextFormField = BoxDecoration(
      color: _colorGrey, borderRadius: BorderRadius.all(Radius.circular(28.0)));

  BoxDecoration get boxDecorationTextFormField => _boxDecorationTextFormField;

  // inputDecorationTextFormField
  static InputDecoration _inputDecorationTextFormField = InputDecoration(
    counterText: '',
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    enabledBorder: InputBorder.none,
    errorBorder: InputBorder.none,
    disabledBorder: InputBorder.none,
  );

  InputDecoration get inputDecorationTextFormField =>
      _inputDecorationTextFormField;
}
