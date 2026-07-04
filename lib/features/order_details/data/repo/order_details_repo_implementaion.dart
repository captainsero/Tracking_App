import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:tracking_app/config/base_response/base_response.dart';
import 'package:tracking_app/features/order_details/data/data_sources/order_details_data_source_contract.dart';
import 'package:tracking_app/features/order_details/data/models/order_dto.dart';
import 'package:tracking_app/features/order_details/domain/entitty/order_entity.dart';
import 'package:tracking_app/features/order_details/domain/entitty/order_status.dart';
import 'package:tracking_app/features/order_details/domain/repo/order_details_repo_contract.dart';

@LazySingleton(as: OrderDetailsRepoContract)
class OrderDetailsRepoImplementaion implements OrderDetailsRepoContract {
  final OrderDetailsDataSourceContract orderDetailsDataSourceContract;

  final FirebaseFirestore _firestore;

  OrderDetailsRepoImplementaion({
    required this.orderDetailsDataSourceContract,
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  @override
  Future<BaseResponse<OrderEntity>> startOrder(String orderId) async {
    final response = await orderDetailsDataSourceContract.startOrder(orderId);

    switch (response) {
      case SuccessBaseResponse<OrderDto>():
        return SuccessBaseResponse<OrderEntity>(data: response.data.toEntity());

      case ErrorBaseResponse<OrderDto>():
        return ErrorBaseResponse<OrderEntity>(error: response.error);
    }
  }

  @override
  Future<void> updateStatus(
    String orderId,
    OrderStatus status, {
    String? driverName,
    String? driverPhone,
  }) {
    final updateData = <String, dynamic>{
      'status': status.toRemoteValue,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    if (driverName != null) updateData['driverName'] = driverName;
    if (driverPhone != null) updateData['driverPhone'] = driverPhone;

    return _firestore
        .collection('order_tracking')
        .doc(orderId)
        .update(updateData);
  }
}
