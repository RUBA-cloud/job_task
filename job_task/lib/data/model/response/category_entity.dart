import 'package:json_annotation/json_annotation.dart';

part 'category_entity.g.dart';


// ============================================================================
// JSON CONVERTERS
// ============================================================================

int _intFromJson(dynamic value) {
  if (value == null) {
    return 0;
  }

  if (value is int) {
    return value;
  }

  if (value is num) {
    return value.toInt();
  }

  if (value is bool) {
    return value ? 1 : 0;
  }

  return int.tryParse(value.toString()) ?? 0;
}


int? _nullableIntFromJson(dynamic value) {
  if (value == null) {
    return null;
  }

  if (value is int) {
    return value;
  }

  if (value is num) {
    return value.toInt();
  }

  return int.tryParse(value.toString());
}


String _stringFromJson(dynamic value) {
  if (value == null) {
    return '';
  }

  return value.toString();
}


String? _nullableStringFromJson(dynamic value) {
  if (value == null) {
    return null;
  }

  return value.toString();
}


bool _boolFromJson(dynamic value) {
  if (value == null) {
    return false;
  }

  if (value is bool) {
    return value;
  }

  if (value is int) {
    return value == 1;
  }

  if (value is num) {
    return value != 0;
  }

  if (value is String) {
    final normalized = value.toLowerCase().trim();

    return normalized == 'true' ||
        normalized == '1';
  }

  return false;
}


double _doubleFromJson(dynamic value) {
  if (value == null) {
    return 0.0;
  }

  if (value is num) {
    return value.toDouble();
  }

  return double.tryParse(value.toString()) ?? 0.0;
}


// ============================================================================
// LIST CONVERTERS
// ============================================================================

List<String> _stringListFromJson(dynamic value) {
  if (value == null) {
    return <String>[];
  }

  if (value is! List) {
    return <String>[];
  }

  return value
      .where((item) => item != null)
      .map((item) => item.toString())
      .toList();
}


List<dynamic> _dynamicListFromJson(dynamic value) {
  if (value == null) {
    return <dynamic>[];
  }

  if (value is List) {
    return List<dynamic>.from(value);
  }

  return <dynamic>[];
}


List<CategoryDataDataProductsEntity>
_productsFromJson(dynamic value) {
  if (value == null) {
    return <CategoryDataDataProductsEntity>[];
  }

  if (value is! List) {
    return <CategoryDataDataProductsEntity>[];
  }

  return value
      .whereType<Map>()
      .map(
        (item) => CategoryDataDataProductsEntity.fromJson(
      Map<String, dynamic>.from(item),
    ),
  )
      .toList();
}


List<CategoryDataDataProductsImagesEntity>
_imagesFromJson(dynamic value) {
  if (value == null) {
    return <CategoryDataDataProductsImagesEntity>[];
  }

  if (value is! List) {
    return <CategoryDataDataProductsImagesEntity>[];
  }

  return value
      .whereType<Map>()
      .map(
        (item) =>
        CategoryDataDataProductsImagesEntity.fromJson(
          Map<String, dynamic>.from(item),
        ),
  )
      .toList();
}


List<CategoryDataDataProductsSizesEntity>
_sizesFromJson(dynamic value) {
  if (value == null) {
    return <CategoryDataDataProductsSizesEntity>[];
  }

  if (value is! List) {
    return <CategoryDataDataProductsSizesEntity>[];
  }

  return value
      .whereType<Map>()
      .map(
        (item) =>
        CategoryDataDataProductsSizesEntity.fromJson(
          Map<String, dynamic>.from(item),
        ),
  )
      .toList();
}


List<CategoryDataLinksEntity> _linksFromJson(dynamic value) {
  if (value == null) {
    return <CategoryDataLinksEntity>[];
  }

  if (value is! List) {
    return <CategoryDataLinksEntity>[];
  }

  return value
      .whereType<Map>()
      .map(
        (item) => CategoryDataLinksEntity.fromJson(
      Map<String, dynamic>.from(item),
    ),
  )
      .toList();
}


// ============================================================================
// CATEGORY RESPONSE
// ============================================================================

@JsonSerializable()
class CategoryEntity {
  final String status;

  final String message;

  final CategoryDataEntity data;

  const CategoryEntity({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CategoryEntity.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$CategoryEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CategoryEntityToJson(this);
}


// ============================================================================
// CATEGORY PAGINATION
// ============================================================================

@JsonSerializable()
class CategoryDataEntity {
  @JsonKey(
    name: 'current_page',
    fromJson: _intFromJson,
  )
  final int currentPage;

  @JsonKey(
    fromJson: _productsCategoryListFromJson,
  )
  final List<CategoryDataDataEntity> data;

  @JsonKey(
    name: 'first_page_url',
    fromJson: _stringFromJson,
  )
  final String firstPageUrl;

  @JsonKey(
    fromJson: _intFromJson,
  )
  final int from;

  @JsonKey(
    name: 'last_page',
    fromJson: _intFromJson,
  )
  final int lastPage;

  @JsonKey(
    name: 'last_page_url',
    fromJson: _stringFromJson,
  )
  final String lastPageUrl;

  @JsonKey(
    fromJson: _linksFromJson,
  )
  final List<CategoryDataLinksEntity> links;

  @JsonKey(
    name: 'next_page_url',
    fromJson: _nullableStringFromJson,
  )
  final String? nextPageUrl;

  @JsonKey(
    fromJson: _stringFromJson,
  )
  final String path;

  @JsonKey(
    name: 'per_page',
    fromJson: _intFromJson,
  )
  final int perPage;

  @JsonKey(
    name: 'prev_page_url',
    fromJson: _nullableStringFromJson,
  )
  final String? prevPageUrl;

  @JsonKey(
    fromJson: _intFromJson,
  )
  final int to;

  @JsonKey(
    fromJson: _intFromJson,
  )
  final int total;

  const CategoryDataEntity({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory CategoryDataEntity.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$CategoryDataEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CategoryDataEntityToJson(this);
}


// ============================================================================
// CATEGORY LIST CONVERTER
// ============================================================================

List<CategoryDataDataEntity>
_productsCategoryListFromJson(dynamic value) {
  if (value == null) {
    return <CategoryDataDataEntity>[];
  }

  if (value is! List) {
    return <CategoryDataDataEntity>[];
  }

  return value
      .whereType<Map>()
      .map(
        (item) => CategoryDataDataEntity.fromJson(
      Map<String, dynamic>.from(item),
    ),
  )
      .toList();
}


// ============================================================================
// CATEGORY
// ============================================================================

@JsonSerializable()
class CategoryDataDataEntity {
  @JsonKey(
    fromJson: _intFromJson,
  )
  final int id;

  @JsonKey(
    name: 'name_en',
    fromJson: _stringFromJson,
  )
  final String nameEn;

  @JsonKey(
    name: 'name_ar',
    fromJson: _stringFromJson,
  )
  final String nameAr;

  @JsonKey(
    fromJson: _nullableStringFromJson,
  )
  final String? image;

  @JsonKey(
    name: 'is_active',
    fromJson: _intFromJson,
  )
  final int isActive;

  @JsonKey(
    name: 'user_id',
    fromJson: _nullableIntFromJson,
  )
  final int? userId;

  @JsonKey(
    name: 'created_at',
    fromJson: _stringFromJson,
  )
  final String createdAt;

  @JsonKey(
    name: 'updated_at',
    fromJson: _stringFromJson,
  )
  final String updatedAt;

  @JsonKey(
    fromJson: _productsFromJson,
  )
  final List<CategoryDataDataProductsEntity> products;

  const CategoryDataDataEntity({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    this.image,
    required this.isActive,
    this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.products,
  });

  factory CategoryDataDataEntity.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$CategoryDataDataEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CategoryDataDataEntityToJson(this);
}


// ============================================================================
// PRODUCT
// ============================================================================

@JsonSerializable()
class CategoryDataDataProductsEntity {
  @JsonKey(
    fromJson: _intFromJson,
  )
  final int id;

  @JsonKey(
    name: 'name_en',
    fromJson: _stringFromJson,
  )
  final String nameEn;

  @JsonKey(
    name: 'name_ar',
    fromJson: _stringFromJson,
  )
  final String nameAr;

  @JsonKey(
    name: 'description_en',
    fromJson: _stringFromJson,
  )
  final String descriptionEn;

  @JsonKey(
    name: 'description_ar',
    fromJson: _stringFromJson,
  )
  final String descriptionAr;

  @JsonKey(
    fromJson: _stringFromJson,
  )
  final String price;

  @JsonKey(
    name: 'is_active',
    fromJson: _boolFromJson,
  )
  final bool isActive;

  @JsonKey(
    name: 'main_image',
    fromJson: _stringFromJson,
  )
  final String mainImage;

  @JsonKey(
    fromJson: _stringListFromJson,
  )
  final List<String> colors;

  @JsonKey(
    name: 'user_id',
    fromJson: _nullableIntFromJson,
  )
  final int? userId;

  @JsonKey(
    name: 'category_id',
    fromJson: _intFromJson,
  )
  final int categoryId;

  @JsonKey(
    name: 'type_id',
    fromJson: _intFromJson,
  )
  final int typeId;

  @JsonKey(
    name: 'created_at',
    fromJson: _stringFromJson,
  )
  final String createdAt;

  @JsonKey(
    name: 'updated_at',
    fromJson: _stringFromJson,
  )
  final String updatedAt;

  @JsonKey(
    name: 'deleted_at',
    fromJson: _nullableStringFromJson,
  )
  final String? deletedAt;

  @JsonKey(
    name: 'size_id',
    fromJson: _nullableIntFromJson,
  )
  final int? sizeId;

  @JsonKey(
    fromJson: _imagesFromJson,
  )
  final List<CategoryDataDataProductsImagesEntity> images;

  @JsonKey(
    fromJson: _sizesFromJson,
  )
  final List<CategoryDataDataProductsSizesEntity> sizes;

  @JsonKey(
    fromJson: _dynamicListFromJson,
  )
  final List<dynamic> additionals;

  final CategoryDataDataProductsCategoryEntity? category;

  final CategoryDataDataProductsTypeEntity? type;

  @JsonKey(
    fromJson: _dynamicListFromJson,
  )
  final List<dynamic> brands;

  const CategoryDataDataProductsEntity({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.price,
    required this.isActive,
    required this.mainImage,
    required this.colors,
    this.userId,
    required this.categoryId,
    required this.typeId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.sizeId,
    required this.images,
    required this.sizes,
    required this.additionals,
    this.category,
    this.type,
    required this.brands,
  });

  factory CategoryDataDataProductsEntity.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$CategoryDataDataProductsEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CategoryDataDataProductsEntityToJson(this);
}


// ============================================================================
// PRODUCT IMAGES
// ============================================================================

@JsonSerializable()
class CategoryDataDataProductsImagesEntity {
  @JsonKey(
    fromJson: _intFromJson,
  )
  final int id;

  @JsonKey(
    name: 'product_id',
    fromJson: _intFromJson,
  )
  final int productId;

  @JsonKey(
    name: 'image_path',
    fromJson: _stringFromJson,
  )
  final String imagePath;

  @JsonKey(
    name: 'created_at',
    fromJson: _stringFromJson,
  )
  final String createdAt;

  @JsonKey(
    name: 'updated_at',
    fromJson: _stringFromJson,
  )
  final String updatedAt;

  const CategoryDataDataProductsImagesEntity({
    required this.id,
    required this.productId,
    required this.imagePath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryDataDataProductsImagesEntity.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$CategoryDataDataProductsImagesEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CategoryDataDataProductsImagesEntityToJson(this);
}


// ============================================================================
// PRODUCT SIZES
// ============================================================================

@JsonSerializable()
class CategoryDataDataProductsSizesEntity {
  @JsonKey(
    fromJson: _intFromJson,
  )
  final int id;

  @JsonKey(
    name: 'name_en',
    fromJson: _stringFromJson,
  )
  final String nameEn;

  @JsonKey(
    name: 'name_ar',
    fromJson: _stringFromJson,
  )
  final String nameAr;

  @JsonKey(
    name: 'is_active',
    fromJson: _boolFromJson,
  )
  final bool isActive;

  @JsonKey(
    name: 'user_id',
    fromJson: _nullableIntFromJson,
  )
  final int? userId;

  @JsonKey(
    name: 'created_at',
    fromJson: _stringFromJson,
  )
  final String createdAt;

  @JsonKey(
    name: 'updated_at',
    fromJson: _stringFromJson,
  )
  final String updatedAt;

  @JsonKey(
    fromJson: _nullableStringFromJson,
  )
  final String? image;

  @JsonKey(
    fromJson: _stringFromJson,
  )
  final String descripation;

  @JsonKey(
    fromJson: _doubleFromJson,
  )
  final double price;

  final CategoryDataDataProductsSizesPivotEntity? pivot;

  const CategoryDataDataProductsSizesEntity({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.isActive,
    this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.image,
    required this.descripation,
    required this.price,
    this.pivot,
  });

  factory CategoryDataDataProductsSizesEntity.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$CategoryDataDataProductsSizesEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CategoryDataDataProductsSizesEntityToJson(this);
}


// ============================================================================
// SIZE PIVOT
// ============================================================================

@JsonSerializable()
class CategoryDataDataProductsSizesPivotEntity {
  @JsonKey(
    name: 'product_id',
    fromJson: _intFromJson,
  )
  final int productId;

  @JsonKey(
    name: 'size_id',
    fromJson: _intFromJson,
  )
  final int sizeId;

  const CategoryDataDataProductsSizesPivotEntity({
    required this.productId,
    required this.sizeId,
  });

  factory CategoryDataDataProductsSizesPivotEntity.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$CategoryDataDataProductsSizesPivotEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CategoryDataDataProductsSizesPivotEntityToJson(this);
}


// ============================================================================
// PRODUCT CATEGORY
// ============================================================================

@JsonSerializable()
class CategoryDataDataProductsCategoryEntity {
  @JsonKey(
    fromJson: _intFromJson,
  )
  final int id;

  @JsonKey(
    name: 'name_en',
    fromJson: _stringFromJson,
  )
  final String nameEn;

  @JsonKey(
    name: 'name_ar',
    fromJson: _stringFromJson,
  )
  final String nameAr;

  @JsonKey(
    fromJson: _nullableStringFromJson,
  )
  final String? image;

  @JsonKey(
    name: 'is_active',
    fromJson: _intFromJson,
  )
  final int isActive;

  @JsonKey(
    name: 'user_id',
    fromJson: _nullableIntFromJson,
  )
  final int? userId;

  @JsonKey(
    name: 'created_at',
    fromJson: _stringFromJson,
  )
  final String createdAt;

  @JsonKey(
    name: 'updated_at',
    fromJson: _stringFromJson,
  )
  final String updatedAt;

  const CategoryDataDataProductsCategoryEntity({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    this.image,
    required this.isActive,
    this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryDataDataProductsCategoryEntity.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$CategoryDataDataProductsCategoryEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CategoryDataDataProductsCategoryEntityToJson(this);
}


// ============================================================================
// PRODUCT TYPE
// ============================================================================

@JsonSerializable()
class CategoryDataDataProductsTypeEntity {
  @JsonKey(
    fromJson: _intFromJson,
  )
  final int id;

  @JsonKey(
    name: 'name_en',
    fromJson: _stringFromJson,
  )
  final String nameEn;

  @JsonKey(
    name: 'name_ar',
    fromJson: _stringFromJson,
  )
  final String nameAr;

  @JsonKey(
    name: 'is_active',
    fromJson: _boolFromJson,
  )
  final bool isActive;

  @JsonKey(
    name: 'user_id',
    fromJson: _nullableIntFromJson,
  )
  final int? userId;

  @JsonKey(
    name: 'created_at',
    fromJson: _stringFromJson,
  )
  final String createdAt;

  @JsonKey(
    name: 'updated_at',
    fromJson: _stringFromJson,
  )
  final String updatedAt;

  const CategoryDataDataProductsTypeEntity({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.isActive,
    this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryDataDataProductsTypeEntity.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$CategoryDataDataProductsTypeEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CategoryDataDataProductsTypeEntityToJson(this);
}


// ============================================================================
// PAGINATION LINKS
// ============================================================================

@JsonSerializable()
class CategoryDataLinksEntity {
  @JsonKey(
    fromJson: _nullableStringFromJson,
  )
  final String? url;

  @JsonKey(
    fromJson: _stringFromJson,
  )
  final String label;

  @JsonKey(
    fromJson: _nullableIntFromJson,
  )
  final int? page;

  @JsonKey(
    fromJson: _boolFromJson,
  )
  final bool active;

  const CategoryDataLinksEntity({
    this.url,
    required this.label,
    this.page,
    required this.active,
  });

  factory CategoryDataLinksEntity.fromJson(
      Map<String, dynamic> json,
      ) =>
      _$CategoryDataLinksEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CategoryDataLinksEntityToJson(this);
}