import 'package:flutter/material.dart';

class TicketWidget extends StatefulWidget {
  const TicketWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.child,
    this.padding,
    this.margin,
    this.color = Colors.white,
    this.isCornerRounded = false,
    this.shadow,
    this.borderColor
  }) : super(key: key);

  final double width;
  final double height;
  final Widget child;
  final Color color;
  final bool isCornerRounded;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? shadow;
  final Color? borderColor;

  @override
  _TicketWidgetState createState() => _TicketWidgetState();
}

class _TicketWidgetState extends State<TicketWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(),
      child: AnimatedContainer(
        child: widget.child,
        duration: const Duration(seconds: 1),
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        margin: widget.margin,
        decoration: BoxDecoration(
            boxShadow: widget.shadow,
            color: widget.color,
            borderRadius: widget.isCornerRounded
                ? BorderRadius.circular(20.0)
                : BorderRadius.circular(10),
            // border: Border.all(color: widget?.borderColor)
        ),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    // path.addOval(
    //     Rect.fromCircle(center: Offset(0.0, size.height / 2), radius: 20.0));
    path.addOval(Rect.fromCircle(
        center: Offset(0.0, size.height*.125), radius: 5));
    path.addOval(Rect.fromCircle(
        center: Offset(0.0, size.height*.250), radius: 5));
    path.addOval(Rect.fromCircle(
        center: Offset(0.0, size.height*.375), radius: 5));
    path.addOval(Rect.fromCircle(
        center: Offset(0.0, size.height*.500), radius: 5));
    path.addOval(Rect.fromCircle(
        center: Offset(0.0, size.height*.625), radius: 5));
    path.addOval(Rect.fromCircle(
        center: Offset(0.0, size.height*.750), radius: 5));
    path.addOval(Rect.fromCircle(
        center: Offset(0.0, size.height*.875), radius: 5));
    // path.addOval(Rect.fromCircle(
    //     center: Offset(0.0, size.height*1), radius: 5));

    // path.addOval(Rect.fromCircle(
    //     center: Offset(size.width*.1, size.height / 2), radius: 10));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}