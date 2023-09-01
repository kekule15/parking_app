import 'dart:io';
import 'dart:math';
import 'dart:ui';


import 'package:intl/intl.dart';
import 'package:parking_app/style/appColors.dart';

class AppHelpers {
  static const jsonParsingError = "An Error Occured!";

  
  static String greetingMessage() {
    final timeNow = DateTime.now().hour;

    if (timeNow < 12) {
      return 'Good Morning';
    } else if ((timeNow >= 12) && (timeNow < 16)) {
      return 'Good Afternoon';
    } else if ((timeNow >= 16) && (timeNow < 20)) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

 static String getCurrency() {
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
    return format.currencySymbol;
  }

  static String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  static String convertNamedDateDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MMM-yy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  static String generateUniqueReference() {
    var dateFormatter = DateFormat('ddMMyykkmmssss');
    try {
      return 'A${dateFormatter.format(DateTime.now())}${Random.secure().nextInt(10000)}';
    } catch (e) {
      return 'A${dateFormatter.format(DateTime.now())}${Random().nextInt(10000)}';
    }
  }

  static List<Map<String, dynamic>> getPaymentMethods() {
    return [
      {'duration': 'Monthly', 'value': 1},
      {'duration': 'Quarterly', 'value': 3},
    ];
  }

  static removeLeadingZeros(String input) {
    return input.replaceAll(RegExp(r'^0+(?=.)'), '');
  }

  static Map<String, dynamic> getCardColor(String? type) {
    type = type!.toLowerCase();
    if (type.contains("basic")) {
      return {
        'color': const Color(0xFF66110C),
        'stripe': const Color(0xFF66110C).withOpacity(0.3),
      };
    } else if (type.contains("standard")) {
      return {
        'color': const Color(0xFF005E72),
        'stripe': const Color(0xFF005E72).withOpacity(0.3),
      };
    } else if (type.contains("premium")) {
      return {
        'color': const Color(0xFFFFFFFF),
        'stripe': const Color(0xff4F5050).withOpacity(0.3),
      };
    } else if (type.contains("deluxe")) {
      return {
        'color': const Color(0xFF2D292A),
        'stripe': const Color(0xFF2D292A).withOpacity(0.3),
      };
    } else if (type.contains("plus")) {
      return {
        'color': const Color(0xFFBF871F),
        'stripe': const Color(0xffD39B34),
      };
    } else if (type.contains("exclusive")) {
      return {
        'color': const Color(0xFF000000),
        'stripe': const Color(0xff4F5050),
      };
    } else if (type.contains("ultra")) {
      return {
        'color': Color(AppColors.red.value),
        'stripe': const Color.fromARGB(255, 255, 255, 254).withOpacity(0.5),
      };
    } else if (type.contains("diamond")) {
      return {
        'color': const Color.fromARGB(249, 161, 161, 161),
        'stripe': const Color(0xff4F5050),
      };
    } else {
      return {
        'color': const Color(0xFF499F68),
        'stripe': const Color(0xff71BE8D).withOpacity(0.3),
      };
    }
  }

  static final currencyFormatter2 =
      NumberFormat.simpleCurrency(name: 'NGN', decimalDigits: 2);
  static final currencyFormatter0 =
      NumberFormat.simpleCurrency(name: 'NGN', decimalDigits: 0);
  static final normalFormatter = '₦${NumberFormat("#,###.##")
    ..minimumFractionDigits = 2
    ..maximumFractionDigits = 2}';
  static final largerNumberFormatter =
      NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
  //static final largerNumberFormatter = NumberFormat('##,###.00', "en_US");
}

extension StringHelpers on String {
  //!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
  bool get isPasswordValid => RegExp(
          r"""^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!#$%&'"()*+,-./:;<=>?@[\]^_`{|}~])[A-Za-z\d!#$%&'"()*+,-./:;<=>?@[\]^_`{|}~]{8,20}$""")
      .hasMatch(this);
  bool get passwordHasSmallLetters => RegExp(r"^(?=.[a-z])").hasMatch(this);
  bool get passwordHasCapitalLetters => RegExp(r"^(?=.[A-Z])").hasMatch(this);
  bool get passwordHasSymbols =>
      RegExp(r"^(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]").hasMatch(this);
  bool get passwordHasNumber => RegExp(r"^(?=.*\d){8,15}$").hasMatch(this);
  String toPascalCase() {
    //Some strinngs comes with double whitespace whichn breaks this code which is why i added the replace
    String text = replaceAll("  ", ' ');
    if (length < 1) {
      return this;
    } else {
      String temp = '';
      for (final String item in text.split(' ')) {
        temp +=
            "${item[0].toUpperCase()}${item.substring(1).toLowerCase()}${split(' ').indexOf(item) == split(' ').length - 1 ? '' : ' '}";
      }
      return temp;
    }
  }

  String maskMiddle() {
    final List<String> texts = split('');
    if (texts.length < 2) {
      return this;
    } else {
      String temp = '';
      int ind = 0;
      for (final String item in texts) {
        if (ind > 2 && ind < texts.length - 3) {
          temp += '*';
        } else {
          temp += item;
        }
        ind += 1;
      }
      return temp;
    }
  }

  // String maskEmail() {
  //   final List<String> texts = split('');

  //   final len = texts.indexOf("@");
  //   if (len < 5) {
  //     return this;
  //   } else {
  //     String temp = '';
  //     int ind = 0;
  //     for (final String item in texts) {
  //       if (ind >= 3 && ind < len - 2) {
  //         temp += '*';
  //       } else {
  //         temp += item;
  //       }
  //       ind += 1;
  //     }
  //     return temp;
  //   }
  // }

  String truncateEmail() {
    final List<String> texts = split('');
    if (texts.length < 8) {
      return this;
    } else {
      return '${substring(0, 4)}.......${substring(length - 10, length)}';
    }
  }

  String firstnLast4() {
    final List<String> texts = split('');
    if (texts.length < 8) {
      return this;
    } else {
      return '${substring(0, 4)}...${substring(length - 4, length)}';
    }
  }

  String last4() {
    final List<String> texts = split('');
    if (texts.length < 8) {
      return this;
    } else {
      return '*******${substring(length - 4, length)}';
    }
  }

  String toCardPan() {
    String text = this;
    final string = text.replaceAllMapped(
        RegExp(r".{4}"), (match) => "${match.group(0)}  ");
    return string;
  }

  String toCardExpiry() {
    String text = this;
    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != text.length) {
        buffer.write('/');
      }
    }
    return buffer.toString();
  }
}
