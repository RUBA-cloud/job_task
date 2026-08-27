import 'package:job_task/data/model/response/create_order_entity.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderCreating extends OrderState {}

class OrderLocationChanged extends OrderState {
  final double lat;
  final double long;

  OrderLocationChanged({
    required this.lat,
    required this.long,
  });
}

class OrderCreated extends OrderState {
  final CreateOrderEntity order;

  OrderCreated(this.order);
}

class OrderFailed extends OrderState {
  final String message;

  OrderFailed(this.message);
}