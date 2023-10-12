import 'package:fillogo/export.dart';

class FollowerPreview extends StatefulWidget {
  FollowerPreview(
      {Key? key,
      required this.isFollowing,
      required this.name,
      required this.nickName})
      : super(key: key);
  bool isFollowing;
  final String name;
  final String nickName;

  @override
  State<FollowerPreview> createState() => _FollowerPreviewState();
}

class _FollowerPreviewState extends State<FollowerPreview> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
          dense: true,
          leading: Image.network("https://picsum.photos/150"),
          title: Text(
            widget.name,
            style: TextStyle(
                fontFamily: "Sfsemibold",
                fontSize: 11,
                color: AppConstants().ltLogoGrey),
          ),
          subtitle: Text(
            widget.nickName,
            style: TextStyle(
                fontFamily: "Sfsemibold",
                fontSize: 11,
                color: AppConstants().ltDarkGrey),
          ),
          trailing: SizedBox(
            height: 25,
            width: widget.isFollowing ? 85 : 65,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              color: widget.isFollowing
                  ? AppConstants().ltDarkGrey
                  : AppConstants().ltMainRed,
              onPressed: () {
                setState(() {
                  widget.isFollowing = !widget.isFollowing;
                });
              },
              child: Text(
                widget.isFollowing ? "Takip Ediliyor" : "Takip Et",
                style: TextStyle(
                    fontFamily: "Sfbold",
                    fontSize: 8,
                    color: AppConstants().ltWhite),
              ),
            ),
          )),
    );
  }
}
