import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import 'products_repository_provider.dart';

final productsNotifier = StateNotifierProvider<ProductsNotifier, ProductsState>(
  (ref) {
    final productsRepository = ref.watch(productsRepositoryProvider);

    return ProductsNotifier(productsRepository: productsRepository);
  },
);

/// Notificador de estado para la carga de productos, gestiona la paginación y el estado de la lista
class ProductsNotifier extends StateNotifier<ProductsState> {
  final ProductsRepository productsRepository;

  ProductsNotifier({required this.productsRepository})
      : super(ProductsState()) {
    loadNextPage();
  }

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) {
      return;
    }

    state = state.copyWith(isLoading: true);

    final products = await productsRepository.getProductsByPage(
      limit: state.limit,
      offset: state.offset,
    );

    if (products.isEmpty) {
      state = state.copyWith(isLastPage: true, isLoading: false);
      return;
    }

    state = state.copyWith(
      products: [...state.products, ...products],
      offset: state.offset + 10,
      isLoading: false,
      isLastPage: false,
    );
  }
}

/// Estado que contiene los datos relacionados con los productos y la paginación
class ProductsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final List<Product> products;
  final bool isLoading;

  ProductsState({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 0,
    this.products = const [],
    this.isLoading = false,
  });

  ProductsState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    List<Product>? products,
    bool? isLoading,
  }) {
    return ProductsState(
      isLastPage: isLastPage ?? this.isLastPage,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
