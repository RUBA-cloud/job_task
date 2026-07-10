import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:job_task/core/constants/api_constants.dart';
import 'package:job_task/data/model/response/product_entity.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@singleton
@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiService {
  @factoryMethod
  factory ApiService(Dio dio) = _ApiService;

  @GET(ApiConstants.products)
  Future<List<ProductEntity>> getProducts();
}