import 'package:flutter/material.dart';
import 'package:menu_button/menu_button.dart';

class MenuButtonLabel extends StatefulWidget {
  const MenuButtonLabel({
    Key key,
    @required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  _MenuButtonLabelState createState() => _MenuButtonLabelState();
}

class _MenuButtonLabelState extends State<MenuButtonLabel> {
  String selectedKey;
  String initialValue;

  List<String> keys = [
    'Low',
    'Medium',
    'High',
  ];

  @override
  void initState() {
    initialValue = keys[0];
    selectedKey = keys[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget childButtonWithoutSameItem = Container(
      padding: const EdgeInsets.only(left: 16, right: 11),
      width: 93,
      height: 40,
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
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            'Menu button usage with label',
            style: widget.theme.textTheme.headline2.copyWith(
              fontSize: 18,
            ),
          ),
        ),
        MenuButton(
          child: childButtonWithoutSameItem,
          items: keys,
          topDivider: true,
          dontShowTheSameItemSelected: true,
          selectedItem: selectedKey,
          label: Text(
            'Label',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          labelDecoration: LabelDecoration(
            verticalMenuPadding: 12,
            // background: Colors.red
          ),
          itemBuilder: (value) => Container(
            height: 40,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
            child: Text(value),
          ),
          toggledChild: Container(
            color: Colors.white,
            child: childButtonWithoutSameItem,
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
            color: Colors.white,
          ),
          onMenuButtonToggle: (isToggle) {
            print(isToggle);
          },
        ),
      ],
    );
  }
}
