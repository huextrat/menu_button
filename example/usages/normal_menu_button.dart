import 'package:flutter/material.dart';
import 'package:menu_button/menu_button.dart';

class NormalMenuButton extends StatefulWidget {
  const NormalMenuButton({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  _NormalMenuButtonState createState() => _NormalMenuButtonState();
}

class _NormalMenuButtonState extends State<NormalMenuButton> {
  late String selectedKey;

  List<String> keys = <String>[
    'Low',
    'Medium',
    'High',
  ];

  @override
  void initState() {
    selectedKey = keys[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget normalChildButton = SizedBox(
      width: 93,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                selectedKey,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              width: 12,
              height: 17,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            'Normal usage of menu button',
            style: widget.theme.textTheme.headline2!.copyWith(
              fontSize: 18,
            ),
          ),
        ),
        MenuButton<String>(
          child: normalChildButton,
          items: keys,
          topDivider: true,
          itemBuilder: (String value) => Container(
            height: 40,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
            child: Text(value),
          ),
          toggledChild: Container(
            child: normalChildButton,
          ),
          divider: Container(
            height: 1,
            color: Colors.grey,
          ),
          onItemSelected: (String value) {
            setState(() {
              selectedKey = value;
            });
          },
          onMenuButtonToggle: (bool isToggle) {
            print(isToggle);
          },
        ),
      ],
    );
  }
}
