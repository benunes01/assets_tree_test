import 'package:tractian_test/features/assets/infra/models/response/get_assets_response.dart';

abstract class IAssetService {
  Future<GetAssetsResponse> get(id);
}