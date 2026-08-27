import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_task/core/di/api_result.dart';
import 'package:job_task/core/get_it/configure_dependency.dart';
import 'package:job_task/data/model/request/order/create_order_request.dart';
import 'package:job_task/data/model/response/cart/cart_entity.dart';
import 'package:job_task/data/model/response/create_order_entity.dart';
import 'package:job_task/domain/use_cases/order_use_case/order_use_case.dart';
import 'package:job_task/services/order/order_state.dart';
import 'package:latlong2/latlong.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  // ============================================================
  // USE CASE
  // ============================================================

  final CreateOrderUseCase createOrderUseCase =
  getIt<CreateOrderUseCase>();

  // ============================================================
  // CONTROLLERS
  // ============================================================

  final TextEditingController addressController =
  TextEditingController();

  final TextEditingController streetNameController =
  TextEditingController();

  final TextEditingController buildingNumberController =
  TextEditingController();

  // ============================================================
  // LOCATION
  // ============================================================

  double? latitude;
  double? longitude;

  static const LatLng defaultLocation = LatLng(
    31.9539,
    35.9106,
  );

  LatLng get currentLocation {
    return LatLng(
      latitude ?? defaultLocation.latitude,
      longitude ?? defaultLocation.longitude,
    );
  }

  bool get hasLocation {
    return latitude != null && longitude != null;
  }

  // ============================================================
  // CART
  // ============================================================

  int? cartId;

  List<OrderProductRequest> products = [];

  double totalPrice = 0.0;

  static OrderCubit get(BuildContext context) {
    return BlocProvider.of<OrderCubit>(context);
  }

  // ============================================================
  // SET CART DATA
  // ============================================================

  void setCartData({
    required List<CartDataEntity> cart,
  }) {
    if (cart.isEmpty) {
      cartId = null;
      products = [];
      totalPrice = 0.0;

      emit(OrderInitial());
      return;
    }

    // Cart ID
    cartId = cart.first.id;

    // Products
    products = cart.map((item) {
      return OrderProductRequest(
        productId: item.productId,
        quantity: item.quantity,
        // Add size/color here if they exist in CartDataEntity
         sizeId: item.sizeId,
         colors: [item.color],
      );
    }).toList();

    // Calculate total
    totalPrice = cart.fold<double>(
      0.0,
          (sum, item) {
        final productPrice =
            double.tryParse(item.product.price) ?? 0.0;

        return sum + (productPrice * item.quantity);
      },
    );

    emit(OrderInitial());
  }

  // ============================================================
  // SELECT LOCATION
  // ============================================================

  void selectLocation(LatLng location) {
    latitude = location.latitude;
    longitude = location.longitude;

    emit(
      OrderLocationChanged(
        lat: latitude!,
        long: longitude!,
      ),
    );
  }

  // ============================================================
  // SET LOCATION
  // ============================================================

  void setLocation({
    required double lat,
    required double long,
  }) {
    latitude = lat;
    longitude = long;

    emit(
      OrderLocationChanged(
        lat: lat,
        long: long,
      ),
    );
  }

  // ============================================================
  // VALIDATE
  // ============================================================

  bool _validate() {
    if (cartId == null) {
      emit(
        OrderFailed('Cart ID is required'),
      );

      return false;
    }

    if (products.isEmpty) {
      emit(
        OrderFailed('No products found'),
      );

      return false;
    }

    if (addressController.text.trim().isEmpty) {
      emit(
        OrderFailed('Please enter your address'),
      );

      return false;
    }

    if (streetNameController.text.trim().isEmpty) {
      emit(
        OrderFailed('Please enter street name'),
      );

      return false;
    }

    if (buildingNumberController.text.trim().isEmpty) {
      emit(
        OrderFailed('Please enter building number'),
      );

      return false;
    }

    if (latitude == null || longitude == null) {
      emit(
        OrderFailed(
          'Please select your location on the map',
        ),
      );

      return false;
    }

    if (totalPrice <= 0) {
      emit(
        OrderFailed('Invalid total price'),
      );

      return false;
    }

    return true;
  }

  // ============================================================
  // CREATE ORDER
  // ============================================================

  Future<void> createOrder() async {
    if (!_validate()) {
      return;
    }

    emit(OrderCreating());

    try {
      final request = CreateOrderRequest(
        cartId: cartId!,
        address: addressController.text.trim(),
        streetName: streetNameController.text.trim(),
        buildingNumber: buildingNumberController.text.trim(),
        lat: latitude!,
        long: longitude!,
        totalPrice: totalPrice,
        products: List<OrderProductRequest>.from(products),
      );

      debugPrint(
        'CREATE ORDER: ${request.toJson()}',
      );

      final result = await createOrderUseCase.execute(
        request,
      );

      if (result is Success<CreateOrderEntity>) {
        emit(
          OrderCreated(result.data),
        );

        return;
      }

      if (result is Failure<CreateOrderEntity>) {
        emit(
          OrderFailed(
            result.error?.message ??
                'Failed to create order',
          ),
        );

        return;
      }

      emit(
        OrderFailed('Something went wrong'),
      );
    } catch (e) {
      debugPrint(
        'CREATE ORDER ERROR: $e',
      );

      emit(
        OrderFailed(e.toString()),
      );
    }
  }

  // ============================================================
  // CLEAR
  // ============================================================

  void clearOrder() {
    addressController.clear();
    streetNameController.clear();
    buildingNumberController.clear();

    latitude = null;
    longitude = null;

    cartId = null;
    products.clear();
    totalPrice = 0.0;

    emit(OrderInitial());
  }

  // ============================================================
  // CLOSE
  // ============================================================

  @override
  Future<void> close() {
    addressController.dispose();
    streetNameController.dispose();
    buildingNumberController.dispose();

    return super.close();
  }
}