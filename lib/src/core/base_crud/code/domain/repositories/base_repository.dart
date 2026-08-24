part of '../base_domain_imports.dart';

abstract class BaseRepository {
  Future<Result<T, Failure>> crudCall<T>(CrudBaseParams params);
}
