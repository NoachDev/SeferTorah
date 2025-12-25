import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _Controller extends Notifier<Widget?> {
  // BooksHub() : super({});
  @override
  build() => null;

  bool _showWidget = false;
  bool get showWidget => _showWidget;


  void exit(){
    state = null;
  }

  void show(Widget? element){
    state = element;
    _showWidget = true;
  }

  void hide(){
    state = null;
    _showWidget = false;
  }

}

final extendedController = NotifierProvider<_Controller, Widget?>(
  () => _Controller(),
);