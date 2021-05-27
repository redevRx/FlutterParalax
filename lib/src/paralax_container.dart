import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paralax/src/paralax_type.dart';

///
///### Flutter Paralax Card
///``` dart
///
///```
///
class ParalaxContainer extends StatefulWidget {
  ParalaxContainer({
    Key? key,
    @required this.imageUrl,
    this.aspectRatio,
    this.radius,
    @required this.type = ParalaxType.ASSETS,
  }) : super(key: key);

  ///
  ///[imageUrl] url image on server
  ///
  ///``` dart
  ///final String? imageUrl;
  ///```
  final String? imageUrl;
  //
  ///[aspectRatio]
  /// The aspect ratio to attempt to use.
  /// The aspect ratio is expressed as a ratio of width to height.
  /// For example, a 16:9 width:height aspect ratio would have a value of 16.0/9.0.
  /// default is 16 / 16
  final double? aspectRatio;

  ///
  /// radius circle of image in paralax card
  /// default is 16
  final double? radius;

  // ///
  // /// ### Type Image
  // /// type images 0 => image assets
  // /// type images 1 => image network
  /// final int imageType;
  ///type image format
  ///local image , image network , image svg
  ///default value is ParalaxType.ASSETS
  final ParalaxType? type;

  ///
  ///[backgroundImageKey] key background image
  final GlobalKey backgroundImageKey = GlobalKey();

  ///
  @override
  _ParalaxContainerState createState() => _ParalaxContainerState();
}

class _ParalaxContainerState extends State<ParalaxContainer> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.aspectRatio ?? 16 / 16,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.radius ?? 16.0),
        child: Stack(
          children: [
            //
            _buildParallaxBackground(context),
            _buildGradient(),
            // _buildTitleAndSubtitle(),
          ],
        ),
      ),
    );
  }

  Widget _buildParallaxBackground(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context),
        listItemContext: context,
        backgroundImageKey: widget.backgroundImageKey,
      ),
      children: [
        //
        widget.type == ParalaxType.ASSETS
            ? Image.asset(
                widget.imageUrl!,
                key: widget.backgroundImageKey,
                fit: BoxFit.cover,
                scale: 1,
              )
            : widget.type == ParalaxType.NETWORK
                ? Image.network(
                    widget.imageUrl!,
                    key: widget.backgroundImageKey,
                    fit: BoxFit.cover,
                    scale: 1,
                  )
                : widget.type == ParalaxType.SVGNETWORK
                    ? SvgPicture.network(
                        widget.imageUrl!,
                        key: widget.backgroundImageKey,
                        fit: BoxFit.cover,
                      )
                    : SvgPicture.asset(
                        widget.imageUrl!,
                        key: widget.backgroundImageKey,
                        fit: BoxFit.cover,
                      ),
      ],
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.6, 0.95],
          ),
        ),
      ),
    );
  }
  //
  // //
  // Widget _buildTitleAndSubtitle() {
  //   return Positioned(
  //     left: 20,
  //     bottom: 20,
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           widget.name,
  //           style: const TextStyle(
  //             color: Colors.white,
  //             fontSize: 20,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         Text(
  //           widget.name,
  //           style: const TextStyle(
  //             color: Colors.white,
  //             fontSize: 14,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
//
}

class ParallaxFlowDelegate extends FlowDelegate {
  ParallaxFlowDelegate({
    @required this.scrollable,
    @required this.listItemContext,
    @required this.backgroundImageKey,
  }) : super(repaint: scrollable?.position);

  final ScrollableState? scrollable;
  final BuildContext? listItemContext;
  final GlobalKey? backgroundImageKey;

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(
      width: constraints.maxWidth,
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable!.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext!.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
        listItemBox.size.centerLeft(Offset.zero),
        ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final viewportDimension = scrollable!.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final backgroundSize =
        (backgroundImageKey!.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
      0,
      transform:
          Transform.translate(offset: Offset(0.0, childRect.top)).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}

class Parallax extends SingleChildRenderObjectWidget {
  Parallax({
    @required Widget? background,
  }) : super(child: background);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderParallax(scrollable: Scrollable.of(context)!);
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderParallax renderObject) {
    renderObject.scrollable = Scrollable.of(context)!;
  }
}

class ParallaxParentData extends ContainerBoxParentData<RenderBox> {}

class RenderParallax extends RenderBox
    with RenderObjectWithChildMixin<RenderBox>, RenderProxyBoxMixin {
  RenderParallax({
    @required ScrollableState? scrollable,
  }) : _scrollable = scrollable!;

  ScrollableState _scrollable;

  ScrollableState get scrollable => _scrollable;

  set scrollable(ScrollableState value) {
    if (value != _scrollable) {
      if (attached) {
        _scrollable.position.removeListener(markNeedsLayout);
      }
      _scrollable = value;
      if (attached) {
        _scrollable.position.addListener(markNeedsLayout);
      }
    }
  }

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);
    _scrollable.position.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    _scrollable.position.removeListener(markNeedsLayout);
    super.detach();
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! ParallaxParentData) {
      child.parentData = ParallaxParentData();
    }
  }

  @override
  void performLayout() {
    size = constraints.biggest;

    // Force the background to take up all available width
    // and then scale its height based on the image's aspect ratio.
    final background = child;
    final backgroundImageConstraints =
        BoxConstraints.tightFor(width: size.width);
    background!.layout(backgroundImageConstraints, parentUsesSize: true);

    // Set the background's local offset, which is zero.
    (background.parentData as ParallaxParentData).offset = Offset.zero;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // Get the size of the scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;

    // Calculate the global position of this list item.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final backgroundOffset =
        localToGlobal(size.centerLeft(Offset.zero), ancestor: scrollableBox);

    // Determine the percent position of this list item within the
    // scrollable area.
    final scrollFraction =
        (backgroundOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final background = child;
    final backgroundSize = background!.size;
    final listItemSize = size;
    final childRect =
        verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    // Paint the background.
    context.paintChild(
        background,
        (background.parentData as ParallaxParentData).offset +
            offset +
            Offset(0.0, childRect.top));
  }
}
