import 'package:result_dart/result_dart.dart';
import 'package:tractian_test/features/assets/infra/models/response/get_assets_response.dart';
import 'package:dio/dio.dart';

abstract class IAssetRepository {
  AsyncResult<GetAssetsResponse, DioException> get(id);
}