import 'package:flutter/material.dart';
import 'package:menu_button/menu_button.dart';

class MenuButtonLabel extends StatefulWidget {
  const MenuButtonLabel({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  _MenuButtonLabelState createState() => _MenuButtonLabelState();
}

class _MenuButtonLabelState extends State<MenuButtonLabel> {
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
            'Menu button usage with label',
            style: widget.theme.textTheme.headline2!.copyWith(
              fontSize: 18,
            ),
          ),
        ),
        MenuButton<String>(
          child: childButtonWithoutSameItem,
          items: keys,
          topDivider: true,
          selectedItem: selectedKey,
          label: const Text(
            'Label',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          labelDecoration: const LabelDecoration(
            verticalMenuPadding: 12,
            background: Colors.white,
            leftPosition: 6
          ),
          itemBuilder: (String value) => Container(
            height: 40,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
            child: Text(value),
          ),
          toggledChild: Container(
            child: childButtonWithoutSameItem,
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
          itemBackgroundColor: Colors.blue,
          menuButtonBackgroundColor: Colors.green,
          onMenuButtonToggle: (bool isToggle) {
            print(isToggle);
          },
        ),
      ],
    );
  }
}
