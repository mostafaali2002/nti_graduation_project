import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/cart_cubit.dart';
import '../../view_model/cart_state.dart';
import '../widgets/cart_with_items.dart';
import '../widgets/empty_cart_screen.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CartCubit>().getCart();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(17),
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is DeleteCartSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.green),
              );
            }
            if (state is AddCartSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.green),
              );
            }
            if (state is DeleteCartFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.red),
              );
            }
            if (state is AddCartFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.red),
              );
            }
            if (state is UpdateQuantityFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.red),
              );
            }
            if (state is OutOfStockError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.orange,
                  duration: const Duration(seconds: 3),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is GetCartLoading ||
                state is AddCartLoading ||
                state is DeleteCartLoading ||
                state is UpdateQuantityLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetCartSuccess) {
              final products = state.cart.productList;
              if (products.isEmpty) return const EmptyCartScreen();
              return CartWithItems(products: products);
            }

            if (state is AddCartSuccess) {
              final products = state.cart.productList;
              if (products.isEmpty) return const EmptyCartScreen();
              return CartWithItems(products: products);
            }

            if (state is DeleteCartSuccess) {
              final products = state.cart.productList;
              if (products.isEmpty) return const EmptyCartScreen();
              return CartWithItems(products: products);
            }

            if (state is UpdateQuantitySuccess) {
              final products = state.cart.productList;
              if (products.isEmpty) return const EmptyCartScreen();
              return CartWithItems(products: products);
            }

            if (state is OutOfStockError) {
              final products = state.cart.productList ;
              if (products.isEmpty) return const EmptyCartScreen();
              return CartWithItems(products: products,quantities: state.quantities,);
            }

            if (state is GetCartFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 60, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(state.message, textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<CartCubit>().getCart(),
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const routeName = AppRoutes.cartRoute;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Cart Screen")));
  }
}
