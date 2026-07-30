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
import 'package:nti_graduation_project/features/account/data/repo/account_data_source_imp.dart'
    as _i657;
import 'package:nti_graduation_project/features/account/data/repo/account_repo_imp.dart'
    as _i971;
import 'package:nti_graduation_project/features/account/domain/repo/account_data_source_interface.dart'
    as _i335;
import 'package:nti_graduation_project/features/account/domain/repo/account_repo_interface.dart'
    as _i770;
import 'package:nti_graduation_project/features/account/domain/use_case/get_account_info_use_case.dart'
    as _i887;
import 'package:nti_graduation_project/features/account/domain/use_case/post_account_info_use_case.dart'
    as _i769;
import 'package:nti_graduation_project/features/app_section/view_model/account_cubit/account_cubit.dart'
    as _i504;
import 'package:nti_graduation_project/features/app_section/view_model/account_cubit/get_account_cubit.dart'
    as _i642;
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

extension GetItInjectableX on _i174.GetIt {
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i151.SecureStorageHelper>(() => _i151.SecureStorageHelper());
    gh.factory<_i331.AuthDataSourceInterface>(
      () => _i231.AuthDataSourceImplem(),
    );
    gh.factory<_i335.AccountDataSourceInterface>(
      () => _i657.AccountDataSourceImp(),
    );
    gh.factory<_i504.AccountCubit>(
      () => _i504.AccountCubit(
        accountInfoUseCase: gh<_i769.PostAccountInfoUseCase>(),
      ),
    );
    gh.factory<_i770.AccountRepoInterface>(
      () => _i971.AccountRepoImp(gh<_i335.AccountDataSourceInterface>()),
    );
    gh.factory<_i48.AuthRepoInterface>(
      () => _i694.AuthRepoImplem(
        gh<_i331.AuthDataSourceInterface>(),
        gh<_i151.SecureStorageHelper>(),
      ),
    );
    gh.factory<_i769.PostAccountInfoUseCase>(
      () => _i769.PostAccountInfoUseCase(gh<_i770.AccountRepoInterface>()),
    );
    gh.factory<_i887.GetAccountUseCase>(
      () => _i887.GetAccountUseCase(gh<_i770.AccountRepoInterface>()),
    );
    gh.factory<_i9.LoginUseCase>(
      () => _i9.LoginUseCase(gh<_i48.AuthRepoInterface>()),
    );
    gh.factory<_i103.RegisterUseCase>(
      () => _i103.RegisterUseCase(gh<_i48.AuthRepoInterface>()),
    );
    gh.factory<_i788.RegisterCubit>(
      () => _i788.RegisterCubit(gh<_i103.RegisterUseCase>()),
    );
    gh.factory<_i137.LoginCubit>(
      () => _i137.LoginCubit(gh<_i9.LoginUseCase>()),
    );
    gh.factory<_i642.GetAccountCubit>(
      () => _i642.GetAccountCubit(
        accountInfoUseCase: gh<_i887.GetAccountUseCase>(),
      ),
    );
    return this;
  }
}
