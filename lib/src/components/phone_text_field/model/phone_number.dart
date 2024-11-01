import '../helper/countries.dart';

class NumberTooLongException implements Exception {}

class NumberTooShortException implements Exception {}

class InvalidCharactersException implements Exception {}

class PhoneNumber {
  String countryISOCode;
  String countryCode;
  String number;

  PhoneNumber({
    required this.countryISOCode,
    required this.countryCode,
    required this.number,
  });

  factory PhoneNumber.fromCompleteNumber({required String completeNumber}) {
    if (completeNumber == "") {
      return PhoneNumber(countryISOCode: "", countryCode: "", number: "");
    }

    try {
      final Country country = getCountry(completeNumber);
      String number;
      if (completeNumber.startsWith('+')) {
        number = completeNumber
            .substring(1 + country.dialCode.length + country.regionCode.length);
      } else {
        number = completeNumber
            .substring(country.dialCode.length + country.regionCode.length);
      }
      return PhoneNumber(
        countryISOCode: country.code,
        countryCode: country.dialCode + country.regionCode,
        number: number,
      );
    } on InvalidCharactersException {
      rethrow;
    } on Exception {
      return PhoneNumber(countryISOCode: "", countryCode: "", number: "");
    }
  }

  bool isValidNumber() {
    final Country country = getCountry(completeNumber);
    if (number.length < country.minLength) {
      throw NumberTooShortException();
    }

    if (number.length > country.maxLength) {
      throw NumberTooLongException();
    }
    return true;
  }

  String get completeNumber {
    return countryCode + number;
  }

  static Country getCountry(String phoneNumber) {
    if (phoneNumber == "") {
      throw NumberTooShortException();
    }

    final validPhoneNumber = RegExp(r'^[+0-9]*[0-9]*$');

    if (!validPhoneNumber.hasMatch(phoneNumber)) {
      throw InvalidCharactersException();
    }
    print('GGG $phoneNumber');
    if (phoneNumber.startsWith('+')) {
      return countries.firstWhere(
        (country) => phoneNumber
            .substring(1)
            .startsWith(country.dialCode + country.regionCode),
      );
    }
    return countries.firstWhere(
      (country) {
        print("|| $phoneNumber | ${country.dialCode + country.regionCode}");
        return phoneNumber.startsWith(country.dialCode + country.regionCode);
      },
      // orElse: () => Country(
      //   name: "Kuwait",
      //   flag: "🇰🇼",
      //   code: "KW",
      //   dialCode: "965",
      //   minLength: 8,
      //   maxLength: 8,
      // ),
    );
  }

  @override
  String toString() =>
      'PhoneNumber(countryISOCode: $countryISOCode, countryCode: $countryCode, number: $number)';
}
