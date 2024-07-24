import 'package:flutter/cupertino.dart';


class ComBoBoxItemEntry<T>{
  ComBoBoxItemEntry(this.value, this.label, {this.child});

  final T value;
  final String  label;

  final Widget? child;
}