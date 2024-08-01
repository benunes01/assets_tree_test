import 'package:tractian_test/features/assets/datasource/i_asset_service.dart';
import 'package:tractian_test/features/assets/datasource/mock_assets/apex_asset_mock.dart';
import 'package:tractian_test/features/assets/datasource/mock_assets/jaguar_asset_mock.dart';
import 'package:tractian_test/features/assets/datasource/mock_assets/tobias_asset_mock.dart';
import 'package:tractian_test/features/assets/infra/models/response/get_assets_response.dart';

class AssetsService implements IAssetService {

  Map<String, Map<String, dynamic>> mockApiResponses = {
    '01': apiResponse01,
    '02': apiResponse02,
    '03': apiResponse03,
  };

  @override
  Future<GetAssetsResponse> get(id) async {
    final response = mockApiResponses[id];
    if (response == null) {
      throw Exception('Asset ID não encontrado: $id');
    }

    return GetAssetsResponse.fromMap(response);
  }
}