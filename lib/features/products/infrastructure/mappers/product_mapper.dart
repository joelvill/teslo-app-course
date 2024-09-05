import '../../../../config/config.dart';
import '../../../auth/infrastructure/infrastructure.dart';
import '../../domain/domain.dart';

class ProductMapper {
  static jsonToEntity(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: double.parse(json['price'].toString()),
      description: json['description'],
      slug: json['slug'],
      stock: int.parse(json['stock'].toString()),
      sizes: List<String>.from(json['sizes'].map((size) => size)),
      gender: json['gender'],
      tags: List<String>.from(json['tags'].map((tag) => tag)),
      images: List<String>.from(
        json['images'].map((image) => image.startsWith('http')
            ? image
            : '${Environment.apiUrl}/files/product/$image'),
      ),
      user: UserMapper.userJsonToEntity(json['user']),
    );
  }
}
