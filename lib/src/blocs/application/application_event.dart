import 'package:flutter/material.dart';

abstract class ApplicationEvent {}

///Event setup application
class OnSetupApplication extends ApplicationEvent {
  final BuildContext context;
  OnSetupApplication({required this.context});
}
