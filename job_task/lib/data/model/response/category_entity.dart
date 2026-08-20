import 'package:json_annotation/json_annotation.dart';

part 'category_entity.g.dart';

@JsonSerializable()
class CategoryEntity {
  final String status;
  final String message;
  final CategoryDataEntity data;

  CategoryEntity(this.status, this.message, this.data);

  factory CategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryEntityToJson(this);
}

@JsonSerializable()
class CategoryDataEntity {
  @JsonKey(name: 'current_page')
  final int currentPage;
  final List<CategoryDataDataEntity> data;
  @JsonKey(name: 'first_page_url')
  final String firstPageUrl;
  final int from;
  @JsonKey(name: 'last_page')
  final int lastPage;
  @JsonKey(name: 'last_page_url')
  final String lastPageUrl;
  final List<CategoryDataLinksEntity> links;
  @JsonKey(name: 'next_page_url')
  final dynamic nextPageUrl;
  final String path;
  @JsonKey(name: 'per_page')
  final int perPage;
  @JsonKey(name: 'prev_page_url')
  final dynamic prevPageUrl;
  final int to;
  final int total;

  CategoryDataEntity(
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

  factory CategoryDataEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDataEntityToJson(this);
}

@JsonSerializable()
class CategoryDataDataEntity {
  final int id;
  @JsonKey(name: 'name_en')
  final String nameEn;
  @JsonKey(name: 'name_ar')
  final String nameAr;
  final dynamic image;
  @JsonKey(name: 'is_active')
  final int isActive;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  final List<CategoryDataDataProductsEntity> products;

  CategoryDataDataEntity(
    this.id,
    this.nameEn,
    this.nameAr,
    this.image,
    this.isActive,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.products,
  );

  factory CategoryDataDataEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryDataDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDataDataEntityToJson(this);
}

@JsonSerializable()
class CategoryDataDataProductsEntity {
  final int id;
  @JsonKey(name: 'name_en')
  final String nameEn;
  @JsonKey(name: 'name_ar')
  final String nameAr;
  @JsonKey(name: 'description_en')
  final String descriptionEn;
  @JsonKey(name: 'description_ar')
  final String descriptionAr;
  final String price;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'main_image')
  final String mainImage;
  final List<String> colors;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'category_id')
  final int categoryId;
  @JsonKey(name: 'type_id')
  final int typeId;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @JsonKey(name: 'deleted_at')
  final dynamic deletedAt;
  @JsonKey(name: 'size_id')
  final int sizeId;
  final List<CategoryDataDataProductsImagesEntity> images;
  final List<CategoryDataDataProductsSizesEntity> sizes;
  final List<dynamic> additionals;
  final CategoryDataDataProductsCategoryEntity category;
  final CategoryDataDataProductsTypeEntity type;
  final List<dynamic> brands;

  CategoryDataDataProductsEntity(
    this.id,
    this.nameEn,
    this.nameAr,
    this.descriptionEn,
    this.descriptionAr,
    this.price,
    this.isActive,
    this.mainImage,
    this.colors,
    this.userId,
    this.categoryId,
    this.typeId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.sizeId,
    this.images,
    this.sizes,
    this.additionals,
    this.category,
    this.type,
    this.brands,
  );

  factory CategoryDataDataProductsEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryDataDataProductsEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDataDataProductsEntityToJson(this);
}

@JsonSerializable()
class CategoryDataDataProductsImagesEntity {
  final int id;
  @JsonKey(name: 'product_id')
  final int productId;
  @JsonKey(name: 'image_path')
  final String imagePath;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  CategoryDataDataProductsImagesEntity(
    this.id,
    this.productId,
    this.imagePath,
    this.createdAt,
    this.updatedAt,
  );

  factory CategoryDataDataProductsImagesEntity.fromJson(
    Map<String, dynamic> json,
  ) => _$CategoryDataDataProductsImagesEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CategoryDataDataProductsImagesEntityToJson(this);
}

@JsonSerializable()
class CategoryDataDataProductsSizesEntity {
  final int id;
  @JsonKey(name: 'name_en')
  final String nameEn;
  @JsonKey(name: 'name_ar')
  final String nameAr;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  final dynamic image;
  final String descripation;
  final int price;
  final CategoryDataDataProductsSizesPivotEntity pivot;

  CategoryDataDataProductsSizesEntity(
    this.id,
    this.nameEn,
    this.nameAr,
    this.isActive,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.descripation,
    this.price,
    this.pivot,
  );

  factory CategoryDataDataProductsSizesEntity.fromJson(
    Map<String, dynamic> json,
  ) => _$CategoryDataDataProductsSizesEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CategoryDataDataProductsSizesEntityToJson(this);
}

@JsonSerializable()
class CategoryDataDataProductsSizesPivotEntity {
  @JsonKey(name: 'product_id')
  final int productId;
  @JsonKey(name: 'size_id')
  final int sizeId;

  CategoryDataDataProductsSizesPivotEntity(this.productId, this.sizeId);

  factory CategoryDataDataProductsSizesPivotEntity.fromJson(
    Map<String, dynamic> json,
  ) => _$CategoryDataDataProductsSizesPivotEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CategoryDataDataProductsSizesPivotEntityToJson(this);
}

@JsonSerializable()
class CategoryDataDataProductsCategoryEntity {
  final int id;
  @JsonKey(name: 'name_en')
  final String nameEn;
  @JsonKey(name: 'name_ar')
  final String nameAr;
  final dynamic image;
  @JsonKey(name: 'is_active')
  final int isActive;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  CategoryDataDataProductsCategoryEntity(
    this.id,
    this.nameEn,
    this.nameAr,
    this.image,
    this.isActive,
    this.userId,
    this.createdAt,
    this.updatedAt,
  );

  factory CategoryDataDataProductsCategoryEntity.fromJson(
    Map<String, dynamic> json,
  ) => _$CategoryDataDataProductsCategoryEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CategoryDataDataProductsCategoryEntityToJson(this);
}

@JsonSerializable()
class CategoryDataDataProductsTypeEntity {
  final int id;
  @JsonKey(name: 'name_en')
  final String nameEn;
  @JsonKey(name: 'name_ar')
  final String nameAr;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'user_id')
  final int userId;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  CategoryDataDataProductsTypeEntity(
    this.id,
    this.nameEn,
    this.nameAr,
    this.isActive,
    this.userId,
    this.createdAt,
    this.updatedAt,
  );

  factory CategoryDataDataProductsTypeEntity.fromJson(
    Map<String, dynamic> json,
  ) => _$CategoryDataDataProductsTypeEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CategoryDataDataProductsTypeEntityToJson(this);
}

@JsonSerializable()
class CategoryDataLinksEntity {
  final dynamic url;
  final String label;
  final dynamic page;
  final bool active;

  CategoryDataLinksEntity(this.url, this.label, this.page, this.active);

  factory CategoryDataLinksEntity.fromJson(Map<String, dynamic> json) =>
      _$CategoryDataLinksEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDataLinksEntityToJson(this);
}
