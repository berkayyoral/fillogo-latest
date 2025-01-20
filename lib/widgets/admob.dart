// import 'dart:io';

// import 'package:fillogo/export.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class AdMobWidget extends StatefulWidget {
//   const AdMobWidget({super.key});

//   @override
//   State<AdMobWidget> createState() => _AdMobWidgetState();
// }

// class _AdMobWidgetState extends State<AdMobWidget> {
//   late NativeAd _nativeAd;
//   bool _nativeAdIsLoaded = false;
//   final String _adUnitId = Platform.isAndroid
//       ? 'ca-app-pub-6811715094998587/7513040462'
//       : 'ca-app-pub-6811715094998587/4654394099';

//   @override
//   void initState() {
//     _nativeAd = NativeAd(
//         adUnitId: _adUnitId,
//         listener: NativeAdListener(
//           onAdLoaded: (ad) {
//             print('$NativeAd loaded.');
//             setState(() {
//               _nativeAdIsLoaded = true;
//             });
//           },
//           onAdFailedToLoad: (ad, error) {
//             // Dispose the ad here to free resources.

//             print('$NativeAd failedToLoad: $error');
//             ad.dispose();
//           },
//           // Called when a click is recorded for a NativeAd.
//           onAdClicked: (ad) {},
//           // Called when an impression occurs on the ad.
//           onAdImpression: (ad) {},
//           // Called when an ad removes an overlay that covers the screen.
//           onAdClosed: (ad) {},
//           // Called when an ad opens an overlay that covers the screen.
//           onAdOpened: (ad) {},
//           // For iOS only. Called before dismissing a full screen view
//           onAdWillDismissScreen: (ad) {},
//           // Called when an ad receives revenue value.
//           onPaidEvent: (ad, valueMicros, precision, currencyCode) {},
//         ),
//         request: const AdRequest(),
//         // Styling
//         nativeTemplateStyle: NativeTemplateStyle(
//             // Required: Choose a template.
//             templateType: TemplateType.medium,
//             // Optional: Customize the ad's style.
//             mainBackgroundColor: Colors.transparent,
//             cornerRadius: 20.0,
//             callToActionTextStyle: NativeTemplateTextStyle(
//                 textColor: AppConstants().ltWhite,
//                 backgroundColor: AppConstants().ltMainRed,
//                 style: NativeTemplateFontStyle.monospace,
//                 size: 16.0),
//             primaryTextStyle: NativeTemplateTextStyle(
//                 textColor: AppConstants().ltBlack,
//                 backgroundColor: AppConstants().ltWhite,
//                 style: NativeTemplateFontStyle.italic,
//                 size: 16.0),
//             secondaryTextStyle: NativeTemplateTextStyle(
//                 textColor: AppConstants().ltBlack,
//                 backgroundColor: AppConstants().ltWhite,
//                 style: NativeTemplateFontStyle.monospace,
//                 size: 16.0),
//             tertiaryTextStyle: NativeTemplateTextStyle(
//                 textColor: Colors.brown,
//                 backgroundColor: Colors.amber,
//                 style: NativeTemplateFontStyle.normal,
//                 size: 16.0)))
//       ..load();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _nativeAd.dispose();
//     print("DİSPOSEDD");
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _nativeAdIsLoaded
//         ? ConstrainedBox(
//             constraints: const BoxConstraints(
//               minWidth: 320, // minimum recommended width
//               minHeight: 320, // minimum recommended height
//               maxWidth: 400,
//               maxHeight: 400,
//             ),
//             child: AdWidget(ad: _nativeAd),
//           )
//         : const SizedBox();
//   }
// }
