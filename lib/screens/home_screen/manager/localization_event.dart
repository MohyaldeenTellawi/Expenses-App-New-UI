import 'package:flutter/material.dart';

abstract class LocalizationEvent {
  const LocalizationEvent();
}

class ChaneLocalization extends LocalizationEvent {
  final Locale newLocal;

  const ChaneLocalization(this.newLocal) : super();
}
