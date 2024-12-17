import 'package:flutter/widgets.dart';

class RefreshWidgetTree extends StatefulWidget {
  const RefreshWidgetTree({super.key, required this.child});

  final Widget child;

  static void refreshApp(BuildContext context) {
    context
        .findAncestorStateOfType<_RefreshWidgetTreeState>()
        ?.refreshAppState();
  }

  @override
  _RefreshWidgetTreeState createState() => _RefreshWidgetTreeState();
}

class _RefreshWidgetTreeState extends State<RefreshWidgetTree> {
  Key key = UniqueKey();

  void refreshAppState() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
