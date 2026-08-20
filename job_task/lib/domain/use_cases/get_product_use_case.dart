
import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/data/model/response/category_entity.dart';

import 'package:job_task/domain/repository/home_page_repo.dart';

@singleton
 class GetProductUseCase {
  final HomePageRepo homePageRepo;
  GetProductUseCase(this.homePageRepo);
   Future<ApiResult<CategoryEntity>>execute()=>homePageRepo.getProducts();


 }