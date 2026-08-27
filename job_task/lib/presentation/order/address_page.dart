import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:job_task/data/model/response/cart/cart_entity.dart';
import 'package:job_task/services/order/order_cubit.dart';
import 'package:job_task/services/order/order_state.dart';

class AddressPage extends StatefulWidget {
  final CartEntity cartEntity;

  const AddressPage({
    super.key,
    required this.cartEntity,
  });

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {

  late OrderCubit orderCubit;
  @override void initState() {
    orderCubit=  OrderCubit.get(context);
    orderCubit.setCartData(cart: widget.cartEntity.data);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Delivery Address',
        ),
      ),

      body: BlocListener<OrderCubit, OrderState>(
        listener: (context, state) {
          // ======================================================
          // SUCCESS
          // ======================================================

          if (state is OrderCreated) {
            ScaffoldMessenger.of(context)
                .showSnackBar(
              const SnackBar(
                content: Text(
                  'Order placed successfully',
                ),
              ),
            );

            // Navigator.pop(context);
          }

          // ======================================================
          // ERROR
          // ======================================================

          if (state is OrderFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                ),
              ),
            );
          }
        },

        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            final cubit =
            context.read<OrderCubit>();

            final isLoading =
                state is OrderCreating ||
                    state is OrderLoading;

            return SingleChildScrollView(
              padding:
              const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  // ==================================================
                  // TITLE
                  // ==================================================

                  const Text(
                    'Where should we deliver?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Text(
                    'Enter your delivery details',
                    style: TextStyle(
                      color:
                      Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // ==================================================
                  // ADDRESS
                  // ==================================================

                  _buildLabel(
                    'Address',
                  ),

                  TextField(
                    controller:
                    cubit.addressController,

                    decoration:
                    const InputDecoration(
                      hintText:
                      'Enter your address',

                      prefixIcon:
                      Icon(
                        Icons
                            .location_on_outlined,
                      ),

                      border:
                      OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  // ==================================================
                  // STREET
                  // ==================================================

                  _buildLabel(
                    'Street Name',
                  ),

                  TextField(
                    controller:
                    cubit.streetNameController,

                    decoration:
                    const InputDecoration(
                      hintText:
                      'Enter street name',

                      prefixIcon:
                      Icon(
                        Icons
                            .signpost_outlined,
                      ),

                      border:
                      OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  // ==================================================
                  // BUILDING
                  // ==================================================

                  _buildLabel(
                    'Building Number',
                  ),

                  TextField(
                    controller:
                    cubit
                        .buildingNumberController,

                    keyboardType:
                    TextInputType.text,

                    decoration:
                    const InputDecoration(
                      hintText:
                      'Enter building number',

                      prefixIcon:
                      Icon(
                        Icons
                            .home_outlined,
                      ),

                      border:
                      OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // ==================================================
                  // MAP TITLE
                  // ==================================================

                  const Text(
                    'Delivery Location',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight:
                      FontWeight.w600,
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // ==================================================
                  // FLUTTER MAP
                  // ==================================================

                  _buildMap(
                    cubit,
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  // ==================================================
                  // LOCATION INFO
                  // ==================================================

                  _buildLocationInfo(
                    cubit,
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  // ==================================================
                  // SUMMARY
                  // ==================================================

                  const Text(
                    'Order Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  _summaryRow(
                    'Products',
                    '\$${cubit.totalPrice.toStringAsFixed(2)}',
                  ),

                  const Divider(
                    height: 25,
                  ),

                  _summaryRow(
                    'Total',
                    '\$${cubit.totalPrice.toStringAsFixed(2)}',
                    isTotal: true,
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // ==================================================
                  // BUTTON
                  // ==================================================

                  SizedBox(
                    width:
                    double.infinity,

                    height:
                    52,

                    child:
                    ElevatedButton(
                      onPressed:
                      isLoading
                          ? null
                          : cubit
                          .createOrder,

                      child:
                      isLoading
                          ? const SizedBox(
                        width:
                        22,

                        height:
                        22,

                        child:
                        CircularProgressIndicator(
                          strokeWidth:
                          2,
                        ),
                      )
                          : const Text(
                        'Place Order',

                        style:
                        TextStyle(
                          fontSize:
                          16,

                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  Widget _buildMap(
      OrderCubit cubit,
      ) {
    final current =
        cubit.currentLocation;

    final hasLocation =
        cubit.latitude != null &&
            cubit.longitude != null;

    return ClipRRect(
      borderRadius:
      BorderRadius.circular(16),

      child: SizedBox(
        width:
        double.infinity,

        height:
        280,

        child: FlutterMap(
          options: MapOptions(
            initialCenter:
            current,

            initialZoom:
            14,

            onTap:
                (tapPosition, point) {
              cubit.selectLocation(
               LatLng( point.latitude,point.longitude
              ));
            },
          ),

          children: [

            // ======================================================
            // OPEN STREET MAP
            // ======================================================

            TileLayer(
              urlTemplate:
              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',

              userAgentPackageName:
              'com.example.job_task',
            ),

            // ======================================================
            // MARKER
            // ======================================================

            if (hasLocation)
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(
                      cubit.latitude!,
                      cubit.longitude!,
                    ),

                    width:
                    50,

                    height:
                    50,

                    child:
                    const Icon(
                      Icons.location_on,

                      size:
                      45,

                      color:
                      Colors.red,
                    ),
                  ),
                ],
              ),

            // ======================================================
            // ZOOM BUTTONS
            // ======================================================

            RichAttributionWidget(
              attributions: [
                TextSourceAttribution(
                  'OpenStreetMap contributors',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  Widget _buildLocationInfo(
      OrderCubit cubit,
      ) {
    final hasLocation =
        cubit.latitude != null &&
            cubit.longitude != null;

    return Container(
      width:
      double.infinity,

      padding:
      const EdgeInsets.all(12),

      decoration:
      BoxDecoration(
        color: hasLocation
            ? Colors.green.shade50
            : Colors.grey.shade100,

        borderRadius:
        BorderRadius.circular(12),
      ),

      child: Row(
        children: [

          Icon(
            hasLocation
                ? Icons.location_on
                : Icons.location_searching,

            color: hasLocation
                ? Colors.green
                : Colors.grey,
          ),

          const SizedBox(
            width: 10,
          ),

          Expanded(
            child: hasLocation
                ? Text(
              'Latitude: '
                  '${cubit.latitude!.toStringAsFixed(6)}\n'
                  'Longitude: '
                  '${cubit.longitude!.toStringAsFixed(6)}',
            )
                : const Text(
              'Tap on the map to select your delivery location.',
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  Widget _buildLabel(
      String title,
      ) {
    return Padding(
      padding:
      const EdgeInsets.only(
        bottom: 8,
      ),

      child:
      Text(
        title,

        style:
        const TextStyle(
          fontWeight:
          FontWeight.w600,
        ),
      ),
    );
  }

  // ============================================================
  Widget _summaryRow(
      String title,
      String value, {
        bool isTotal = false,
      }) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(
        vertical: 5,
      ),

      child:
      Row(
        mainAxisAlignment:
        MainAxisAlignment
            .spaceBetween,

        children: [

          Text(
            title,

            style:
            TextStyle(
              fontSize:
              isTotal ? 17 : 15,

              fontWeight:
              isTotal
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),

          Text(
            value,

            style:
            TextStyle(
              fontSize:
              isTotal ? 17 : 15,

              fontWeight:
              isTotal
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}