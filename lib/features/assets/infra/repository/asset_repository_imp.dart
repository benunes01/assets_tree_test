import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';
import 'package:tractian_test/features/assets/datasource/i_asset_service.dart';
import 'package:tractian_test/features/assets/domain/repository/i_asset_repository.dart';
import 'package:tractian_test/features/assets/infra/models/response/get_assets_response.dart';

class AssetsRepository extends IAssetRepository {
  final IAssetService _service;

  AssetsRepository({required IAssetService service})
      : _service = service;

  @override
  AsyncResult<GetAssetsResponse, DioException> get(id) async {
    try {
      final result = await _service.get(id);
      return Success(result);
    } catch (e) {
      return Failure(DioException as DioException);
    }
  }
}