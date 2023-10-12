import 'package:fillogo/export.dart';
import 'package:fillogo/widgets/shild_icon_pinned.dart';

// ignore: must_be_immutable
class ProfilePhoto extends StatelessWidget {
  ProfilePhoto(
      {Key? key, required this.url, required this.height, required this.width,this.onTap})
      : super(key: key);
  String? url;
  double height;
  double width;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ShildIconCustomPainter(),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: height,
          width: width,
          color: AppConstants().ltWhite,
          child: Image.network(
            url ??
                'https://res.cloudinary.com/dmpfzfgrb/image/upload/v1680248743/fillogo/user_yxtelh.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
