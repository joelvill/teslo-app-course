import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import 'providers.dart';

final productProvider = StateNotifierProvider.autoDispose
    .family<ProductNotifier, ProductState, String>((ref, productId) {
  final productsRepository = ref.watch(productsRepositoryProvider);

  return ProductNotifier(
    productRepository: productsRepository,
    productId: productId,
  );
});

class ProductNotifier extends StateNotifier<ProductState> {
  final ProductsRepository productRepository;

  ProductNotifier({
    required this.productRepository,
    required String productId,
  }) : super(ProductState(id: productId)) {
    loadProduct();
  }

  Future<void> loadProduct() async {
    try {
      if (state.id == 'new') {
        state = state.copyWith(product: _newEmptyProduct(), isLoading: false);
        return;
      }

      final product = await productRepository.getProductById(state.id);
      state = state.copyWith(isLoading: false, product: product);
    } catch (e) {
      print(e);
    }
  }

  Product _newEmptyProduct() {
    return Product(
      id: '',
      title: '',
      slug: '',
      price: 0,
      stock: 0,
      sizes: [],
      gender: 'men',
      description: '',
      tags: [],
      images: [],
    );
  }
}

class ProductState {
  final String id;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  ProductState({
    required this.id,
    this.product,
    this.isLoading = true,
    this.isSaving = false,
  });

  ProductState copyWith({
    String? id,
    Product? product,
    bool? isLoading,
    bool? isSaving,
  }) {
    return ProductState(
      id: id ?? this.id,
      product: product ?? this.product,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}
