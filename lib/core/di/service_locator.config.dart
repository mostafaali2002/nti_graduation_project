// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:nti_graduation_project/core/storage_helper/secure_storage_helper.dart'
    as _i151;
import 'package:nti_graduation_project/features/auth/data/repo/auth_data_source_implem.dart'
    as _i231;
import 'package:nti_graduation_project/features/auth/data/repo/auth_repo_implem.dart'
    as _i694;
import 'package:nti_graduation_project/features/auth/domain/repo/auth_data_source_interface.dart'
    as _i331;
import 'package:nti_graduation_project/features/auth/domain/repo/auth_repo_interface.dart'
    as _i48;
import 'package:nti_graduation_project/features/auth/domain/use_case/login_use_case.dart'
    as _i9;
import 'package:nti_graduation_project/features/auth/domain/use_case/register_use_case.dart'
    as _i103;
import 'package:nti_graduation_project/features/auth/presentation/view_model/login/login_cubit.dart'
    as _i137;
import 'package:nti_graduation_project/features/auth/presentation/view_model/register/register_cubit.dart'
    as _i788;
import 'package:nti_graduation_project/features/favourite/data/repo/favourite_data_source_imp.dart'
    as _i171;
import 'package:nti_graduation_project/features/favourite/data/repo/favourite_repo_imp.dart'
    as _i163;
import 'package:nti_graduation_project/features/favourite/domain/repo/favourite_data_source_interface.dart'
    as _i658;
import 'package:nti_graduation_project/features/favourite/domain/repo/favourite_repo_interface.dart'
    as _i303;
import 'package:nti_graduation_project/features/favourite/domain/use_case/add_favorite_use_case.dart'
    as _i595;
import 'package:nti_graduation_project/features/favourite/domain/use_case/delete_favorite_use_case.dart'
    as _i704;
import 'package:nti_graduation_project/features/favourite/domain/use_case/get_favorite_use_case.dart'
    as _i819;
import 'package:nti_graduation_project/features/favourite/presentation/view_model/favorite_cubit.dart'
    as _i1034;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i151.SecureStorageHelper>(() => _i151.SecureStorageHelper());
    gh.factory<_i331.AuthDataSourceInterface>(
      () => _i231.AuthDataSourceImplem(),
    );
    gh.factory<_i48.AuthRepoInterface>(
      () => _i694.AuthRepoImplem(
        gh<_i331.AuthDataSourceInterface>(),
        gh<_i151.SecureStorageHelper>(),
      ),
    );
    gh.factory<_i9.LoginUseCase>(
      () => _i9.LoginUseCase(gh<_i48.AuthRepoInterface>()),
    );
    gh.factory<_i658.FavoriteDataSourceInterface>(
      () => _i171.FavoriteDataSourceImp(),
    );
    gh.factory<_i103.RegisterUseCase>(
      () => _i103.RegisterUseCase(gh<_i48.AuthRepoInterface>()),
    );
    gh.factory<_i303.FavoriteRepoInterface>(
      () => _i163.FavoriteRepoImp(
        favoriteDataSource: gh<_i658.FavoriteDataSourceInterface>(),
      ),
    );
    gh.factory<_i788.RegisterCubit>(
      () => _i788.RegisterCubit(gh<_i103.RegisterUseCase>()),
    );
    gh.factory<_i137.LoginCubit>(
      () => _i137.LoginCubit(gh<_i9.LoginUseCase>()),
    );
    gh.factory<_i595.AddFavoriteUseCase>(
      () => _i595.AddFavoriteUseCase(gh<_i303.FavoriteRepoInterface>()),
    );
    gh.factory<_i819.GetFavoriteUseCase>(
      () => _i819.GetFavoriteUseCase(gh<_i303.FavoriteRepoInterface>()),
    );
    gh.factory<_i704.DeleteFavoriteUseCase>(
      () => _i704.DeleteFavoriteUseCase(
        favoriteRepo: gh<_i303.FavoriteRepoInterface>(),
      ),
    );
    gh.factory<_i1034.FavoriteCubit>(
      () => _i1034.FavoriteCubit(
        gh<_i819.GetFavoriteUseCase>(),
        gh<_i595.AddFavoriteUseCase>(),
        gh<_i704.DeleteFavoriteUseCase>(),
      ),
    );
    return this;
  }
}
