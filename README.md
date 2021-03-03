# menu_button

[![Pub Package](https://img.shields.io/pub/v/menu_button.svg?style=for-the-badge&color=blue)](https://pub.dartlang.org/packages/menu_button)
![License](https://img.shields.io/badge/license-MIT-blue.svg?style=for-the-badge&color=blue)

Flutter widget to display a popup menu button very simply and easily customizable.

## Resources

- [Documentation](https://pub.dev/documentation/menu_button/latest/menu_button/MenuButton-class.html)
- [Pub Package](https://pub.dev/packages/menu_button)
- [GitHub Repository](https://github.com/huextrat/menu_button)
- [Online Demo](https://appetize.io/app/w352kxbnz51c6pfvxrdvxcb3xw?device=nexus5&scale=100&orientation=landscape&osVersion=8.1&deviceColor=black)

## Installations

Add `menu_button: ^1.3.1` in your `pubspec.yaml` dependencies. And import it:

```dart
import 'package:menu_button/menu_button.dart';
```

## Usage

The widget has a lot of properties to customize it, we will see here the ones needed to get a "basic" menu button.

Firstly we have to declare a variable to keep the selected item (`selectedKey`) and a list that contains all the items we want to display in this menu button.

Here we will make a list of strings that we will call `keys` and that contains the values `Low`, `Medium` & `High`.

```dart
String selectedKey;

List<String> keys = <String>[
  'Low',
  'Medium',
  'High',
];
```

Now that we have these two elements we can start using the `MenuButton<T>` widget.

```dart
MenuButton<String>(
  child: normalChildButton,
  items: keys,
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
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey[300]),
    borderRadius: const BorderRadius.all(Radius.circular(3.0))
  ),
  onMenuButtonToggle: (bool isToggle) {
    print(isToggle);
  },
)
```

And finally here is an example of the `child` widget used for the MenuButton above:

```dart
final Widget normalChildButton = SizedBox(
  width: 93,
  height: 40,
  child: Padding(
    padding: const EdgeInsets.only(left: 16, right: 11),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          child: Text(selectedKey, overflow: TextOverflow.ellipsis)
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
```

Of course you can make your own according to your needs.

## Basic Parameters

| Parameter | Description |
|---|---|
| `child` | A widget to display the default button to trigger the menu button |
| `items` | The list that contains all values that you want to display on the menu button |
| `itemBuilder` | A widget to design each item of the menu button |
| `toggledChild` | Same as child but when the menu button is opened |
| `divider` | A custom divider between each items |
| `onItemSelected` | Function triggered when an item is selected |
| `decoration` | A custom decoration for menu button |
| `onMenuButtonToggle` | Function triggered when menu button is triggered (`true` if displayed, `false` if not) |

## More Parameters

| Parameter | Description |
|---|---|
| `scrollPhysics` | By default items are not scrollable (`NeverScrollableScrollPhysics`), add a ScrollPhysics to enable it, for instance `AlwaysScrollableScrollPhysics` |
| `popupHeight` | By default `popupHeight` is automatically calculated but if you need a custom height use this property |
| `crossTheEdge` | By default `false` you can set it to `true` if you want the button to expand |
| `edgeMargin` | By default `0` add a custom value to prevent the button to not touch the edge, check the example `edge_menu_button.dart` for more information |
| `showSelectedItemOnList` | By default `true`, set it to `false` if you don't want the selected items in the list |
| `label` | Add a widget to display a custom label as MaterialDesign on top of the button, check `label_menu_button.dart` for more information |
| `labelDecoration` | If you use a `label` you can set a custom `LabelDecoration` |
| `itemBackgroundColor` | By default `Colors.white` add custom Colors to customize the background of every items |
| `menuButtonBackgroundColor` | By default `Colors.white` add custom Colors to customize the background of the menu button |

---

For a more detail example please take a look at the `example` folder.

## Example

Menu button with 3 items:

<img src="https://raw.githubusercontent.com/huextrat/menu_button/master/example/new_example.gif" width="400" height="790">

---

If something is missing, feel free to open a ticket or contribute!
