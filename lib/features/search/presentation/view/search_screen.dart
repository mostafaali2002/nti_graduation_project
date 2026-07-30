import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';
import '../../../../core/common/widgets/item_card.dart';
import '../../../home/data/repo/home_data_source_imp.dart';
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

    return BlocProvider(
      create: (context) => searchCubit,
      child: SearchScreenContent(),
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
        title: buildSearchBar(),
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
            return Center(child: CircularProgressIndicator());
          }

          if (state is SearchSuccess) {
            return buildSearchResults(state.products);
          }

          if (state is SearchEmpty) {
            return buildEmptyState();
          }

          return buildInitialState();
        },
      ),
    );
  }

  Widget buildSearchBar() {
    return SizedBox(
      height: 50,
      child: CustomTextFormField(
        controller: searchController,
        focusNode: focusNode,
        hintText: 'Search for your products',
        prefixIcon: Icon(Icons.search, color: Colors.grey),
        suffixWidget: searchController.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  searchController.clear();
                  context.read<SearchCubit>().clearSearch();
                  setState(() {});
                },
                icon: Icon(Icons.close, color: Colors.grey, size: 20),
              )
            : null,
        onChanged: (value) {
          setState(() {});
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

  Widget buildInitialState() {
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

  Widget buildEmptyState() {
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

  Widget buildSearchResults(List<ProductListEntity> products) {
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
        return ItemCard(
          image: product.thumbnail,

          productName: product.title,
          rate: product.rating,
          productAfterOffer:
              (((product.discountPercentage) / 100) * product.price)
                  .ceilToDouble(),
          productBeforeOffer: product.price.ceilToDouble(),
        );
      },
    );
  }
}
