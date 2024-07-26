import 'package:tractian_test/features/assets/datasource/i_asset_service.dart';
import 'package:tractian_test/features/assets/datasource/mock_assets/jaguar_asset_mock.dart';
import 'package:tractian_test/features/assets/infra/models/response/get_assets_response.dart';

class AssetsService implements IAssetService {

  @override
  Future<GetAssetsResponse> get(id) async {
    return GetAssetsResponse.fromMap(apiResponse);
  }
}