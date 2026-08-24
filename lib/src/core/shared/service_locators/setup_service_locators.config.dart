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

import '../../../features/settings/contact_us/presentation/imports/contact_us_imports.dart'
    as _i550;
import '../../../features/settings/notifications/presentation/cubits/unread_notification_count_cubit.dart'
    as _i395;
import '../../../features/settings/notifications/presentation/imports/view_imports.dart'
    as _i204;
import '../../../features/settings/splash/imports/view_imports.dart' as _i222;
import '../../../features/settings/static_pages/presentation/imports/view_imports.dart'
    as _i834;
import '../../base_crud/code/data/base_data_imports.dart' as _i241;
import '../../base_crud/code/domain/base_domain_imports.dart' as _i267;
import '../../network/dio_service.dart' as _i37;
import '../../network/network_service.dart' as _i632;
import '../cubits/base_url/base_url_cubit.dart' as _i200;
import '../cubits/user_cubit/user_cubit.dart' as _i996;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);

    gh.factory<_i200.BaseUrlCubit>(() => _i200.BaseUrlCubit());
    gh.factory<_i550.ContactUsCubit>(() => _i550.ContactUsCubit());
    gh.factory<_i204.NotificationsCubit>(() => _i204.NotificationsCubit());
    gh.factory<_i222.SplashCubit>(() => _i222.SplashCubit());
    gh.factory<_i834.StaticPagesCubit>(() => _i834.StaticPagesCubit());
    gh.lazySingleton<_i996.UserCubit>(() => _i996.UserCubit());
    gh.lazySingleton<_i395.UnreadNotificationCountCubit>(
      () => _i395.UnreadNotificationCountCubit(),
    );
    gh.lazySingleton<_i632.NetworkService>(() => _i37.DioService());
    gh.lazySingleton<_i241.BaseRemoteDataSource>(
      () => _i241.BaseRemoteDataSourceImpl(
        dioService: gh<_i632.NetworkService>(),
      ),
    );
    gh.lazySingleton<_i267.BaseRepository>(
      () => _i241.BaseRepositoryImpl(
        baseRemoteDataSource: gh<_i241.BaseRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i267.BaseCrudUseCase>(
      () => _i267.BaseCrudUseCase(repository: gh<_i267.BaseRepository>()),
    );
    return this;
  }
}
