import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/core/extenstion/dio_exception_exstenstion.dart';
import 'package:job_task/data/api_service/api_service.dart';
import 'package:job_task/data/model/response/product_entity.dart';
import 'package:job_task/domain/repository/home_page_repo.dart';

@Injectable(as: HomePageRepo)
class HomePageRepoImp implements HomePageRepo {
  final ApiService _apiService;

  const HomePageRepoImp(this._apiService);

  @override
  Future<ApiResult<List<ProductEntity>>> getProducts() async {
    try {
      final res = await _apiService.getProducts();
      return Success(data: res);
    } on DioException catch (e) {
      return Failure(
        error: DioExceptionExtension.parseDioError(e),
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return Failure(error: e.toString());
    }
  }
}
