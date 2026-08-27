import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:job_task/core/constants/api_constants.dart';
import 'package:job_task/data/model/request/auth_request/forgot_password_request.dart';
import 'package:job_task/data/model/request/auth_request/login_request.dart';
import 'package:job_task/data/model/request/auth_request/register_request.dart';
import 'package:job_task/data/model/request/auth_request/update_profile_request.dart';
import 'package:job_task/data/model/request/cart/remove_product_in_cart.dart';
import 'package:job_task/data/model/request/cart/update_cart_request.dart';
import 'package:job_task/data/model/request/faviorate/add_to_fav_request.dart';
import 'package:job_task/data/model/request/order/create_order_request.dart';
import 'package:job_task/data/model/response/about_us_entity.dart';
import 'package:job_task/data/model/response/auth_entity/check_email_verified_entity.dart';
import 'package:job_task/data/model/response/auth_entity/forgot_password_entity.dart';
import 'package:job_task/data/model/response/auth_entity/login_entity.dart';
import 'package:job_task/data/model/response/auth_entity/register_entity.dart';
import 'package:job_task/data/model/response/auth_entity/update_profile_entity.dart';
import 'package:job_task/data/model/response/auth_entity/verify_email_entity.dart';
import 'package:job_task/data/model/response/branch_entity.dart';
import 'package:job_task/data/model/response/cart/add_product_to_cart_entity.dart';
import 'package:job_task/data/model/response/cart/cart_entity.dart';
import 'package:job_task/data/model/response/category_entity.dart';
import 'package:job_task/data/model/response/create_order_entity.dart';
import 'package:job_task/data/model/response/faviorate_entity.dart';
import 'package:job_task/data/model/response/remove_fav_entity.dart';
import 'package:retrofit/retrofit.dart';

import '../model/request/cart/add_product_to_cart.dart';
part 'api_service.g.dart';
@singleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  @factoryMethod
  factory ApiService(Dio dio) = _ApiService;

  @GET('categories')
  Future<CategoryEntity> getProducts();

  // Auth
  @POST('auth/login')
  Future<LoginEntity> login(
      @Body() LoginRequest login,
      );

  @POST('auth/forgot-password')
  Future<ForgotPasswordEntity> forgotPassword(
      @Body() SendEmailRequest forgotPassword,
      );

  @POST('auth/register')
  Future<RegisterEntity> register(
      @Body() RegisterRequest register,
      );

  @POST('auth/resend-verify-email')
  Future<VerifyEmailEntity> verifyEmail(
      @Body() SendEmailRequest verifyEmail,
      );

  @POST('auth/check-verify-email')
  Future<CheckEmailVerifiedEntity> checkIfVerifyEmail(
      @Body() SendEmailRequest verifyEmail,
      );

  // Company
  @GET('company-info')
  Future<AboutUsEntity> getAboutUS();

  @GET('company-branch')
  Future<BranchEntity> companyBranch();

  // Profile
  @POST('user/profile')
  Future<UpdateProfileEntity> updateProfile(
      @Body() UpdateProfileRequest profileRequest,
      );

  // Favorites
  @POST('add-faviorate')
  Future<FaviorateEntity> addToFav(
      @Body() AddToFavRequest addToFave,
      );

  @GET('faviorate_list')
  Future<FaviorateEntity> getToFav();

  @GET('remove-faviorate/{id}')
  Future<RemoveFavEntity> removeFromFav(@Path('id') int id,);

  @POST('add-to-cart')
  Future<AddProductToCartEntity> addProductToCart(@Body()AddProductToCartRequest request);
  @GET('cart')
  Future<CartEntity>loadCart();

  @POST('update-cart-quantity')
  Future<CartEntity> updateProductInCart(@Body()UpdateCartRequest request);
  @POST('remove-from-cart')
  Future<CartEntity> deleteProductInCart(@Body()RemoveProductFromCartRequest request);
@POST('make_order')
Future<CreateOrderEntity>makeOrder(@Body()CreateOrderRequest request);
}