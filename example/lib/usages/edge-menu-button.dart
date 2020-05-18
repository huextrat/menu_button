import 'package:flutter/material.dart';
import 'package:menu_button/menu_button.dart';

class EdgeMenuButton extends StatefulWidget {
  const EdgeMenuButton({
    Key key,
    @required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  _EdgeMenuButtonState createState() => _EdgeMenuButtonState();
}

class _EdgeMenuButtonState extends State<EdgeMenuButton> {
  String selectedKey;

  List<String> keys = [
    'Lorem ipsum',
    'Lorem ipsum dolor sit amet',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
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
            SizedBox(
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
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            'Menu button not crossing the edge',
            style: widget.theme.textTheme.headline2.copyWith(
              fontSize: 18,
            ),
          ),
        ),
        MenuButton(
          child: normalChildButton,
          items: keys,
          topDivider: true,
          crossTheEdge: true,
          dontShowTheSameItemSelected: false,
          // Use edge margin when you want the menu button don't touch in the edges
          edgeMargin: 12,
          itemBuilder: (value) => Container(
            height: 40,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          toggledChild: Container(
            color: Colors.white,
            child: normalChildButton,
          ),
          divider: Container(
            height: 1,
            color: Colors.grey,
          ),
          onItemSelected: (value) {
            setState(() {
              selectedKey = value;
            });
          },
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]),
              borderRadius: const BorderRadius.all(
                Radius.circular(3.0),
              ),
              color: Colors.white),
          onMenuButtonToggle: (isToggle) {
            print(isToggle);
          },
        ),
      ],
    );
  }
}
