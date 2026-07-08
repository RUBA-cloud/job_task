import 'package:injectable/injectable.dart';
import 'package:job_task/core/constants/api_constants.dart';
import 'package:job_task/data/model/response/product_entity.dart';
import 'package:retrofit/retrofit.dart';
@singleton                       // ✅ ADDED — registers ApiService in GetIt
@RestApi()
abstract class ApiService {
@GET(ApiConstants.products)
  Future<List<ProductEntity>>getProducts();
}