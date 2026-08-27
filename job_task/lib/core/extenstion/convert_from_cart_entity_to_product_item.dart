import 'package:job_task/data/model/response/cart/cart_entity.dart';
import 'package:job_task/data/model/response/category_entity.dart';

extension CartDataEntityExtension on CartDataEntity {
  CategoryDataDataProductsEntity toCategoryProduct() {
    return CategoryDataDataProductsEntity(
      id: product.id,

      nameEn: product.nameEn,

      nameAr: product.nameAr,

      descriptionEn: product.descriptionEn,

      descriptionAr: product.descriptionAr,

      price: product.price,

      isActive: product.isActive,

      mainImage: product.mainImage,

      colors: List<String>.from(
        product.colors,
      ),

      userId: product.userId,

      categoryId: product.categoryId,

      typeId: product.typeId,

      createdAt: product.createdAt,

      updatedAt: product.updatedAt,

      deletedAt:
      product.deletedAt?.toString(),

      sizeId: size.id,

      // Cart API doesn't return product images
      // in the same structure as Category API.
      images: [
        CategoryDataDataProductsImagesEntity(
          id: 0,
          productId: product.id,
          imagePath: product.mainImage,
          createdAt: product.createdAt,
          updatedAt: product.updatedAt,
        ),
      ],

      // Convert the selected cart size into
      // the category size model.
      sizes: [
        CategoryDataDataProductsSizesEntity(
          id: size.id,

          nameEn: size.nameEn,

          nameAr: size.nameAr,

          isActive: size.isActive,

          userId: size.userId,

          createdAt: size.createdAt,

          updatedAt: size.updatedAt,

          image: size.image,

          descripation: size.descripation,

          price: size.price.toDouble(),

          pivot:
          CategoryDataDataProductsSizesPivotEntity(
            productId: product.id,
            sizeId: size.id,
          ),
        ),
      ],

      // Cart API currently doesn't provide
      // product additionals.
      additionals: List<dynamic>.from(
        cartAdditional,
      ),

      // Cart API doesn't provide the full
      // category object.
      category: null,

      // Cart API doesn't provide the full
      // type object.
      type: null,

      // Cart API doesn't provide brands.
      brands: const [],
    );
  }
}