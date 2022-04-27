import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Widget child;
  final VoidCallback onPressed;

  const MyButton({
    Key key,
    this.width = 100.0,
    this.height = 30.0,
    this.color,
    @required this.child,
    @required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(topRight: Radius.circular(10)),
          child: GestureDetector(
        onTap: onPressed,
        child: Container(
            //  decoration: BoxDecoration(
            //               color: Color(0xff0061D4),
            //               borderRadius:
            //                   BorderRadius.only(topLeft: Radius.circular(10))),
          width: width,
          height: height,
          child: CustomPaint(
            painter: MyButtonPainter(
                color: color != null ? color : Color(0xff0061D4),),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}

class MyButtonPainter extends CustomPainter {
  final Color color;

  MyButtonPainter({this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = color;
    final double arrowDepth = size.height / 2;

    final Path path = Path();

    path.lineTo(size.width , 0.0);
   // path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width , size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(arrowDepth, size.height / 2);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
