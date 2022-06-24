class OrderModel {
  String? id, user_id, service_id;
  String? service_title,
      service_price,
      service_picture,
      order_date,
      order_ref,
      order_status;

  OrderModel(
      {this.id,
      this.user_id,
      this.service_id,
      this.service_title,
      this.service_price,
      this.service_picture,
      this.order_date,
      this.order_ref,
      this.order_status});

  factory OrderModel.fromJSON(Map<String, dynamic> order) {
    return OrderModel(
        id: order['id'],
        user_id: order['user_id'],
        service_id: order['service_id'],
        service_title: order['service_title'],
        service_price: order['service_price'],
        service_picture: order['service_picture'],
        order_date: order['order_date'],
        order_ref: order['order_ref'],
        order_status: order['order_status']);
  }
}
