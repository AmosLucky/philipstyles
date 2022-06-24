import '../constants.dart';

class ServiceModel {
  String? id,
      category,
      category_id,
      service_title,
      service_picture,
      service_content,
      service_price,
      lower_price;

  ServiceModel(
      {this.id,
      this.category,
      this.category_id,
      this.service_title,
      this.service_picture,
      this.service_content,
      this.service_price,
      this.lower_price});

  factory ServiceModel.fromJson(Map<String, dynamic> service) {
    return ServiceModel(
        id: service['id'],
        category: service['category'],
        category_id: service['category_id'],
        service_title: service['service_title'],
        service_picture: image_route + service['service_picture'],
        service_content: service['service_content'],
        service_price: service['service_price'],
        lower_price: service['lower_price']);
  }
}
