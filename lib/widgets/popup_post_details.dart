import 'package:fillogo/export.dart';
import 'package:fillogo/widgets/popup_view_widget.dart';

class PopupPostDetails extends StatelessWidget {
  PopupPostDetails({Key? key, required this.deletePost,this.deletePostOnTap}) : super(key: key);

  var isSavePost = false.obs;
  var removeThisUserPost = false.obs;
  var isReport = false.obs;
  bool deletePost;
  Function()? deletePostOnTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.all(12.w),
          width: Get.width,
          height: deletePost == true ? 220.h : 180.h,
          child: Column(
            children: [
              Divider(
                  indent: 150.w,
                  endIndent: 150.w,
                  height: 2.5.h,
                  thickness: 2.5.h,
                  color: AppConstants().ltBlack),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    isSavePost.value = !isSavePost.value;
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.w, top: 12.h),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          isSavePost.value == false
                              ? "assets/icons/dont-save-icon.svg"
                              : "assets/icons/save-icon.svg",
                          height: 32.h,
                          width: 32.w,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Gönderiyi Kaydet",
                                style: TextStyle(
                                    fontFamily: "Sfmedium",
                                    color: AppConstants().ltLogoGrey,
                                    fontSize: 14.sp),
                              ),
                              Text(
                                "Bu öğeyi daha sonrası için kaydet",
                                style: TextStyle(
                                    fontFamily: "Sflight",
                                    color: AppConstants().ltLogoGrey,
                                    fontSize: 12.sp),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const DummyBox15(),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    removeThisUserPost.value =
                        removeThisUserPost.value == false ? true : false;
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.w),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/eye-slash.svg"),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Wrap(
                            runSpacing: 2,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                removeThisUserPost.value == false
                                    ? 'Bu kişinin gönderilerini görmek istemiyorum'
                                    : 'Bu kişinin gönderilerini gizlendi',
                                style: TextStyle(
                                    fontFamily: "Sfmedium",
                                    color: AppConstants().ltLogoGrey,
                                    fontSize: 14.sp),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const DummyBox15(),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    isReport.value = true;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => ShowAllertDialogWidget(
                        button1Color: AppConstants().ltMainRed,
                        button1Height: 50.h,
                        button1IconPath: '',
                        button1Text: 'Tamam',
                        button1TextColor: AppConstants().ltWhite,
                        button1Width: Get.width,
                        buttonCount: 1,
                        discription1:
                            "Kullanıcı ve gönderi ile ilgili geri dönüşleriniz için teşekkür ederiz.",
                        discription2:
                            "En kısa sürede incelenip ve gerekli işlem yapılacaktır.",
                        onPressed1: () {
                          Get.back();
                        },
                        title: 'Şikayet Edildi',
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.w),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/information.svg"),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isReport.value == false
                                    ? 'Şikayet Et'
                                    : 'Şikayet Edildi',
                                style: TextStyle(
                                    fontFamily: "Sfmedium",
                                    color: AppConstants().ltMainRed,
                                    fontSize: 14.sp),
                              ),
                              Text(
                                "Bu gönderi zararlı,sahte veya spam",
                                style: TextStyle(
                                    fontFamily: "Sflight",
                                    color: AppConstants().ltMainRed,
                                    fontSize: 12.sp),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const DummyBox15(),
              Visibility(
                visible: deletePost,
                child: GestureDetector(
                  onTap: deletePostOnTap,
                  child: Padding(
                    padding: EdgeInsets.only(left: 12.w),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/close-icon.svg"),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Wrap(
                            runSpacing: 2,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                "Bu gönderiyi kaldır",
                                style: TextStyle(
                                    fontFamily: "Sfmedium",
                                    color: AppConstants().ltLogoGrey,
                                    fontSize: 14.sp),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
