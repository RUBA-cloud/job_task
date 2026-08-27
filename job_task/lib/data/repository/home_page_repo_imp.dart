import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/api_service/api_service.dart';
import 'package:job_task/data/model/request/cart/add_product_to_cart.dart';
import 'package:job_task/data/model/request/cart/remove_product_in_cart.dart';
import 'package:job_task/data/model/request/cart/update_cart_request.dart';
import 'package:job_task/data/model/request/faviorate/add_to_fav_request.dart';
import 'package:job_task/data/model/response/cart/add_product_to_cart_entity.dart';
import 'package:job_task/data/model/response/cart/cart_entity.dart';
import 'package:job_task/data/model/response/category_entity.dart';
import 'package:job_task/data/model/response/faviorate_entity.dart';
import 'package:job_task/data/model/response/remove_fav_entity.dart';
import 'package:job_task/domain/repository/home_page_repo.dart';

@Injectable(as: HomePageRepo)
class HomePageRepoImp implements HomePageRepo
{
  final ApiService _apiService;

  const HomePageRepoImp(this._apiService);

  @override
  Future<ApiResult<CategoryEntity>> getProducts() async
  {
    try {
      final res = await _apiService.getProducts();
      return Success(data: res);
    }
    on DioException catch (e) {
      return Failure(
        error: e,
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<ApiResult<AddProductToCartEntity>> addProductToCart(AddProductToCartRequest favRequest)async
{

  try
  {
    final res = await _apiService.addProductToCart(favRequest);
    return Success(data: res);
  }
  on DioException catch (e)
  {
    return Failure(
      error: e,
      statusCode: e.response?.statusCode,
    );
  }
  }

  @override
  Future<ApiResult<FaviorateEntity>> addProductToFav(
      AddToFavRequest favRequest) async
{
    try
{
      final res = await _apiService.addToFav(favRequest);
      return Success(data: res);
    }
on DioException catch (e)
{
      return Failure(
        error: e,
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<ApiResult<RemoveFavEntity>> deleteProductFromFav(int favId) async
  {
    try {
      final res = await _apiService.removeFromFav(favId);
      return Success(data: res);
    }
    on DioException catch (e) {
      return Failure(
        error: e,
        statusCode: e.response?.statusCode,
      );
    }
  }

  @override
  Future<ApiResult<CartEntity>> getCartList()async
{
  try {
    final res = await _apiService.loadCart();
    return Success(data: res);
  }
  on DioException catch (e) {
    return Failure(
      error: e,
      statusCode: e.response?.statusCode,
    );
  }
  }


  @override
  Future<ApiResult<FaviorateEntity>> getFavorites() async
  {
    try {
      final res = await _apiService.getToFav();
      return Success(data: res);
    } on DioException catch (e) {
      return
        Failure(error: e, statusCode: e.response?.statusCode,);
    }
  }

  @override
  Future<ApiResult<CartEntity>> removeProductFromCard(RemoveProductFromCartRequest removeCartRequest)async {
    try {
      final res = await _apiService.deleteProductInCart(removeCartRequest);
      return Success(data: res);
    } on DioException catch (e) {
      return
        Failure(error: e, statusCode: e.response?.statusCode,);
    }
  }

  @override
  Future<ApiResult<CartEntity>> updateProductQuantity(UpdateCartRequest updateRequest)async {
    try {
      final res = await _apiService.updateProductInCart(updateRequest);
      return Success(data: res);
    } on DioException catch (e) {
      return
        Failure(error: e, statusCode: e.response?.statusCode,);
    }
  }
  }

