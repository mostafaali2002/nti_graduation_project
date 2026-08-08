import 'package:nti_graduation_project/features/home/domain/entities/all_product_entity.dart';


class FavoriteEntity {
  final List<ProductListEntity> productList;

  const FavoriteEntity({
   required this.productList
  });
}






//     return {
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//       'barcode': barcode,
//       'qrCode': qrCode,
//     };
//   }
// }