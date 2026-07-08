import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/model/response/product_entity.dart';

abstract class HomePageRepo {

  Future<ApiResult<List<ProductEntity>>> getProducts();
}