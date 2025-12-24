import 'package:flowery_tracking_app/domain/entities/order/order_entity.dart';
import 'package:flowery_tracking_app/presentation/order_details/views_model/order_details_cubit.dart';

class AddressMapArguments {
  final OrderEntity? orderData;
  final OrderDetailsCubit orderDetailsCubit;

  const AddressMapArguments({
    required this.orderData,
    required this.orderDetailsCubit,
  });
}
