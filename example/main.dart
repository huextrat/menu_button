import 'package:flutter/material.dart';

import './usages/edge_menu_button.dart';
import './usages/label_menu_button.dart';
import './usages/menu_button_without_current.dart';
import './usages/normal_menu_button.dart';
import './usages/scroll_menu_button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu Button Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Menu Button Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: NormalMenuButton(
                  theme: theme,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ScrollPhysicsMenuButton(
                  theme: theme,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: EdgeMenuButton(
                  theme: theme,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: MenuButtonWithoutShowingSameSelectedIitem(
                  theme: theme,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: MenuButtonLabel(
                  theme: theme,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
