import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_graduation_project/core/network/result_api.dart';
import 'package:nti_graduation_project/core/utils/helper/app_color_style.dart';
import 'package:nti_graduation_project/features/favourite/presentation/view_model/favorite_cubit.dart';
import 'package:nti_graduation_project/features/favourite/presentation/view_model/favorite_states.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({
    super.key,
    required this.productId,
    this.onFavoriteToggle,
    this.size,
  });

  final int productId;
  final VoidCallback? onFavoriteToggle;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteStates>(
      builder: (context, state) {
        final cubit = context.read<FavoriteCubit>();
        final isFav = cubit.isFavorite(productId);

        return IconButton(
          iconSize: size,
          onPressed: () async {
            final wasFav = isFav;

            final result = await cubit.toggleFavorite(productId);

            if (!context.mounted) return;

            switch (result) {
              case Success<String>():
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 1),
                    content: Text(
                      wasFav
                          ? "Removed from favourites"
                          : "Added to favourites",
                    ),
                  ),
                );
                onFavoriteToggle?.call();
                break;

              case Error<String>(messageError: final message):
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
                break;
            }
          },
          icon: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: isFav ? Colors.red : AppColorStyle.secondaryButtonColor,
          ),
        );
      },
    );
  }
}