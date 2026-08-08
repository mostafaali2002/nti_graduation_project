import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/core/utils/helper/app_color_style.dart';
import 'package:nti_graduation_project/features/cart/presentation/view_model/cart_cubit.dart';
import 'package:nti_graduation_project/features/cart/presentation/view_model/cart_state.dart';

class AddToCartCustomButton extends StatefulWidget {
  final int productId;
  final String productName;
  final double? width;
  final double? height;
  final bool showLabel;

  const AddToCartCustomButton({
    super.key,
    required this.productId,
    required this.productName,
    this.width,
    this.height = 40,
    this.showLabel = true,
  });

  @override
  State<AddToCartCustomButton> createState() => _AddToCartCustomButtonState();
}

class _AddToCartCustomButtonState extends State<AddToCartCustomButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartCubit, CartState, bool>(
      selector: (state) {
        final cartCubit = context.read<CartCubit>();
        return cartCubit.isProductInCart(widget.productId);
      },
      builder: (context, isInCart) {
        return BlocListener<CartCubit, CartState>(
          listener: (context, state) {
            if (state is AddCartSuccess || state is DeleteCartSuccess) {
              setState(() => _isLoading = false);
              context.read<CartCubit>().showSnackBar(context);
            }
            if (state is AddCartFailure) {
              setState(() => _isLoading = false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state is DeleteCartFailure) {
              setState(() => _isLoading = false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: isInCart ? _buildInCartButton() : _buildAddButton(context),
        );
      },
    );
  }

  Widget _buildInCartButton() {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(120, 40),
          backgroundColor: Colors.grey,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: widget.showLabel
            ? Text(
          "In cart",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontSize: 12,
          ),
        )
            : const Icon(
          Icons.check_circle,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        onPressed: _isLoading
            ? null
            : () {
          setState(() {
            _isLoading = true;
          });
          context.read<CartCubit>().toggleCart(
            widget.productId,
            productName: widget.productName,
          );
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(120, 40),
          backgroundColor: _isLoading
              ? Colors.grey
              : AppColorStyle.primaryButtonColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )
            : widget.showLabel
            ? Text(
          "Add to cart",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white,
            fontSize: 12,
          ),
        )
            : const Icon(
          Icons.add_shopping_cart,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}