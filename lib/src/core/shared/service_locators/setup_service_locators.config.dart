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

import '../../../features/auth/data/datasources/auth_remote_data_source.dart'
    as _i436;
import '../../../features/auth/data/repositories/auth_repository_impl.dart'
    as _i365;
import '../../../features/auth/domain/repositories/auth_repository.dart'
    as _i234;
import '../../../features/create_delivery/data/datasources/create_delivery_remote_data_source.dart'
    as _i343;
import '../../../features/create_delivery/data/repositories/create_delivery_repository_impl.dart'
    as _i330;
import '../../../features/create_delivery/domain/repositories/create_delivery_repository.dart'
    as _i431;
import '../../../features/create_order/data/datasources/create_order_remote_data_source.dart'
    as _i206;
import '../../../features/create_order/data/repositories/create_order_repository_impl.dart'
    as _i931;
import '../../../features/create_order/domain/repositories/create_order_repository.dart'
    as _i478;
import '../../../features/logic/home_tabs/admin/admin_home/data/datasources/admin_home_remote_data_source.dart'
    as _i141;
import '../../../features/logic/home_tabs/admin/admin_home/data/repositories/admin_home_repository_impl.dart'
    as _i837;
import '../../../features/logic/home_tabs/admin/admin_home/domain/repositories/admin_home_repository.dart'
    as _i981;
import '../../../features/settings/contact_us/data/datasources/contact_us_remote_data_source.dart'
    as _i208;
import '../../../features/settings/contact_us/data/repositories/contact_us_repository_impl.dart'
    as _i258;
import '../../../features/settings/contact_us/domain/repositories/contact_us_repository.dart'
    as _i564;
import '../../../features/settings/contact_us/presentation/imports/contact_us_imports.dart'
    as _i550;
import '../../../features/settings/notifications/data/datasources/notifications_remote_data_source.dart'
    as _i129;
import '../../../features/settings/notifications/data/repositories/notifications_repository_impl.dart'
    as _i921;
import '../../../features/settings/notifications/domain/repositories/notifications_repository.dart'
    as _i618;
import '../../../features/settings/notifications/presentation/cubits/unread_notification_count_cubit.dart'
    as _i395;
import '../../../features/settings/notifications/presentation/imports/view_imports.dart'
    as _i204;
import '../../../features/settings/profile/data/datasources/profile_remote_data_source.dart'
    as _i777;
import '../../../features/settings/profile/data/repositories/profile_repository_impl.dart'
    as _i444;
import '../../../features/settings/profile/domain/repositories/profile_repository.dart'
    as _i51;
import '../../../features/settings/splash/imports/view_imports.dart' as _i222;
import '../../../features/settings/static_pages/data/datasources/static_pages_remote_data_source.dart'
    as _i233;
import '../../../features/settings/static_pages/data/repositories/static_pages_repository_impl.dart'
    as _i558;
import '../../../features/settings/static_pages/domain/repositories/static_pages_repository.dart'
    as _i308;
import '../../../features/settings/static_pages/presentation/imports/view_imports.dart'
    as _i834;
import '../../network/dio_service.dart' as _i37;
import '../../network/network_service.dart' as _i632;
import '../cubits/base_url/base_url_cubit.dart' as _i200;
import '../cubits/user_cubit/user_cubit.dart' as _i996;
import '../data/datasources/user_remote_data_source.dart' as _i56;
import '../data/repositories/user_repository_impl.dart' as _i223;
import '../domain/repositories/user_repository.dart' as _i544;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i200.BaseUrlCubit>(() => _i200.BaseUrlCubit());
    gh.factory<_i222.SplashCubit>(() => _i222.SplashCubit());
    gh.lazySingleton<_i996.UserCubit>(() => _i996.UserCubit());
    gh.lazySingleton<_i395.UnreadNotificationCountCubit>(
      () => _i395.UnreadNotificationCountCubit(),
    );
    gh.lazySingleton<_i632.NetworkService>(() => _i37.DioService());
    gh.lazySingleton<_i206.CreateOrderRemoteDataSource>(
      () => _i206.CreateOrderRemoteDataSourceImpl(gh<_i632.NetworkService>()),
    );
    gh.lazySingleton<_i141.AdminHomeRemoteDataSource>(
      () => _i141.AdminHomeRemoteDataSourceImpl(gh<_i632.NetworkService>()),
    );
    gh.lazySingleton<_i777.ProfileRemoteDataSource>(
      () => _i777.ProfileRemoteDataSourceImpl(gh<_i632.NetworkService>()),
    );
    gh.lazySingleton<_i233.StaticPagesRemoteDataSource>(
      () => _i233.StaticPagesRemoteDataSourceImpl(gh<_i632.NetworkService>()),
    );
    gh.lazySingleton<_i129.NotificationsRemoteDataSource>(
      () => _i129.NotificationsRemoteDataSourceImpl(gh<_i632.NetworkService>()),
    );
    gh.lazySingleton<_i343.CreateDeliveryRemoteDataSource>(
      () =>
          _i343.CreateDeliveryRemoteDataSourceImpl(gh<_i632.NetworkService>()),
    );
    gh.lazySingleton<_i56.UserRemoteDataSource>(
      () => _i56.UserRemoteDataSourceImpl(gh<_i632.NetworkService>()),
    );
    gh.factory<_i204.NotificationsCubit>(
      () => _i204.NotificationsCubit(
        repository: gh<_i618.NotificationsRepository>(),
      ),
    );
    gh.lazySingleton<_i208.ContactUsRemoteDataSource>(
      () => _i208.ContactUsRemoteDataSourceImpl(gh<_i632.NetworkService>()),
    );
    gh.lazySingleton<_i436.AuthRemoteDataSource>(
      () => _i436.AuthRemoteDataSourceImpl(gh<_i632.NetworkService>()),
    );
    gh.lazySingleton<_i478.CreateOrderRepository>(
      () => _i931.CreateOrderRepositoryImpl(
        gh<_i206.CreateOrderRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i981.AdminHomeRepository>(
      () =>
          _i837.AdminHomeRepositoryImpl(gh<_i141.AdminHomeRemoteDataSource>()),
    );
    gh.lazySingleton<_i431.CreateDeliveryRepository>(
      () => _i330.CreateDeliveryRepositoryImpl(
        gh<_i343.CreateDeliveryRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i544.UserRepository>(
      () => _i223.UserRepositoryImpl(gh<_i56.UserRemoteDataSource>()),
    );
    gh.lazySingleton<_i234.AuthRepository>(
      () => _i365.AuthRepositoryImpl(gh<_i436.AuthRemoteDataSource>()),
    );
    gh.lazySingleton<_i51.ProfileRepository>(
      () => _i444.ProfileRepositoryImpl(gh<_i777.ProfileRemoteDataSource>()),
    );
    gh.lazySingleton<_i308.StaticPagesRepository>(
      () => _i558.StaticPagesRepositoryImpl(
        gh<_i233.StaticPagesRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i618.NotificationsRepository>(
      () => _i921.NotificationsRepositoryImpl(
        gh<_i129.NotificationsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i564.ContactUsRepository>(
      () =>
          _i258.ContactUsRepositoryImpl(gh<_i208.ContactUsRemoteDataSource>()),
    );
    gh.factory<_i834.StaticPagesCubit>(
      () => _i834.StaticPagesCubit(gh<_i308.StaticPagesRepository>()),
    );
    gh.factory<_i550.ContactUsCubit>(
      () => _i550.ContactUsCubit(gh<_i564.ContactUsRepository>()),
    );
    return this;
  }
}
