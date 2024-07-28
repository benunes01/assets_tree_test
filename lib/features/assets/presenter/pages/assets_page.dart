import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_test/features/assets/infra/models/asset_model.dart';
import 'package:tractian_test/features/assets/infra/models/location_model.dart';
import 'package:tractian_test/features/assets/presenter/components/asset_tile.dart';
import 'package:tractian_test/features/assets/presenter/components/custom_input.dart';
import 'package:tractian_test/features/assets/presenter/components/location_tile.dart';
import 'package:tractian_test/features/assets/presenter/controllers/asset_controller.dart';

class AssetsPage extends StatelessWidget {
  AssetsPage({super.key});

  final AssetController controller = Modular.get<AssetController>();

  @override
  Widget build(BuildContext context) {
    controller.get(id: '1');
    return Scaffold(
      body: Observer(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomInput(
                  onChanged: (value) async {
                    await controller.setTextSearch(value);
                  },
                  hintText: 'Buscar Ativo ou Local',
                  prefixIcon: const Icon(Icons.search),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.rootLocations.length + controller.rootAssets.length,
                    itemBuilder: (context, index) {
                      if (index < controller.rootLocations.length) {
                        return LocationTile(location: controller.rootLocations.elementAt(index),);
                      } else {
                        return AssetTile(asset: controller.rootAssets.elementAt(index - controller.rootLocations.length),);
                      }
                    },
                  ),
                ),
              ],),
          );
        }
      ),
    );
  }
}