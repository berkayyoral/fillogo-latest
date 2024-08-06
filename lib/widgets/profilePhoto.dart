import 'package:fillogo/export.dart';
import 'package:fillogo/widgets/shild_icon_pinned.dart';

// ignore: must_be_immutable
class ProfilePhoto extends StatelessWidget {
  ProfilePhoto(
      {Key? key,
      required this.url,
      required this.height,
      required this.width,
      this.onTap})
      : super(key: key);
  String url;
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
            url.isNotEmpty
                ? url
                : "https://firebasestorage.googleapis.com/v0/b/fillogo-8946b.appspot.com/o/users%2Fuser_yxtelh.png?alt=media&token=17ed0cd6-733e-4ee9-9053-767ce7269893",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
