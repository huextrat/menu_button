import 'package:flutter/material.dart';
import 'package:menu_button/menu_button.dart';

class MenuButtonWithoutShowingSameSelectedIitem extends StatefulWidget {
  const MenuButtonWithoutShowingSameSelectedIitem({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  _MenuButtonWithoutShowingSameSelectedIitemState createState() =>
      _MenuButtonWithoutShowingSameSelectedIitemState();
}

class _MenuButtonWithoutShowingSameSelectedIitemState
    extends State<MenuButtonWithoutShowingSameSelectedIitem> {
  late String selectedKey;
  late String initialValue;

  List<String> keys = <String>[
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
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            'Usage of menu button without showing the same selected item',
            style: widget.theme.textTheme.headline2!.copyWith(
              fontSize: 18,
            ),
          ),
        ),
        MenuButton<String>(
          child: childButtonWithoutSameItem,
          items: keys,
          topDivider: true,
          showSelectedItemOnList: false,
          selectedItem: selectedKey,
          itemBuilder: (String value) => Container(
            height: 40,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
            child: Text(value),
          ),
          toggledChild: Container(
            child: childButtonWithoutSameItem,
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
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: const BorderRadius.all(
              Radius.circular(3.0),
            ),
          ),
          onMenuButtonToggle: (bool isToggle) {
            print(isToggle);
          },
        ),
      ],
    );
  }
}
