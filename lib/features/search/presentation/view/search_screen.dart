import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';
import '../../../../core/common/widgets/item_card.dart';
import '../../../cart/data/repo/cart_data_source_implement.dart';
import '../../../cart/data/repo/cart_repo_implement.dart';
import '../../../cart/domain/use_case/add_cart_use_case.dart';
import '../../../cart/domain/use_case/delete_cart_use_case.dart';
import '../../../cart/domain/use_case/get_cart_use_case.dart';
import '../../../cart/presentation/view_model/cart_cubit.dart';
import '../../../home/data/repo/home_data_source_imp.dart';
import '../../../product_details/presentation/screen/product_details_screen.dart';
import '../../data/repo/search_repo_impl.dart';
import '../../domain/repo/search_repo_interface.dart';
import '../../domain/use_case/search_use_case.dart';
import '../view model/search_cubit.dart';
import '../view model/search_states.dart';
import '../widgets/custom_text_form_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeDataSource = HomeDataSourceImp();
    final SearchRepoInterface searchRepo = SearchRepoImp(
      homeDataSource: homeDataSource,
    );
    final searchUseCase = SearchProductsUseCase(searchRepo: searchRepo);
    final searchCubit = SearchCubit(searchProductsUseCase: searchUseCase);

    final cartCubit = _createCartCubit();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => searchCubit),
        BlocProvider(create: (context) => cartCubit),
      ],
      child: const SearchScreenContent(),
    );
  }


  CartCubit _createCartCubit() {
    final cartDataSource = CartDataSourceImp();
    final cartRepo = CartRepoImp(
      cartDataSource: cartDataSource,
    );
    final getCartUseCase = GetCartUseCase(cartRepo: cartRepo);
    final addCartUseCase = AddCartUseCase(cartRepo: cartRepo);
    final deleteCartUseCase = DeleteCartUseCase(cartRepo: cartRepo);

    return CartCubit(
      getCartUseCase: getCartUseCase,
      addCartUseCase: addCartUseCase,
      deleteCartUseCase: deleteCartUseCase,
    );
  }
}

class SearchScreenContent extends StatefulWidget {
  const SearchScreenContent({super.key});

  @override
  State<SearchScreenContent> createState() => _SearchScreenContentState();
}

class _SearchScreenContentState extends State<SearchScreenContent> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SearchBarWidget(),
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          if (state is SearchFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SearchSuccess) {
            return SearchResultsWidget(products: state.products);
          }

          if (state is SearchEmpty) {
            return const SearchEmptyWidget();
          }

          return const SearchInitialWidget();
        },
      ),
    );
  }
}


class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: CustomTextFormField(
        hintText: 'Search for your products',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        onChanged: (value) {
          if (value != null && value.isNotEmpty) {
            context.read<SearchCubit>().searchProducts(value);
          } else if (value?.isEmpty ?? true) {
            context.read<SearchCubit>().clearSearch();
          }
        },
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class SearchInitialWidget extends StatelessWidget {
  const SearchInitialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_rounded, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'Search for your products',
            style: TextStyle(fontSize: 18, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 8),
          Text(
            'Type at least 2 characters to start searching',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}


class SearchEmptyWidget extends StatelessWidget {
  const SearchEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'No products found',
            style: TextStyle(fontSize: 18, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching with different keywords',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}


class SearchResultsWidget extends StatelessWidget {
  final List<ProductListEntity> products;

  const SearchResultsWidget({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.69,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        final priceAfterDiscount = (product.price * (1 - product.discountPercentage / 100));

        return ItemCard(
          onTap: () {
            final cartCubit = context.read<CartCubit>();

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: cartCubit,
                  child: const ProductDetailsScreen(),
                ),
                settings: RouteSettings(
                  arguments: product,
                ),
              ),
            );
          },
          image: product.thumbnail,
          productName: product.title,
          rate: product.rating,
          productAfterOffer: priceAfterDiscount.ceilToDouble(),
          productBeforeOffer: product.price.ceilToDouble(),
          productId: product.id,
        );
      },
    );
  }
}