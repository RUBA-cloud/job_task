import 'package:json_annotation/json_annotation.dart';

part 'branch_entity.g.dart';

@JsonSerializable()
class BranchEntity {
  final String status;
  final String message;
  final BranchBranchesEntity branches;

  BranchEntity(this.status, this.message, this.branches);

  factory BranchEntity.fromJson(Map<String, dynamic> json) =>
      _$BranchEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BranchEntityToJson(this);
}

@JsonSerializable()
class BranchBranchesEntity {
  @JsonKey(name: 'current_page')
  final int currentPage;
  final List<BranchBranchesDataEntity> data;
  @JsonKey(name: 'first_page_url')
  final String firstPageUrl;
  final int from;
  @JsonKey(name: 'last_page')
  final int lastPage;
  @JsonKey(name: 'last_page_url')
  final String lastPageUrl;
  final List<BranchBranchesLinksEntity> links;
  @JsonKey(name: 'next_page_url')
  final dynamic nextPageUrl;
  final String path;
  @JsonKey(name: 'per_page')
  final int perPage;
  @JsonKey(name: 'prev_page_url')
  final dynamic prevPageUrl;
  final int to;
  final int total;

  BranchBranchesEntity(
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  );

  factory BranchBranchesEntity.fromJson(Map<String, dynamic> json) =>
      _$BranchBranchesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BranchBranchesEntityToJson(this);
}

@JsonSerializable()
class BranchBranchesDataEntity {
  final int id;
  @JsonKey(name: 'company_info_id')
  final dynamic companyInfoId;
  @JsonKey(name: 'name_en')
  final String nameEn;
  @JsonKey(name: 'name_ar')
  final String nameAr;
  @JsonKey(name: 'is_active')
  final bool isActive;
  final dynamic phone;
  final String email;
  @JsonKey(name: 'address_en')
  final String addressEn;
  @JsonKey(name: 'address_ar')
  final String addressAr;
  final dynamic location;
  final dynamic image;
  @JsonKey(name: 'working_hours')
  final dynamic workingHours;
  @JsonKey(name: 'working_hours_from')
  final String workingHoursFrom;
  @JsonKey(name: 'working_hours_to')
  final String workingHoursTo;
  @JsonKey(name: 'working_days')
  final String workingDays;
  final dynamic fax;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @JsonKey(name: 'company_id')
  final int companyId;

  BranchBranchesDataEntity(
    this.id,
    this.companyInfoId,
    this.nameEn,
    this.nameAr,
    this.isActive,
    this.phone,
    this.email,
    this.addressEn,
    this.addressAr,
    this.location,
    this.image,
    this.workingHours,
    this.workingHoursFrom,
    this.workingHoursTo,
    this.workingDays,
    this.fax,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.companyId,
  );

  factory BranchBranchesDataEntity.fromJson(Map<String, dynamic> json) =>
      _$BranchBranchesDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BranchBranchesDataEntityToJson(this);
}

@JsonSerializable()
class BranchBranchesLinksEntity {
  final dynamic url;
  final String label;
  final dynamic page;
  final bool active;

  BranchBranchesLinksEntity(this.url, this.label, this.page, this.active);

  factory BranchBranchesLinksEntity.fromJson(Map<String, dynamic> json) =>
      _$BranchBranchesLinksEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BranchBranchesLinksEntityToJson(this);
}
