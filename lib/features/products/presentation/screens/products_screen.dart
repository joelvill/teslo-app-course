import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/widgets.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: const _ProductsView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nuevo producto'),
        icon: const Icon(Icons.add),
        onPressed: () {
          context.push('/product/new');
        },
      ),
    );
  }
}

class _ProductsView extends ConsumerStatefulWidget {
  const _ProductsView();

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends ConsumerState {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    ref.read(productsNotifier.notifier).loadNextPage();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productsNotifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: MasonryGridView.count(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 35.0,
        itemCount: productsState.products.length,
        itemBuilder: (context, index) {
          final product = productsState.products[index];

          return GestureDetector(
            onTap: () => context.push('/product/${product.id}'),
            child: ProductCard(product: product),
          );
        },
      ),
    );
  }

  void _onScroll() {
    if ((_scrollController.position.pixels + 400) >=
        _scrollController.position.maxScrollExtent) {
      ref.read(productsNotifier.notifier).loadNextPage();
    }
  }
}
