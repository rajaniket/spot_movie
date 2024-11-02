// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:spot_movie/core/services/network_service/network_service.dart'
    as _i528;
import 'package:spot_movie/core/services/storage_service/storage_service.dart'
    as _i950;
import 'package:spot_movie/features/movie/data/data_sources/movie_local_data_source.dart'
    as _i623;
import 'package:spot_movie/features/movie/data/data_sources/movie_remote_data_source.dart'
    as _i41;
import 'package:spot_movie/features/movie/data/repositories/movie_repository_impl.dart'
    as _i567;
import 'package:spot_movie/features/movie/domain/repositories/movie_repository.dart'
    as _i264;
import 'package:spot_movie/features/movie/domain/usecases/get_movies_use_case.dart'
    as _i164;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final sharedPreferencesModule = _$SharedPreferencesModule();
    final networkModule = _$NetworkModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPreferencesModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.factory<_i950.StorageService>(() =>
        _i950.SharedPreferencesStorageService(gh<_i460.SharedPreferences>()));
    gh.factory<_i623.MovieLocalDataSource>(
        () => _i623.MovieLocalDataSourceImpl(gh<_i950.StorageService>()));
    gh.lazySingleton<_i528.NetworkService>(
        () => _i528.NetworkService(dio: gh<_i361.Dio>()));
    gh.factory<_i41.MovieRemoteDataSource>(
        () => _i41.MovieRemoteDataSourceImpl(gh<_i528.NetworkService>()));
    gh.factory<_i264.MovieRepository>(() => _i567.MovieRepositoryImpl(
          remoteDataSource: gh<_i41.MovieRemoteDataSource>(),
          localDataSource: gh<_i623.MovieLocalDataSource>(),
        ));
    gh.factory<_i164.GetMoviesUseCase>(
        () => _i164.GetMoviesUseCase(gh<_i264.MovieRepository>()));
    return this;
  }
}

class _$SharedPreferencesModule extends _i950.SharedPreferencesModule {}

class _$NetworkModule extends _i528.NetworkModule {}
