// import 'package:flutter/material.dart';
// import 'package:nti_graduation_project/core/common/widgets/item_card.dart';
// import 'package:nti_graduation_project/core/network/result_api.dart';
// import 'package:nti_graduation_project/features/home/data/repo/home_data_source_imp.dart';
// import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final HomeDataSourceImp _homeDataSource = HomeDataSourceImp();

//   List<ProductListEntity> products = [];

//   bool isLoading = true;
//   String? error;

//   @override
//   void initState() {
//     super.initState();
//     getProducts();
//   }

//   Future<void> getProducts() async {
//     final result = await _homeDataSource.getAllProducts();

//     switch (result) {
//       case Success<AllProductEntity>():
//         setState(() {
//           products = result.data.productList;
//           isLoading = false;
//         });

//       case Error<AllProductEntity>():
//         setState(() {
//           error = result.messageError;
//           isLoading = false;
//         });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (error != null) {
//       return Center(child: Text(error!));
//     }

//     return Scaffold(
//       body: GridView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: products.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 35,
//           mainAxisSpacing: 16.75,
//           childAspectRatio: 0.69,
//         ),
//         itemBuilder: (context, index) {
//           final product = products[index];

//           return ItemCard(
//             image: product.images.isNotEmpty == true
//                 ? product.images.first
//                 : "",
//           );
//         },
//       ),
//     );
//   }
// }
