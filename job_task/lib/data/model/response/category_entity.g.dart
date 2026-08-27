// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryEntity _$CategoryEntityFromJson(Map<String, dynamic> json) =>
    CategoryEntity(
      status: json['status'] as String,
      message: json['message'] as String,
      data: CategoryDataEntity.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryEntityToJson(CategoryEntity instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

CategoryDataEntity _$CategoryDataEntityFromJson(Map<String, dynamic> json) =>
    CategoryDataEntity(
      currentPage: _intFromJson(json['current_page']),
      data: _productsCategoryListFromJson(json['data']),
      firstPageUrl: _stringFromJson(json['first_page_url']),
      from: _intFromJson(json['from']),
      lastPage: _intFromJson(json['last_page']),
      lastPageUrl: _stringFromJson(json['last_page_url']),
      links: _linksFromJson(json['links']),
      nextPageUrl: _nullableStringFromJson(json['next_page_url']),
      path: _stringFromJson(json['path']),
      perPage: _intFromJson(json['per_page']),
      prevPageUrl: _nullableStringFromJson(json['prev_page_url']),
      to: _intFromJson(json['to']),
      total: _intFromJson(json['total']),
    );

Map<String, dynamic> _$CategoryDataEntityToJson(CategoryDataEntity instance) =>
    <String, dynamic>{
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

CategoryDataDataEntity _$CategoryDataDataEntityFromJson(
  Map<String, dynamic> json,
) => CategoryDataDataEntity(
  id: _intFromJson(json['id']),
  nameEn: _stringFromJson(json['name_en']),
  nameAr: _stringFromJson(json['name_ar']),
  image: _nullableStringFromJson(json['image']),
  isActive: _intFromJson(json['is_active']),
  userId: _nullableIntFromJson(json['user_id']),
  createdAt: _stringFromJson(json['created_at']),
  updatedAt: _stringFromJson(json['updated_at']),
  products: _productsFromJson(json['products']),
);

Map<String, dynamic> _$CategoryDataDataEntityToJson(
  CategoryDataDataEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'name_en': instance.nameEn,
  'name_ar': instance.nameAr,
  'image': instance.image,
  'is_active': instance.isActive,
  'user_id': instance.userId,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'products': instance.products,
};

CategoryDataDataProductsEntity _$CategoryDataDataProductsEntityFromJson(
  Map<String, dynamic> json,
) => CategoryDataDataProductsEntity(
  id: _intFromJson(json['id']),
  nameEn: _stringFromJson(json['name_en']),
  nameAr: _stringFromJson(json['name_ar']),
  descriptionEn: _stringFromJson(json['description_en']),
  descriptionAr: _stringFromJson(json['description_ar']),
  price: _stringFromJson(json['price']),
  isActive: _boolFromJson(json['is_active']),
  mainImage: _stringFromJson(json['main_image']),
  colors: _stringListFromJson(json['colors']),
  userId: _nullableIntFromJson(json['user_id']),
  categoryId: _intFromJson(json['category_id']),
  typeId: _intFromJson(json['type_id']),
  createdAt: _stringFromJson(json['created_at']),
  updatedAt: _stringFromJson(json['updated_at']),
  deletedAt: _nullableStringFromJson(json['deleted_at']),
  sizeId: _nullableIntFromJson(json['size_id']),
  images: _imagesFromJson(json['images']),
  sizes: _sizesFromJson(json['sizes']),
  additionals: _dynamicListFromJson(json['additionals']),
  category: json['category'] == null
      ? null
      : CategoryDataDataProductsCategoryEntity.fromJson(
          json['category'] as Map<String, dynamic>,
        ),
  type: json['type'] == null
      ? null
      : CategoryDataDataProductsTypeEntity.fromJson(
          json['type'] as Map<String, dynamic>,
        ),
  brands: _dynamicListFromJson(json['brands']),
);

Map<String, dynamic> _$CategoryDataDataProductsEntityToJson(
  CategoryDataDataProductsEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'name_en': instance.nameEn,
  'name_ar': instance.nameAr,
  'description_en': instance.descriptionEn,
  'description_ar': instance.descriptionAr,
  'price': instance.price,
  'is_active': instance.isActive,
  'main_image': instance.mainImage,
  'colors': instance.colors,
  'user_id': instance.userId,
  'category_id': instance.categoryId,
  'type_id': instance.typeId,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'deleted_at': instance.deletedAt,
  'size_id': instance.sizeId,
  'images': instance.images,
  'sizes': instance.sizes,
  'additionals': instance.additionals,
  'category': instance.category,
  'type': instance.type,
  'brands': instance.brands,
};

CategoryDataDataProductsImagesEntity
_$CategoryDataDataProductsImagesEntityFromJson(Map<String, dynamic> json) =>
    CategoryDataDataProductsImagesEntity(
      id: _intFromJson(json['id']),
      productId: _intFromJson(json['product_id']),
      imagePath: _stringFromJson(json['image_path']),
      createdAt: _stringFromJson(json['created_at']),
      updatedAt: _stringFromJson(json['updated_at']),
    );

Map<String, dynamic> _$CategoryDataDataProductsImagesEntityToJson(
  CategoryDataDataProductsImagesEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'product_id': instance.productId,
  'image_path': instance.imagePath,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};

CategoryDataDataProductsSizesEntity
_$CategoryDataDataProductsSizesEntityFromJson(Map<String, dynamic> json) =>
    CategoryDataDataProductsSizesEntity(
      id: _intFromJson(json['id']),
      nameEn: _stringFromJson(json['name_en']),
      nameAr: _stringFromJson(json['name_ar']),
      isActive: _boolFromJson(json['is_active']),
      userId: _nullableIntFromJson(json['user_id']),
      createdAt: _stringFromJson(json['created_at']),
      updatedAt: _stringFromJson(json['updated_at']),
      image: _nullableStringFromJson(json['image']),
      descripation: _stringFromJson(json['descripation']),
      price: _doubleFromJson(json['price']),
      pivot: json['pivot'] == null
          ? null
          : CategoryDataDataProductsSizesPivotEntity.fromJson(
              json['pivot'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$CategoryDataDataProductsSizesEntityToJson(
  CategoryDataDataProductsSizesEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'name_en': instance.nameEn,
  'name_ar': instance.nameAr,
  'is_active': instance.isActive,
  'user_id': instance.userId,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'image': instance.image,
  'descripation': instance.descripation,
  'price': instance.price,
  'pivot': instance.pivot,
};

CategoryDataDataProductsSizesPivotEntity
_$CategoryDataDataProductsSizesPivotEntityFromJson(Map<String, dynamic> json) =>
    CategoryDataDataProductsSizesPivotEntity(
      productId: _intFromJson(json['product_id']),
      sizeId: _intFromJson(json['size_id']),
    );

Map<String, dynamic> _$CategoryDataDataProductsSizesPivotEntityToJson(
  CategoryDataDataProductsSizesPivotEntity instance,
) => <String, dynamic>{
  'product_id': instance.productId,
  'size_id': instance.sizeId,
};

CategoryDataDataProductsCategoryEntity
_$CategoryDataDataProductsCategoryEntityFromJson(Map<String, dynamic> json) =>
    CategoryDataDataProductsCategoryEntity(
      id: _intFromJson(json['id']),
      nameEn: _stringFromJson(json['name_en']),
      nameAr: _stringFromJson(json['name_ar']),
      image: _nullableStringFromJson(json['image']),
      isActive: _intFromJson(json['is_active']),
      userId: _nullableIntFromJson(json['user_id']),
      createdAt: _stringFromJson(json['created_at']),
      updatedAt: _stringFromJson(json['updated_at']),
    );

Map<String, dynamic> _$CategoryDataDataProductsCategoryEntityToJson(
  CategoryDataDataProductsCategoryEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'name_en': instance.nameEn,
  'name_ar': instance.nameAr,
  'image': instance.image,
  'is_active': instance.isActive,
  'user_id': instance.userId,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};

CategoryDataDataProductsTypeEntity _$CategoryDataDataProductsTypeEntityFromJson(
  Map<String, dynamic> json,
) => CategoryDataDataProductsTypeEntity(
  id: _intFromJson(json['id']),
  nameEn: _stringFromJson(json['name_en']),
  nameAr: _stringFromJson(json['name_ar']),
  isActive: _boolFromJson(json['is_active']),
  userId: _nullableIntFromJson(json['user_id']),
  createdAt: _stringFromJson(json['created_at']),
  updatedAt: _stringFromJson(json['updated_at']),
);

Map<String, dynamic> _$CategoryDataDataProductsTypeEntityToJson(
  CategoryDataDataProductsTypeEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'name_en': instance.nameEn,
  'name_ar': instance.nameAr,
  'is_active': instance.isActive,
  'user_id': instance.userId,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};

CategoryDataLinksEntity _$CategoryDataLinksEntityFromJson(
  Map<String, dynamic> json,
) => CategoryDataLinksEntity(
  url: _nullableStringFromJson(json['url']),
  label: _stringFromJson(json['label']),
  page: _nullableIntFromJson(json['page']),
  active: _boolFromJson(json['active']),
);

Map<String, dynamic> _$CategoryDataLinksEntityToJson(
  CategoryDataLinksEntity instance,
) => <String, dynamic>{
  'url': instance.url,
  'label': instance.label,
  'page': instance.page,
  'active': instance.active,
};
