
import 'package:injectable/injectable.dart';
import 'package:job_task/core/di/api_result.dart';

import 'package:job_task/data/model/response/cart_entity.dart';
import 'package:job_task/domain/repository/home_page_repo.dart';

@singleton
class GetCartUseCase {
  final HomePageRepo homePageRepo;
  GetCartUseCase(this.homePageRepo);
  Future<ApiResult<List<CartEntity>>>execute()=>homePageRepo.getCartList();


}