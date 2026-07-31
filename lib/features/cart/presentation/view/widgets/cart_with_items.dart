import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/core/common/widgets/custom_button.dart';
import 'package:nti_graduation_project/core/utils/helper/app_text_style.dart';

import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';
import '../../view_model/cart_cubit.dart';
import '../../view_model/cart_state.dart';
import '../widgets/cart_item.dart';

class CartWithItems extends StatelessWidget {
  final List<ProductListEntity> products;
  final Map<int, int>? quantities;

  const CartWithItems({
    super.key,
    required this.products,
    this.quantities,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CartCubit>();
    final totalPrice = cubit.calculateTotalPrice();
    final shippingFee = 45.0;
    final total = totalPrice + shippingFee;

    return Column(
      children: [
        Expanded(
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              Map<int, int> quantities = {};
              if (state is GetCartSuccess) {
                quantities = state.quantities;
              } else if (state is AddCartSuccess) {
                quantities = state.quantities;
              } else if (state is DeleteCartSuccess) {
                quantities = state.quantities;
              } else if (state is UpdateQuantitySuccess) {
                quantities = state.quantities;
              } else if (state is OutOfStockError) {
                quantities = state.quantities;
              } else if (this.quantities != null) {
                quantities = this.quantities!;
              }

              return ListView.builder(
                itemCount: products.length,
                shrinkWrap: false,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final product = products[index];
                  final quantity = quantities[product.id] ?? 1;

                  return CartItem(
                    product: product,
                    quantity: quantity,
                    onRemove: () {
                      cubit.deleteCart(product.id.toString());
                    },
                    onIncrease: () {
                      cubit.increaseQuantity(product.id);
                    },
                    onDecrease: () {
                      cubit.decreaseQuantity(product.id);
                    },
                  );
                },
              );
            },
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            spacing: 8,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Shipping fee", style: AppTextStyle.kTextStyleRegular16),
                  Text("EGP ${shippingFee.toStringAsFixed(0)}",
                      style: AppTextStyle.kTextStyleRegular16),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Sub total", style: AppTextStyle.kTextStyleRegular16),
                  Text("EGP ${totalPrice.toStringAsFixed(0)}",
                      style: AppTextStyle.kTextStyleRegular16),
                ],
              ),
              const Divider(color: Colors.grey, thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total", style: AppTextStyle.kTextStyleSemiBold18),
                  Text("EGP ${total.toStringAsFixed(0)}",
                      style: AppTextStyle.kTextStyleSemiBold18),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        CustomButton(
          text: 'Checkout',
          backgroundColor: Colors.black,
          textColor: Colors.white,
          borderColor: Colors.black,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Checkout functionality coming soon!')),
            );
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}