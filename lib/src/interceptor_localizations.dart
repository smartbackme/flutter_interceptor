

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InterceptorLocalizations {

  final Locale locale;

  InterceptorLocalizations(this.locale);

  Map<String, InterceptorString> values = {
    'en': EnInterceptorString(),
    'zh': ChInterceptorString(),
    'ja': JpInterceptorString(),
  };

  InterceptorString? get currentLocalization {
    if (values.containsKey(locale.languageCode)) {
      return values[locale.languageCode];
    }
    return values["en"];
  }

  static const InterceptorLocalizationsDelegate delegate = InterceptorLocalizationsDelegate();

  //为了使用方便，我们定义一个静态方法
  static InterceptorLocalizations? of(BuildContext context) {
    return Localizations.of<InterceptorLocalizations>(context, InterceptorLocalizations);
  }

  static InterceptorString getInterceptorString(BuildContext context) {
    return Localizations.of<InterceptorLocalizations>(context, InterceptorLocalizations)?.currentLocalization??EnInterceptorString();
  }


}


class InterceptorLocalizationsDelegate extends LocalizationsDelegate<InterceptorLocalizations> {

  const InterceptorLocalizationsDelegate();
  ///是否支持某个Local
  @override
  bool isSupported(Locale locale) {
    return [
      'en',
      'zh',
      'ja',
    ].contains(locale.languageCode);
  }
  @override
  Future<InterceptorLocalizations> load(Locale locale) {
    return SynchronousFuture<InterceptorLocalizations>(
        InterceptorLocalizations(locale));
  }


  @override
  bool shouldReload(covariant LocalizationsDelegate<InterceptorLocalizations> old) => false;

}



abstract class InterceptorString {



  String? simpleInterception;

  String? summary;

  String? request;
  String? response;
  String? copy;
  String? method;
  String? requestTime;
  String? responseTime;
  String? duration;

}

/// Simplified Chinese
class ChInterceptorString implements InterceptorString {

  @override
  String? copy = "复制请求";

  @override
  String? duration = "持续时间";

  @override
  String? method = "方法";

  @override
  String? request = "请求";

  @override
  String? requestTime = "请求时间";

  @override
  String? response = "响应";

  @override
  String? responseTime = "响应时间";

  @override
  String? simpleInterception = "简单拦截";

  @override
  String? summary = "概述";


}

// /// Traditional Chinese
// class TChInterceptorString implements InterceptorString {
//   @override
//   String? libDebugConsole = "調試模式：在開發階段，為了調試及測試方便，提供測試階段的環境切換，此頁面發佈後的線上環境不顯示。";
//
//   @override
//   String? libDebugInterception = "控制台";
//
//   @override
//   String? libDebugModeIntroduce = "網絡攔截";
//
// }

/// English
class EnInterceptorString implements InterceptorString {

  @override
  String? copy = "copy";

  @override
  String? duration = "duration";

  @override
  String? method = "method";

  @override
  String? request = "request";

  @override
  String? requestTime = "Request time";

  @override
  String? response = "response";

  @override
  String? responseTime = "Response time";

  @override
  String? simpleInterception = "Simple interception";

  @override
  String? summary = "summary";


}

/// Japanese
class JpInterceptorString implements InterceptorString {

  @override
  String? copy = "要求のコピー";

  @override
  String? duration = "持続時間";

  @override
  String? method = "方法";

  @override
  String? request = "リクエスト";

  @override
  String? requestTime = "リクエスト時間";

  @override
  String? response = "応答";

  @override
  String? responseTime = "レスポンス時間";

  @override
  String? simpleInterception = "単純ブロック";

  @override
  String? summary = "概要";

}