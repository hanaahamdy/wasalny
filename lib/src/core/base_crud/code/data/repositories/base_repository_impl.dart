part of '../base_data_imports.dart';

@LazySingleton(as: BaseRepository)
class BaseRepositoryImpl implements BaseRepository {
  final BaseRemoteDataSource baseRemoteDataSource;

  BaseRepositoryImpl({required this.baseRemoteDataSource});


  @override
  Future<Result<T, Failure>> crudCall<T>(CrudBaseParams params) async {
    return await baseRemoteDataSource
        .crudCall<T>(params)
        .handleCallbackWithFailure();
  }
}
