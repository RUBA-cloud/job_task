import 'dart:io';

import 'package:dio/dio.dart';

class UpdateProfileRequest {
  final String? name;
  final String? email;
  final String? street;
  final String? address;
  final String? phone;
  final File? avatar;
  final String? avatarPath;
  final String? country;
  final String? city;

  const UpdateProfileRequest({
    this.name,
    this.email,
    this.street,
    this.address,
    this.phone,
    this.avatar,
    this.avatarPath,
    this.country,
    this.city,
  });

  Future<FormData> toFormData() async {
    final Map<String, dynamic> data = {};

    if (name != null) {
      data['name'] = name;
    }

    if (email != null) {
      data['email'] = email;
    }

    if (street != null) {
      data['street'] = street;
    }

    if (address != null) {
      data['address'] = address;
    }

    if (phone != null) {
      data['phone'] = phone;
    }

    if (avatarPath != null) {
      data['avatar_path'] = avatarPath;
    }

    if (country != null) {
      data['country'] = country;
    }

    if (city != null) {
      data['city'] = city;
    }

    if (avatar != null) {
      data['avatar'] = await MultipartFile.fromFile(
        avatar!.path,
        filename: avatar!.path.split('/').last,
      );
    }

    return FormData.fromMap(data);
  }
}