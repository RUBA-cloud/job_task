class UpdateProfileRequest {
  final String? name;
  final String? email;
  final String? street;
  final String? address;
  final String? phone;
  final String? avatarPath;
  final String? country;
  final String? city;

  const UpdateProfileRequest({
    this.name,
    this.email,
    this.street,
    this.address,
    this.phone,
    this.avatarPath,
    this.country,
    this.city,
  });

  Map<String, dynamic> toJson() {
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

    return data;
  }
}