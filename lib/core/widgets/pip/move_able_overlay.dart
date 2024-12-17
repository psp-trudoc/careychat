import 'package:flutter/material.dart';
import 'package:carey/core/theme/app_colors.dart';
import 'package:carey/core/widgets/pip/flutter_in_app_pip.dart';

class MovableOverlay extends StatefulWidget {
  final PiPParams pipParams;
  final bool avoidKeyboard;
  final Widget? topWidget;
  final Widget? bottomWidget;

  // Exposed onTap event
  final void Function()? onTapTopWidget;

  const MovableOverlay({
    Key? key,
    this.avoidKeyboard = true,
    this.topWidget,
    this.bottomWidget,
    this.onTapTopWidget,
    this.pipParams = const PiPParams(),
  }) : super(key: key);

  @override
  MovableOverlayState createState() => MovableOverlayState();
}

class MovableOverlayState extends State<MovableOverlay>
    with TickerProviderStateMixin {
  late final AnimationController _toggleFloatingAnimationController;
  late final AnimationController _dragAnimationController;
  late PIPViewCorner _corner;
  Offset _dragOffset = Offset.zero;
  var _isDragging = false;
  var _isFloating = false;
  Widget? _bottomWidgetGhost;
  Map<PIPViewCorner, Offset> _offsets = {};
  final defaultAnimationDuration = const Duration(milliseconds: 200);
  Widget? bottomChild;

  double _scaleFactor = 1.0;
  double _baseScaleFactor = 1.0;

  @override
  void initState() {
    super.initState();
    _corner = widget.pipParams.initialCorner;
    _toggleFloatingAnimationController = AnimationController(
      duration: defaultAnimationDuration,
      vsync: this,
    );
    _dragAnimationController = AnimationController(
      duration: defaultAnimationDuration,
      vsync: this,
    );
    bottomChild = widget.bottomWidget;
  }

  @override
  void didUpdateWidget(covariant MovableOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isFloating) {
      _scaleFactor = 1;
      if (widget.topWidget == null || bottomChild == null) {
        _isFloating = false;
        _bottomWidgetGhost = oldWidget.bottomWidget;
        _toggleFloatingAnimationController.reverse().whenCompleteOrCancel(() {
          if (mounted) {
            setState(() => _bottomWidgetGhost = null);
          }
        });
      }
    } else {
      if (widget.topWidget != null && bottomChild != null) {
        _isFloating = true;
        _toggleFloatingAnimationController.forward();
      }
    }
  }

  void _updateCornersOffsets({
    required Size spaceSize,
    required Size widgetSize,
    required EdgeInsets windowPadding,
  }) {
    _offsets = _calculateOffsets(
      spaceSize: spaceSize,
      widgetSize: widgetSize,
      windowPadding: windowPadding,
    );
  }

  bool _isAnimating() {
    return _toggleFloatingAnimationController.isAnimating ||
        _dragAnimationController.isAnimating;
  }

  void _onPanUpdate(ScaleUpdateDetails details) {
    if (!_isDragging) return;
    setState(() {
      _dragOffset = _dragOffset.translate(
        details.focalPointDelta.dx,
        details.focalPointDelta.dy,
      );
    });
  }

  void _onPanEnd(ScaleEndDetails details) {
    if (!_isDragging) return;

    final nearestCorner = _calculateNearestCorner(
      offset: _dragOffset,
      offsets: _offsets,
    );
    setState(() {
      _corner = nearestCorner;
      _isDragging = false;
    });
    _dragAnimationController.forward().whenCompleteOrCancel(() {
      _dragAnimationController.value = 0;
      _dragOffset = Offset.zero;
    });
  }

  void _onPanStart(ScaleStartDetails details) {
    if (_isAnimating()) return;
    setState(() {
      _dragOffset = _offsets[_corner]!;
      _isDragging = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    var windowPadding = mediaQuery.padding;
    if (widget.avoidKeyboard) {
      windowPadding += mediaQuery.viewInsets;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final bottomWidget = bottomChild ?? _bottomWidgetGhost;
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        double? floatingWidth;
        floatingWidth = widget.topWidget != null
            ? widget.pipParams.pipWindowWidth * _scaleFactor
            : 0;
        double? floatingHeight;
        floatingHeight = widget.topWidget != null
            ? widget.pipParams.pipWindowHeight * _scaleFactor
            : 0;

        final floatingWidgetSize = Size(floatingWidth, floatingHeight);
        final fullWidgetSize = Size(width, height);

        _updateCornersOffsets(
          spaceSize: fullWidgetSize,
          widgetSize: floatingWidgetSize,
          windowPadding: windowPadding,
        );

        // Determine if PiP is in full screen
        final isFullScreen = widget.pipParams.pipWindowWidth >= width &&
            widget.pipParams.pipWindowHeight >= height;

        final calculatedOffset =
            isFullScreen ? Offset.zero : _offsets[_corner] ?? Offset.zero;

        return Stack(
          children: <Widget>[
            if (bottomWidget != null) Center(child: bottomWidget),
            if (widget.topWidget != null)
              AnimatedBuilder(
                animation: Listenable.merge([
                  _toggleFloatingAnimationController,
                  _dragAnimationController,
                ]),
                builder: (context, child) {
                  final animationCurve = CurveTween(
                    curve: Curves.easeInOutQuad,
                  );
                  final dragAnimationValue = animationCurve.transform(
                    _dragAnimationController.value,
                  );
                  final toggleFloatingAnimationValue = animationCurve.transform(
                    _toggleFloatingAnimationController.value,
                  );

                  final floatingOffset = _isDragging
                      ? _dragOffset
                      : Tween<Offset>(
                          begin: _dragOffset,
                          end: calculatedOffset,
                        ).transform(_dragAnimationController.isAnimating
                          ? dragAnimationValue
                          : toggleFloatingAnimationValue);
                  final width = isFullScreen
                      ? fullWidgetSize.width
                      : Tween<double>(
                          begin: fullWidgetSize.width,
                          end: floatingWidgetSize.width,
                        ).transform(toggleFloatingAnimationValue);
                  final height = isFullScreen
                      ? fullWidgetSize.height
                      : Tween<double>(
                          begin: fullWidgetSize.height,
                          end: floatingWidgetSize.height,
                        ).transform(toggleFloatingAnimationValue);

                  return Positioned(
                    left: floatingOffset.dx,
                    top: floatingOffset.dy,
                    child: GestureDetector(
                      onScaleStart: (!isFullScreen && widget.pipParams.movable)
                          ? _onScaleStart
                          : null,
                      onScaleEnd: (!isFullScreen && widget.pipParams.movable)
                          ? _onScaleEnd
                          : null,
                      onScaleUpdate: (!isFullScreen && widget.pipParams.movable)
                          ? _onScaleUpdate
                          : null,
                      onTap: widget.onTapTopWidget,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.25), // Shadow color
                              spreadRadius:
                                  2, // Spread radius for a subtle shadow
                              blurRadius:
                                  10, // Blur radius to soften the shadow
                              offset:
                                  Offset(0, 4), // Offset for shadow position
                            ),
                          ],
                          border: Border.all(
                            color: context.colors.grey300,
                          ),
                        ),
                        child: SizedBox(
                          width: width,
                          height: height,
                          child: child,
                        ),
                      ),
                    ),
                  );
                },
                child: widget.topWidget,
              ),
          ],
        );
      },
    );
  }

  void _onScaleStart(ScaleStartDetails details) {
    if (widget.pipParams.movable) {
      _onPanStart(details);
    }
    if (widget.pipParams.resizable) {
      _baseScaleFactor = _scaleFactor;
    }
  }

  void _onScaleEnd(ScaleEndDetails details) {
    if (widget.pipParams.movable) {
      _onPanEnd(details);
    }
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    if (widget.pipParams.movable) {
      _onPanUpdate(details);
    }
    if (widget.pipParams.resizable == false || details.scale == 1.0) {
      return;
    }
    if (details.scale * _baseScaleFactor * widget.pipParams.pipWindowWidth >
        widget.pipParams.maxSize.width) {
      return;
    }
    if (details.scale * _baseScaleFactor * widget.pipParams.pipWindowWidth <
        widget.pipParams.minSize.width) {
      return;
    }
    if (details.scale * _baseScaleFactor * widget.pipParams.pipWindowHeight >
        widget.pipParams.maxSize.height) {
      return;
    }
    if (details.scale * _baseScaleFactor * widget.pipParams.pipWindowHeight <
        widget.pipParams.minSize.height) {
      return;
    }
    _scaleFactor = (_baseScaleFactor * details.scale);
    setState(() {});
  }

  Map<PIPViewCorner, Offset> _calculateOffsets({
    required Size spaceSize,
    required Size widgetSize,
    required EdgeInsets windowPadding,
  }) {
    Offset getOffsetForCorner(PIPViewCorner corner) {
      final left = widget.pipParams.leftSpace + windowPadding.left;
      final top = widget.pipParams.topSpace + windowPadding.top;
      final right = spaceSize.width -
          widgetSize.width -
          windowPadding.right -
          widget.pipParams.rightSpace;
      final bottom = spaceSize.height -
          widgetSize.height -
          windowPadding.bottom -
          widget.pipParams.bottomSpace;

      switch (corner) {
        case PIPViewCorner.topLeft:
          return Offset(left, top);
        case PIPViewCorner.topRight:
          return Offset(right, top);
        case PIPViewCorner.bottomLeft:
          return Offset(left, bottom);
        case PIPViewCorner.bottomRight:
          return Offset(right, bottom);
        default:
          throw UnimplementedError();
      }
    }

    const corners = PIPViewCorner.values;
    final Map<PIPViewCorner, Offset> offsets = {};
    for (final corner in corners) {
      offsets[corner] = getOffsetForCorner(corner);
    }

    return offsets;
  }
}

class _CornerDistance {
  final PIPViewCorner corner;
  final double distance;

  _CornerDistance({
    required this.corner,
    required this.distance,
  });
}

PIPViewCorner _calculateNearestCorner({
  required Offset offset,
  required Map<PIPViewCorner, Offset> offsets,
}) {
  _CornerDistance calculateDistance(PIPViewCorner corner) {
    final distance = (offsets[corner]! - offset).distanceSquared;
    return _CornerDistance(
      corner: corner,
      distance: distance,
    );
  }

  final distances = PIPViewCorner.values.map(calculateDistance).toList();
  distances.sort((cd0, cd1) => cd0.distance.compareTo(cd1.distance));
  return distances.first.corner;
}
