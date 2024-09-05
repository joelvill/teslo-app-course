import '../../domain/domain.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  final ProductsDataSource dataSource;

  ProductsRepositoryImpl(this.dataSource);

  @override
  Future<List<Product>> getProductsByPage({int limit = 10, int offset = 0}) {
    return dataSource.getProductsByPage(limit: limit, offset: offset);
  }

  @override
  Future<Product> getProductById(String id) {
    return dataSource.getProductById(id);
  }

  @override
  Future<List<Product>> searchProductByTerm(String term) {
    return dataSource.searchProductByTerm(term);
  }

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    return dataSource.createUpdateProduct(productLike);
  }
}
