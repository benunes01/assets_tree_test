import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_test/features/assets/datasource/asset_service.dart';
import 'package:tractian_test/features/assets/datasource/i_asset_service.dart';
import 'package:tractian_test/features/assets/domain/repository/i_asset_repository.dart';
import 'package:tractian_test/features/assets/domain/usecases/get_asset_usecase.dart';
import 'package:tractian_test/features/assets/infra/repository/asset_repository_imp.dart';
import 'package:tractian_test/features/assets/presenter/controllers/asset_controller.dart';
import 'package:tractian_test/features/assets/presenter/pages/assets_page.dart';

class AssetModule extends Module {
  @override
  void binds(Injector i) {
    i.add<IAssetService>(AssetsService.new);
    i.add<IAssetRepository>(AssetsRepository.new);
    i.add(GetAssetUseCase.new);

    i.addSingleton(AssetController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (BuildContext context) => AssetsPage());
  }
}