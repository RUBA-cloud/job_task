// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchEntity _$BranchEntityFromJson(Map<String, dynamic> json) => BranchEntity(
  json['status'] as String,
  json['message'] as String,
  BranchBranchesEntity.fromJson(json['branches'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BranchEntityToJson(BranchEntity instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'branches': instance.branches,
    };

BranchBranchesEntity _$BranchBranchesEntityFromJson(
  Map<String, dynamic> json,
) => BranchBranchesEntity(
  (json['current_page'] as num).toInt(),
  (json['data'] as List<dynamic>)
      .map((e) => BranchBranchesDataEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
  json['first_page_url'] as String,
  (json['from'] as num).toInt(),
  (json['last_page'] as num).toInt(),
  json['last_page_url'] as String,
  (json['links'] as List<dynamic>)
      .map((e) => BranchBranchesLinksEntity.fromJson(e as Map<String, dynamic>))
      .toList(),
  json['next_page_url'],
  json['path'] as String,
  (json['per_page'] as num).toInt(),
  json['prev_page_url'],
  (json['to'] as num).toInt(),
  (json['total'] as num).toInt(),
);

Map<String, dynamic> _$BranchBranchesEntityToJson(
  BranchBranchesEntity instance,
) => <String, dynamic>{
  'current_page': instance.currentPage,
  'data': instance.data,
  'first_page_url': instance.firstPageUrl,
  'from': instance.from,
  'last_page': instance.lastPage,
  'last_page_url': instance.lastPageUrl,
  'links': instance.links,
  'next_page_url': instance.nextPageUrl,
  'path': instance.path,
  'per_page': instance.perPage,
  'prev_page_url': instance.prevPageUrl,
  'to': instance.to,
  'total': instance.total,
};

BranchBranchesDataEntity _$BranchBranchesDataEntityFromJson(
  Map<String, dynamic> json,
) => BranchBranchesDataEntity(
  (json['id'] as num).toInt(),
  json['company_info_id'],
  json['name_en'] as String,
  json['name_ar'] as String,
  json['is_active'] as bool,
  json['phone'],
  json['email'] as String,
  json['address_en'] as String,
  json['address_ar'] as String,
  json['location'],
  json['image'],
  json['working_hours'],
  json['working_hours_from'] as String,
  json['working_hours_to'] as String,
  json['working_days'] as String,
  json['fax'],
  (json['user_id'] as num).toInt(),
  json['created_at'] as String,
  json['updated_at'] as String,
  (json['company_id'] as num).toInt(),
);

Map<String, dynamic> _$BranchBranchesDataEntityToJson(
  BranchBranchesDataEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'company_info_id': instance.companyInfoId,
  'name_en': instance.nameEn,
  'name_ar': instance.nameAr,
  'is_active': instance.isActive,
  'phone': instance.phone,
  'email': instance.email,
  'address_en': instance.addressEn,
  'address_ar': instance.addressAr,
  'location': instance.location,
  'image': instance.image,
  'working_hours': instance.workingHours,
  'working_hours_from': instance.workingHoursFrom,
  'working_hours_to': instance.workingHoursTo,
  'working_days': instance.workingDays,
  'fax': instance.fax,
  'user_id': instance.userId,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'company_id': instance.companyId,
};

BranchBranchesLinksEntity _$BranchBranchesLinksEntityFromJson(
  Map<String, dynamic> json,
) => BranchBranchesLinksEntity(
  json['url'],
  json['label'] as String,
  json['page'],
  json['active'] as bool,
);

Map<String, dynamic> _$BranchBranchesLinksEntityToJson(
  BranchBranchesLinksEntity instance,
) => <String, dynamic>{
  'url': instance.url,
  'label': instance.label,
  'page': instance.page,
  'active': instance.active,
};
