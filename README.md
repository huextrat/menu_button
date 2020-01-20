# menu_button

[![pub package](https://img.shields.io/pub/v/menu_button.svg?style=for-the-badge&color=blue)](https://pub.dartlang.org/packages/menu_button)

A popup menu button widget with handsome design and easy to use.

## Installation

Add `menu_button: ^0.1.0+1` in your `pubspec.yaml` dependencies. And import it:

```dart
import 'package:menu_button/menu_button.dart';
```

## How to use

Simply create a `MenuButton` widget and pass the required params:

```dart
MenuButton(
  child: button,// Widget displayed as the button
  items: items,// List of your items
  topDivider: true,
  itemBuilder: (value) => Container(
    width: 83,
    height: 40,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Text(value)
  ),// Widget displayed for each item
  toggledChild: Container(
    color: Colors.white,
    child: button,// Widget displayed as the button,
  ),
  divider: Container(
    height: 1,
    color: Colors.grey,
  ),
  onItemSelected: (value) {
    selectedItem = value;
    // Action when new item is selected
  },
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey[300]),
    borderRadius: const BorderRadius.all(Radius.circular(3.0)),
    color: Colors.white
  ),
)
```

Here is the widget used for the child, you can use your own custom widget it's just an example.

```dart
final Widget button = SizedBox(
  width: 83,
  height: 40,
  child: Padding(
    padding: const EdgeInsets.only(left: 16, right: 11),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Text(
            selectedItem,
            style: Colors.yellow,
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
            )
          )
        ),
      ],
    ),
  ),
);
```

For a more detail example please take a look at the `example` folder.

## Example

Menu button with 3 items:

<img src="https://raw.githubusercontent.com/huextrat/menu_button/master/example/example.gif" width="400" height="790">

## -

If something is missing, feel free to open a ticket or contribute!
