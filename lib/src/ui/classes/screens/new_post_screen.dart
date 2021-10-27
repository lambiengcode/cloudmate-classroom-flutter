import 'package:flutter/material.dart';

class NewPostScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
      ),
      body: Center(
        child: Text('New Post'),
      ),
    );
  }
}
