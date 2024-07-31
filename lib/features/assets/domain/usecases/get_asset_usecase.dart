import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';
import 'package:tractian_test/features/assets/domain/repository/i_asset_repository.dart';
import 'package:tractian_test/features/assets/infra/models/response/get_assets_response.dart';

class GetAssetUseCase {
  final IAssetRepository _repository;

  GetAssetUseCase({required IAssetRepository repository})
      : _repository = repository;

  AsyncResult<GetAssetsResponse, DioException> call(String id) async {
    try {
      return _repository.get(id);
    } catch (e) {
      rethrow;
    }
  }

}