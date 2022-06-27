import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './apps/apps.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;

  runApp(const ForDevApp());
}
