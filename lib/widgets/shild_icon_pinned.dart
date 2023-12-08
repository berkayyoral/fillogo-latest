import '../export.dart';

class ShildIconCustomPainter extends CustomClipper<Path> {
@override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.5000000, 0);
    path.cubicTo(
        size.width * 0.3266943,
        size.height * 0.1828576,
        size.width * 0.1088609,
        size.height * 0.1170068,
        size.width * 0.02160660,
        size.height * 0.06122441);
    path.lineTo(size.width * 0.02141000, size.height * 0.06221525);
    path.cubicTo(
        size.width * -0.01008983,
        size.height * 0.2209169,
        size.width * -0.08449887,
        size.height * 0.5958034,
        size.width * 0.4884151,
        size.height * 0.9920458);
    path.cubicTo(
        size.width * 0.4951245,
        size.height * 0.9966847,
        size.width * 0.5048755,
        size.height * 0.9966847,
        size.width * 0.5115830,
        size.height * 0.9920458);
    path.cubicTo(
        size.width * 1.084498,
        size.height * 0.5958034,
        size.width * 1.010091,
        size.height * 0.2209169,
        size.width * 0.9785906,
        size.height * 0.06221424);
    path.lineTo(size.width * 0.9783925, size.height * 0.06122339);
    path.cubicTo(
        size.width * 0.8911396,
        size.height * 0.1170056,
        size.width * 0.6733057,
        size.height * 0.1828576,
        size.width * 0.5000000,
        0);
    path.close();

    Paint paintFill = Paint()..style = PaintingStyle.fill;
    paintFill.color = Colors.black.withOpacity(1.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}