import 'package:flutter/material.dart';

extension AppColorExt on BuildContext {
  AppColor get colors => AppColor(); // context.colors
}

class AppColor {
  AppColor._init();

  static final AppColor _instance = AppColor._init();

  factory AppColor() => _instance;

  final Color white = const Color(0xFFFFFFFF); // "#FFFFFF"
  final Color black = const Color(0xFF000000); // "#000000"
  final Color backgroundLight = const Color(0xFFfafafa); // "#fafafa"
  final Color backgroundDark = const Color(0xFF0f0f0f); // "#0f0f0f"
  final Color transparent = const Color(0x00000000); // "#000000"

  //* Text
  final Color disabledText = const Color(0xFFD4D4D8); // "#D4D4D8"
  final Color bodyText = const Color(0xFF3F3F46); // "#3F3F46"
  final Color bodyHeadlineText = const Color(0xFF18181B); // "#18181B"
  final Color avatarBorderLight = const Color(0xFFC6D4F1); // "#C6D4F1"
  final Color avatarBackgroundLight = const Color(0xFFF9F5FF); // "#F9F5FF"

  final Color cardTextLight = const Color(0xFF71717A); // "#71717A"

  final Color notificationSwipeDarkBlueLight =
      const Color(0xFF363F72); // "#363F72"
  final Color notificationSwipeGreenLight =
      const Color(0xFF039855); // "#039855"

  final Color error = const Color(0xAAF04438); // "#F04438"

  //* backgrounds
  final Color otpInputBg = const Color(0xFFF9FAFB); // "#F9FAFB"
  final Color whatsappFilledBg = const Color(0xFF14b464); // "#14b464"
  final Color whatsappBg = const Color(0xFFedfcf2); // "#edfcf2"
  final Color uploadRxBg = const Color(0xFFf9f5ff); // "#f9f5ff"
  final Color uploadRxFilledBg = const Color(0xFF254edb); // "#254edb"
  final Color consultancyFilledBg = const Color(0xFFf06820); // "#f06820"
  final Color consultancyBg = const Color(0xFFfff6ee); // "#fff6ee"
  final Color orderInProcessingBg = const Color(0xFF254EDB); // "#816CFF"
  final Color orderPlacedBg = const Color(0xFF816CFF); // "#254EDB"
  final Color orderShippedBg = const Color(0xFFFEB052); // "#FEB052"
  final Color orderDeliveredBg = const Color(0xFF16B364); // "#16B364"
  final Color ordersCardBg = const Color(0xFFF9FAFB); // "#F9FAFB"
  final Color orderStatusCardBgErrorState =
      const Color(0xFFFFEAE9); // "#FFEAE9"
  final Color tooltipBg = const Color(0xFFFEF7E6); // "#FEF7E6"
  final Color uploadRxCheckoutBg = const Color(0xFFF0F5FF); // "#F0F5FF"
  final Color orderDetailCardBg = const Color(0xFFFEFBEA); // "#FEFBEA"

  //* border
  final Color borderColor = const Color(0xFFD2D6DB); // "#D2D6DB"
  final Color whatsappBorderColor = const Color(0xFFaaf0c4); // "#aaf0c4"
  final Color uploadRxBorderColor = const Color(0xFFc5d4f1); // "#c5d4f1"
  final Color consultancyBorderColor = const Color(0xFFf9dbaf); // "#f9dbaf"
  final Color wellthyBottomSheetBG = const Color(0xFFFF8701);

  final Color profileGradientBgLight = const Color(0xFFFFD786);
  final Color profileGradientBgDark = const Color(0xFFFBAE0B);

  //* Grey
  final Color grey = const Color(0xFF8c8c8c); // 500 // "#8c8c8c"
  final Color grey100 = const Color(0xFFf2f2f2); // "#f2f2f2"
  final Color grey150 = const Color(0xFFececec); // "#ececec"
  final Color grey200 = const Color(0xFFd9d9d9); // "#d9d9d9"
  final Color grey300 = const Color(0xFFbfbfbf); // "#bfbfbf"
  final Color grey400 = const Color(0xFFa6a6a6); // "#a6a6a6"
  final Color grey450 = const Color(0xFF727D88); // "#727D88"
  final Color grey500 = const Color(0xFF8c8c8c); // "#8c8c8c"
  final Color grey600 = const Color(0xFF737373); // "#737373"
  final Color grey650 = const Color(0xFF6F6F6F); // "#6F6F6F"
  final Color grey700 = const Color(0xFF595959); // "#595959"
  final Color grey800 = const Color(0xFF404040); // "#404040"
  final Color grey900 = const Color(0xFF262626); // "#262626"
  final Color grey950 = const Color(0xFF1a1a1a); // "#1a1a1a"


  //* Blue
  final Color blue = const Color(0xFF3b47de); // 500 // "#3b47de"
  final Color blue50 = const Color(0x80E9EBFB); // "#E9EBFB"
  final Color blue100 = const Color(0xffe9ebfb); // "#e9ebfb"
  final Color blue200 = const Color(0xFFbec2f4); // "#bec2f4"
  final Color blue300 = const Color(0xFF9299ec); // "#9299ec"
  final Color blue400 = const Color(0xFF6670e5); // "#6670e5"
  final Color blue450 = const Color(0xFF276BC7); // "#276BC7"
  final Color blue500 = const Color(0xFF3b47de); // "#3b47de"
  final Color blue600 = const Color(0xFF212ec4); // "#212ec4"
  final Color blue700 = const Color(0xFF1a2399); // "#1a2399"
  final Color blue800 = const Color(0xFF13196d); // "#13196d"
  final Color blue900 = const Color(0xFF0b0f41); // "#0b0f41"

  //* Red
  final Color red = const Color(0xFFef2941); // 500 // "#ef2941"
  final Color red100 = const Color(0xFFfde7ea); // "#fde7ea"
  final Color red200 = const Color(0xFFfab8c0); // "#fab8c0"
  final Color red300 = const Color(0xFFf68896); // "#f68896"
  final Color red400 = const Color(0xFFf3596c); // "#f3596c"
  final Color red500 = const Color(0xFFef2941); // "#ef2941"
  final Color red600 = const Color(0xFFd61028); // "#d61028"
  final Color red700 = const Color(0xFFa60c1f); // "#a60c1f"
  final Color red800 = const Color(0xFF770916); // "#770916"
  final Color red900 = const Color(0xFF47050d); // "#47050d"

  //* Green
  final Color green = const Color(0xFF5fba63); // 500 // "#5fba63"
  final Color green100 = const Color(0xFFedf7ee); // "#edf7ee"
  final Color green200 = const Color(0xFFcae8cb); // "#cae8cb"
  final Color green300 = const Color(0xFFa6d8a8); // "#a6d8a8"
  final Color green400 = const Color(0xFF83c985); // "#83c985"
  final Color green500 = const Color(0xFF5fba63); // "#5fba63"
  final Color green600 = const Color(0xFF45a049); // "#45a049"
  final Color green700 = const Color(0xFF367c39); // "#367c39"
  final Color green800 = const Color(0xFF275929); // "#275929"
  final Color green900 = const Color(0xFF173518); // "#173518"
  final Color greenLight = const Color(0x3363D6C0); //63D6C0

  // customColor
  final Color consultation = const Color(0xFF4485FD); // "#4485FD"
  final Color physician = const Color(0xFFA584FF); // "#A584FF"
  final Color vitals = const Color(0xFFFF7854); // "#FF7854"
  final Color hospital = const Color(0xFFFEA725); // "#FEA725"
  final Color medicines = const Color(0xFF00CC6A); // "#00CC6A"
  final Color labTest = const Color(0xFF00C9E4); // "#00C9E4"
  final Color findHelp = const Color(0xFFFD4444); // "#FD4444"
  final Color homeCare = const Color(0xFFFD44B3); // "#FD44B3"
  final Color labsPlaceholder = const Color(0xFFF3FEFF); // "#F3FEFF"
  final Color errorBannerColor = const Color(0xFFEC5454); // "#EC5454"
  final Color dividerColor = const Color(0xFFDEDEDE); // "#DEDEDE"
  final Color disabledBackgroundColor = const Color(0xFFF3F4F6); // "#F3F4F6"
  final Color inactiveTabColor = const Color(0xffA1A1AA); // "#A1A1AA"

  final Color homePageCardBorder = const Color(0xffC9C9C9); // "#C9C9C9"
  final Color homePageBackgroundColor = const Color(0xffFBFBFB); // "#FBFBFB"
  final Color appbarDividerColor = const Color(0xffC9C9C9); // "#C9C9C9"
  final Color copyTextColor = const Color(0xFFF04438); // "#E64B32"

  final Color homeCarouselOrderTrackingBg =
      const Color(0xffD3F8DF); // "#D3F8DF"
  final Color homeCarouselLabBg = const Color(0xffFCDDEC); // "#FCDDEC"
  final Color homeCarouselMedicineBg = const Color(0xffF0E1FF); // "#F0E1FF"
  final Color homeCarouselConsultationBg = const Color(0xffFEF3E7); // "#FEF3E7"
  final Color homeCarouselOffersBg = const Color(0xff53A06E); // "#53A06E"

  final Color homeCarouselOrderTrackingActionColor =
      const Color(0xff037145); // "#037145"
  final Color homeCarouselLabsActionColor =
      const Color(0xffEF5DA8); // "#EF5DA8"
  final Color homeCarouselPharmacyActionColor =
      const Color(0xff5F48E6); // "#5F48E6"
  final Color homeCarouselConsultationActionColor =
      const Color(0xffFE8235); // "#FE8235"

  final Color homeCarouselOrderTitleColor =
      const Color(0xff1C2A3A); // "#1C2A3A"
  final Color homeCarouselConsultTitleColor =
      const Color(0xff573926); // "#573926"
  final Color homeCarouselOrderSubTitleColor =
      const Color(0xff333A42); // "#333A42"

  final Color alertTextColor = const Color(0xFF232323); // "#232323"
  final Color labsGreenColor = const Color(0xFF00483D); // "#E64B32"

  final Color emojisVeryDisSatisfiedStartGradientColor =
      const Color(0xffFFBF1A);
  final Color emojisVeryDisSatisfiedEndGradientColor = const Color(0xffFF4080);

  final Color emojisDisSatisfiedAndNeutralStartGradientColor =
      const Color(0xff967CFD);
  final Color emojisDisSatisfiedAndNeutralEndGradientColor =
      const Color(0xff3177FF);

  final Color emojisVerySatisfiedAndSatisfiedStartGradientColor =
      const Color(0xffFF00FF);
  final Color emojisVerySatisfiedAndSatisfiedEndGradientColor =
      const Color(0xff3199FF);

  final Color blueButtonColor = const Color(0xff233159);
  final Color darkBlue = const Color(0xff0C2638); //0C2638
  final Color darkNavy = const Color(0xff111826); //111826

  final Color subscriptionBgColor = const Color(0xffCAE1E1);
  final Color subscriptionPrimaryButtonColor = const Color(0xff233159);
  final Color subscriptionPlanCardSelectionColor = const Color(0xff63D6C0);
  final Color subscriptionPlanBenefitsTextColor = const Color(0xff003865);

  final Color subscribeBannerInactiveBorderColor = const Color(0xffA5EBDE);
  final Color subscribeBannerActiveBorderColor = const Color(0xff65D2BE);
  final Color subscribePremiumTextColor = const Color(0xff1B3888);
  final Color subscribePremiumButtonInActiveColor = const Color(0xffA5EEE1);

  final Color darkGrayishBrown = const Color(0xff423C3C); //423C3C

  final Color vitalCardLightBlueBackgroundColor = const Color(0xffE9EDFB); //#E9EDFB
  final Color primaryBlue = const Color(0xFF254edb); // "#254edb"
  final Color vitalHeaderBackgroundColor = const Color(0xFFE9EDFB); //#E9EDFB
  final Color vitalCardLightGreyBackGround = const Color(0xFFEDEFF0);

}
