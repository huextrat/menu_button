## 1.3.1 - 2021-02-18

- Fix: add the item background color by default when the list is scrollable and no color is defined in `decoration` property

## 1.3.0 - 2021-02-17

- Add `itemBackgroundColor` & `menuButtonBackgroundColor` to enable ripple effect when you press an item
It's highly recommended to use them instead of the decoration color.

- `showSelectedItemOnList` property instead of `dontShowTheSameItemSelected` and the default value is now `true`

## 1.2.1 - 2020-06-16

Fix width when MenuButton is on Expanded widget

## 1.2.0+1 - 2020-06-16

MenuButton now display the decoration color everywhere

## 1.2.0 - 2020-06-16

Breaking change
- Default value of `dontShowTheSameItemSelected` is now `false`
If you are using it in previous version with its default value please do not forget to add the property to `true`

## 1.1.1 - 2020-05-19
Adjust offset depending on verticalMenuPadding

## 1.1.0 - 2020-05-18
Add menu button without showing the current item
Add a label property if needed

## 1.0.0 - 2020-05-08
Add crossEdge & edgeMargin configuration
Update example

## 0.2.1 - 2020-04-14 
Define scrollPhysics in MenuButton is now available

## 0.1.1+1 - 2020-03-25

Add `onMenuButtonToggle` callback to find out if menu button is open or not

## 0.1.0+1 - 2020-01-20

Fix README.md

## 0.1.0 - 2020-01-20

First version of `menu_button` available 

## 0.0.2 - 2020-01-20

Initial version