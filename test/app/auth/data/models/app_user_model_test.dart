import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_do/app/auth/data/models/app_user_model.dart';
import 'package:simple_do/app/auth/domain/entities/app_user.dart';

import '../../../../helpers/json_reader.dart';

const appUserModel = AppUserModel(
  id: 1,
  firstName: "Emily",
  lastName: "Johnson",
  gender: "female",
  email: "emily.johnson@x.dummyjson.com",
  username: "emilys",
  image: "https://dummyjson.com/icon/emilys/128",
  accessToken: '',
  refreshToken: '',
);

void main() {
  test(
    'AppUserModel is a subclass of AppUser',
    () async {
      // assert
      expect(appUserModel, isA<AppUser>());
    },
  );

  test(
    'Valid model from json',
    () async {
      // arrange
      final Map<String, dynamic> map =
          json.decode(readJson('helpers\\dummy_data\\dummy_user_response.json'));

      // act
      final result = AppUserModel.fromJson(map);

      // assert
      expect(result, equals(appUserModel));
    },
  );
}
