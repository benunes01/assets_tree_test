import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';
import 'package:tractian_test/features/assets/infra/models/response/get_assets_response.dart';

abstract class IAssetRepository {
  AsyncResult<GetAssetsResponse, DioException> get(id);
}