library menu_button;

import 'package:flutter/material.dart';

enum DropVerticalDirection { down, up }

/// Custom MenuButton to display a menu button following Material Design example
class MenuButton<T> extends StatefulWidget {
  const MenuButton(
      {required final this.child,
      required final this.items,
      required final this.itemBuilder,
      this.verticalDirection = DropVerticalDirection.down,
      final this.toggledChild,
      final this.divider = const Divider(
        height: 1,
        color: Colors.grey,
      ),
      final this.topDivider = true,
      final this.onItemSelected,
      final this.decoration,
      final this.onMenuButtonToggle,
      final this.scrollPhysics = const NeverScrollableScrollPhysics(),
      final this.popupHeight,
      final this.crossTheEdge = false,
      final this.edgeMargin = 0.0,
      final this.showSelectedItemOnList = true,
      final this.selectedItem,
      final this.label,
      final this.labelDecoration,
      final this.itemBackgroundColor = Colors.white,
      final this.menuButtonBackgroundColor = Colors.white})
      : assert(showSelectedItemOnList || selectedItem != null);

  /// Vertical direction of dropdown
  final DropVerticalDirection verticalDirection;

  /// Widget to display the default button to trigger the menu button
  final Widget child;

  /// Same as child but when the menu button is opened
  final Widget? toggledChild;

  /// A widget to design each item of the menu button
  final MenuItemBuilder<T> itemBuilder;

  /// Divider widget [default = true]
  final Widget divider;

  /// Top Divider visibility [default = Divider(height: 1, color: Colors.grey)]
  final bool topDivider;

  /// List of all items available on the menu
  final List<T> items;

  /// Action to do when an item is selected
  final MenuItemSelected<T>? onItemSelected;

  /// A custom decoration for menu button
  final BoxDecoration? decoration;

  /// Function triggered when menu button is triggered
  final MenuButtonToggleCallback? onMenuButtonToggle;

  /// Determines the scroll physics [default = NeverScrollableScrollPhysics()]
  final ScrollPhysics scrollPhysics;

  /// Force a define height for the popup view
  final double? popupHeight;

  /// Set it to true if you want the button to expand
  final bool crossTheEdge;

  /// Prevent the button to not touch the edge
  final double edgeMargin;

  /// Display or not the selected item on the list [default = true]
  final bool showSelectedItemOnList;

  /// Define the selected item
  final T? selectedItem;

  /// Add a label on top of the menu button as Material design
  final Text? label;

  /// Custom LabelDecoration if you use a label
  final LabelDecoration? labelDecoration;

  /// Background color of items [default = Colors.white]
  final Color itemBackgroundColor;

  /// Background color of menu button [default = Colors.white]
  final Color menuButtonBackgroundColor;

  @override
  State<StatefulWidget> createState() => _MenuButtonState<T>();
}

class _MenuButtonState<T> extends State<MenuButton<T>> {
  /// Keep an instance of old selected item if necessary
  T? oldItem;

  /// The current selected item
  late T selectedItem;

  /// Custom LabelDecoration if you use a label
  late LabelDecoration labelDecoration;

  /// Automatically calculated depending on the label [Text] widget
  late Size labelTextSize;

  /// Value containing the current state of the menu
  bool toggledMenu = false;

  /// The button used as [child]
  late Widget button;

  /// With of the button which is automatically calculated
  late double buttonWidth;

  /// A custom decoration for menu button
  late BoxDecoration decoration;

  void _updateLabelTextSize() {
    if (widget.label != null) {
      setState(
        () => labelTextSize = MenuButtonUtils.getTextSize(
          widget.label!.data,
          widget.label!.style,
        ),
      );
    }
  }

  /// Update the button and make it clickable
  void _updateButton() {
    setState(
      () => button = Container(
        decoration: decoration,
        child: Material(
          color: widget.menuButtonBackgroundColor,
          child: InkWell(
            borderRadius: decoration.borderRadius != null
                ? decoration.borderRadius as BorderRadius
                : null,
            child: Container(
              child: widget.child,
            ),
            onTap: togglePopup,
          ),
        ),
      ),
    );
  }

  /// Define the label decoration if label is used
  /// Default label decoration of parameter is not used or your custom label decoration
  void _updateLabelDecoration() {
    setState(
      () {
        if (widget.label == null && widget.labelDecoration == null) {
          labelDecoration = const LabelDecoration(
              leftPosition: 0,
              verticalMenuPadding: 0,
              background: Colors.transparent);
        } else if (widget.label != null && widget.labelDecoration == null) {
          labelDecoration = const LabelDecoration();
        } else if (widget.label != null) {
          labelDecoration = widget.labelDecoration!;
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setState(
      () {
        decoration = widget.decoration ??
            BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: const BorderRadius.all(
                Radius.circular(3.0),
              ),
            );
        button = Container(
          decoration: decoration,
          child: Material(
            color: widget.menuButtonBackgroundColor,
            child: InkWell(
              child: Container(
                child: widget.child,
              ),
              onTap: togglePopup,
            ),
          ),
        );
      },
    );
    _updateLabelDecoration();
    _updateLabelTextSize();
  }

  @override
  void didUpdateWidget(MenuButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateLabelTextSize();
    _updateLabelDecoration();
    _updateButton();
  }

  @override
  Widget build(BuildContext context) {
    return widget.label == null
        ? button
        : Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: labelDecoration.verticalMenuPadding,
                ),
                child: button,
              ),
              Positioned(
                top: labelDecoration.verticalMenuPadding,
                left: labelDecoration.leftPosition,
                child: Container(
                  width: labelTextSize.width + labelDecoration.leftPosition,
                  height: decoration.border?.top.width ?? 0,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
              Positioned(
                top: labelDecoration.verticalMenuPadding / 2,
                left: labelDecoration.leftPosition,
                child: Container(
                  color: labelDecoration.background,
                  width: labelTextSize.width + labelDecoration.leftPosition,
                  height: labelTextSize.height / 2,
                ),
              ),
              Positioned(
                top: labelDecoration.verticalMenuPadding,
                left: labelDecoration.leftPosition,
                child: Container(
                  color: labelDecoration.background,
                  width: labelTextSize.width + labelDecoration.leftPosition,
                  height: labelTextSize.height / 2,
                ),
              ),
              Positioned(
                top: (0 - labelTextSize.height / 2) +
                    labelDecoration.verticalMenuPadding,
                left: labelDecoration.leftPosition +
                    labelDecoration.leftPosition / 2,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  opacity: toggledMenu ? 0 : 1,
                  child: widget.label,
                ),
              ),
            ],
          );
  }

  /// The method to toggle the popup when button is pressed
  void togglePopup() {
    setState(() => toggledMenu = !toggledMenu);
    if (widget.onMenuButtonToggle != null) {
      widget.onMenuButtonToggle!(toggledMenu);
    }
    if (!widget.showSelectedItemOnList) {
      setState(() => selectedItem = widget.selectedItem!);
      MenuButtonUtils.showSelectedItemOnList(
          oldItem, selectedItem, widget.items);
    }

    final List<Widget> items = widget.items
        .map((T value) => _MenuItem<T>(
              value: value,
              child: widget.itemBuilder(value),
              itemBackgroundColor: widget.itemBackgroundColor,
            ))
        .toList();
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    buttonWidth = button.size.width;

    final RelativeRect position = () {
      final toDown = widget.verticalDirection == DropVerticalDirection.down;

      final baseRect = RelativeRect.fromRect(
        Rect.fromPoints(
            button.localToGlobal(Offset(0, labelDecoration.verticalMenuPadding),
                ancestor: overlay),
            button.localToGlobal(button.size.bottomLeft(Offset.zero),
                ancestor: overlay)),
        Offset.zero & overlay.size,
      );

      if (toDown) {
        return baseRect;
      } else {
        // center up
        return RelativeRect.fromLTRB(baseRect.right - button.size.width,
            baseRect.bottom, baseRect.left, baseRect.top);
      }
    }();

    if (items.isNotEmpty) {
      _togglePopup(
        context: context,
        position: position,
        items: items,
        toggledChild: widget.toggledChild,
        divider: widget.divider,
        topDivider: widget.topDivider,
        decoration: decoration,
        scrollPhysics: widget.scrollPhysics,
        popupHeight: widget.popupHeight,
        edgeMargin: widget.edgeMargin,
        crossTheEdge: widget.crossTheEdge,
        itemBackgroundColor: widget.itemBackgroundColor,
      ).then<void>((T? newValue) {
        setState(() => toggledMenu = !toggledMenu);
        if (widget.onMenuButtonToggle != null) {
          widget.onMenuButtonToggle!(toggledMenu);
        }
        if (!widget.showSelectedItemOnList && newValue != null) {
          setState(() => oldItem = selectedItem);
          setState(() => selectedItem = newValue);
        }
        if (mounted && newValue != null && widget.onItemSelected != null) {
          widget.onItemSelected!(newValue);
        }
      });
    }
  }

  Future<T?> _togglePopup({
    required BuildContext context,
    required RelativeRect position,
    required List<Widget> items,
    required BoxDecoration decoration,
    required bool topDivider,
    required bool crossTheEdge,
    required double edgeMargin,
    required Color itemBackgroundColor,
    required ScrollPhysics scrollPhysics,
    required Widget divider,
    double? popupHeight,
    Widget? toggledChild,
  }) =>
      Navigator.push(
        context,
        _MenuRoute<T>(
            direction: widget.verticalDirection,
            position: position,
            items: items,
            toggledChild: toggledChild,
            divider: divider,
            topDivider: topDivider,
            decoration: decoration,
            scrollPhysics: scrollPhysics,
            popupHeight: popupHeight,
            crossTheEdge: crossTheEdge,
            edgeMargin: edgeMargin,
            buttonWidth: buttonWidth,
            itemBackgroundColor: itemBackgroundColor),
      );
}

/// A custom [PopupRoute] which is pushed on [Navigator] when menu button is toggled
class _MenuRoute<T> extends PopupRoute<T> {
  _MenuRoute(
      {required final this.position,
      required final this.items,
      required final this.topDivider,
      required final this.decoration,
      required final this.crossTheEdge,
      required final this.edgeMargin,
      required final this.buttonWidth,
      required final this.itemBackgroundColor,
      required final this.scrollPhysics,
      required final this.divider,
      required this.direction,
      final this.popupHeight,
      final this.toggledChild});

  /// Position of the popup
  final RelativeRect position;

  /// List of all items available on the menu
  final List<Widget> items;

  /// Divider widget
  final Widget divider;

  /// Top Divider visibility
  final bool topDivider;

  /// A custom decoration for menu button
  final BoxDecoration decoration;

  /// Determines the scroll physics
  final ScrollPhysics scrollPhysics;

  /// Expand the button width or not
  final bool crossTheEdge;

  /// Prevent the button to not touch the edge
  final double edgeMargin;

  /// With of the button which is automatically calculated
  final double buttonWidth;

  /// Background color of items
  final Color itemBackgroundColor;
  final Widget? toggledChild;

  /// Force a define height for the popup view
  final double? popupHeight;

  /// Vertical direction of popup
  final DropVerticalDirection direction;

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Animation<double> createAnimation() => CurvedAnimation(
        parent: super.createAnimation(),
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) =>
      RotatedBox(
          quarterTurns: direction == DropVerticalDirection.up ? 2 : 0,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            removeLeft: true,
            removeRight: true,
            child: Builder(
              builder: (BuildContext context) {
                return CustomSingleChildLayout(
                  delegate: _MenuRouteLayout(position),
                  child: _Menu<T>(
                    route: this,
                    direction: direction,
                    scrollPhysics: scrollPhysics,
                    popupHeight: popupHeight,
                    crossTheEdge: crossTheEdge,
                    edgeMargin: edgeMargin,
                    buttonWidth: buttonWidth,
                    itemBackgroundColor: itemBackgroundColor,
                  ),
                );
              },
            ),
          ));
}

/// Positioning of the menu on the screen.
class _MenuRouteLayout extends SingleChildLayoutDelegate {
  _MenuRouteLayout(this.position);

  /// Rectangle of underlying button, relative to the overlay's dimensions.
  final RelativeRect position;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.biggest);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) =>
      Offset(position.left, position.top);

  @override
  bool shouldRelayout(_MenuRouteLayout oldDelegate) =>
      position != oldDelegate.position;
}

class _Menu<T> extends StatefulWidget {
  const _Menu({
    Key? key,
    required this.direction,
    required final this.route,
    required this.edgeMargin,
    required final this.crossTheEdge,
    required this.buttonWidth,
    required final this.itemBackgroundColor,
    required final this.scrollPhysics,
    final this.popupHeight,
  }) : super(key: key);

  final _MenuRoute<T> route;

  /// Determines the scroll physics
  final ScrollPhysics scrollPhysics;

  /// Expand the button width or not
  final bool crossTheEdge;

  /// Prevent the button to not touch the edge
  final double edgeMargin;

  /// With of the button which is automatically calculated
  final double buttonWidth;

  /// Background color of items
  final Color itemBackgroundColor;

  /// Force a define height for the popup view
  final double? popupHeight;

  /// Vertical direction of popup
  final DropVerticalDirection direction;

  @override
  __MenuState<T> createState() => __MenuState<T>();
}

class __MenuState<T> extends State<_Menu<T>> {
  final GlobalKey key = GlobalKey();

  /// The calculated width if [crossTheEdge] is set to true
  double? width;

  @override
  void initState() {
    super.initState();
    if (widget.crossTheEdge == true) {
      WidgetsBinding.instance!.addPostFrameCallback((Duration timeStamp) {
        final RenderBox renderBox =
            key.currentContext!.findRenderObject() as RenderBox;
        final Offset offset = renderBox.globalToLocal(Offset.zero);
        final double x = offset.dx.abs();
        final double screenWidth = MediaQuery.of(context).size.width;

        setState(() => width = screenWidth - x - widget.edgeMargin);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];

    if (widget.route.topDivider) {
      children.add(widget.route.divider);
    }

    for (int i = 0; i < widget.route.items.length; i += 1) {
      children.add(widget.route.items[i]);

      if (i < widget.route.items.length - 1) {
        children.add(widget.route.divider);
      }
    }

    final isToDown = widget.direction == DropVerticalDirection.down;

    final CurveTween opacity =
        CurveTween(curve: const Interval(0.0, 1.0 / 8.0));
    final CurveTween height = CurveTween(curve: const Interval(0.0, .9));
    final CurveTween shadow = CurveTween(curve: const Interval(0.0, 1.0 / 4.0));

    return Material(
      color: Colors.transparent,
      child: AnimatedBuilder(
        animation: widget.route.animation!,
        builder: (BuildContext context, Widget? child) => Opacity(
          opacity: opacity.evaluate(widget.route.animation!),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            key: key,
            width: width ?? widget.buttonWidth,
            height: widget.popupHeight,
            decoration: BoxDecoration(
              color: widget.route.decoration.color ??
                  widget.route.itemBackgroundColor,
              border: widget.route.decoration.border,
              borderRadius: widget.route.decoration.borderRadius,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Color.fromARGB(
                        (20 * shadow.evaluate(widget.route.animation!)).toInt(),
                        0,
                        0,
                        0),
                    offset: Offset(
                        0.0, 3.0 * shadow.evaluate(widget.route.animation!)),
                    blurRadius: 5.0 * shadow.evaluate(widget.route.animation!))
              ],
            ),
            child: RotatedBox(
              quarterTurns: !isToDown ? 2 : 0,
              child: ClipRRect(
                borderRadius: widget.route.decoration.borderRadius != null
                    ? widget.route.decoration.borderRadius as BorderRadius
                    : BorderRadius.zero,
                child: IntrinsicWidth(
                  child: SingleChildScrollView(
                    physics: widget.scrollPhysics,
                    child: ListBody(children: <Widget>[
                      if (isToDown)
                        _MenuButtonToggledChild(
                            child: widget.route.toggledChild ?? Container(),
                            itemBackgroundColor: widget.itemBackgroundColor),
                      Align(
                          alignment: AlignmentDirectional.topStart,
                          widthFactor: 1.0,
                          heightFactor:
                              height.evaluate(widget.route.animation!),
                          child: SingleChildScrollView(
                              child: ListBody(
                                  reverse: !isToDown, children: children))),
                      if (!isToDown)
                        _MenuButtonToggledChild(
                            child: widget.route.toggledChild ?? Container(),
                            itemBackgroundColor: widget.itemBackgroundColor),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Class to build the menu button toggled child (button display when menu button is toggled)
class _MenuButtonToggledChild extends StatelessWidget {
  const _MenuButtonToggledChild(
      {required final this.child, required this.itemBackgroundColor});

  /// Child [Widget] used for the menu button when toggled
  final Widget child;

  /// Background color of items
  final Color itemBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: itemBackgroundColor,
      child: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: child,
      ),
    );
  }
}

/// Class to build each menu item and make it clickable
class _MenuItem<T> extends StatelessWidget {
  const _MenuItem(
      {required this.value,
      required final this.child,
      required this.itemBackgroundColor});

  /// The value of the item
  final T value;

  /// The child [Widget] of the item
  final Widget child;

  /// The background color of the item
  final Color itemBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: itemBackgroundColor,
      child: InkWell(
          onTap: () => Navigator.of(context).pop<T>(value), child: child),
    );
  }
}

/// Class to define a custom decoration for a label
class LabelDecoration {
  const LabelDecoration({
    this.verticalMenuPadding = 12,
    this.leftPosition = 6,
    this.background = Colors.white,
  });

  /// Vertical padding of the label [default = 12]
  final double verticalMenuPadding;

  /// Padding on the left side of the label [default = 6]
  final double leftPosition;

  /// Background color of the label [default = Colors.white]
  final Color background;
}

/// Utils class with useful method
/// [getTextSize] - Calculate text size from a [Text] widget
/// [showSelectedItemOnList] - Create a new map without the selected item
class MenuButtonUtils {
  static Size getTextSize(String? text, TextStyle? style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  static Map<String, dynamic> showSelectedItemOnList(
      dynamic oldSelected, dynamic selectedItem, List<Object?> items) {
    if (oldSelected != selectedItem) {
      final Map<String, Object?> res = <String, Object?>{
        'oldSelected': oldSelected,
        'selectedItem': selectedItem,
        'items': items,
      };

      if (oldSelected == null) {
        items.removeWhere((dynamic element) => element == selectedItem);
        return res;
      }

      bool isOldSelectedAlready = false;
      items.forEach((dynamic element) {
        if (element == oldSelected) {
          isOldSelectedAlready = true;
        }
      });

      items.removeWhere((Object? element) => element == selectedItem);
      if (!isOldSelectedAlready) {
        items.add(oldSelected);
      }

      return res;
    }

    return <String, Object>{};
  }
}

typedef MenuButtonToggleCallback = void Function(bool isToggle);

typedef MenuItemBuilder<T> = Widget Function(T value);

typedef MenuItemSelected<T> = void Function(T value);
