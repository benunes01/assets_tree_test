import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_test/features/assets/infra/enum/sensor_type_enum.dart';
import 'package:tractian_test/features/assets/presenter/components/asset_tile.dart';
import 'package:tractian_test/features/assets/presenter/components/custom_input.dart';
import 'package:tractian_test/features/assets/presenter/components/location_tile.dart';
import 'package:tractian_test/features/assets/presenter/components/option_filter.dart';
import 'package:tractian_test/features/assets/presenter/controllers/asset_controller.dart';

class AssetsPage extends StatelessWidget {
  AssetsPage({super.key});

  final AssetController controller = Modular.get<AssetController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Observer(
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomInput(
                  onSubmitted: (value) async {
                    await controller.setTextSearch(value);
                  },
                  hintText: 'Buscar Ativo ou Local',
                  prefixIcon: const Icon(Icons.search),
                ),
                const SizedBox(height: 4,),
                SizedBox(
                  height: 32,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ..._buildSensorTypes(),
                      OptionFilter(
                          title: 'crítico',
                          icon: Icons.warning_amber_rounded,
                          onTap: () {
                            controller.toggleIsCritic();
                          },
                          isActive: controller.isCritic,
                      ),

                    ],
                  ),
                ),
                const SizedBox(height: 4,),
                controller.isLoading ? const Center(child: CircularProgressIndicator()) : Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.rootLocations.length + controller.rootAssets.length,
                    itemBuilder: (context, index) {
                      if (index < controller.rootLocations.length) {
                        return LocationTile(location: controller.rootLocations.elementAt(index),);
                      } else {
                        return AssetTile(asset: controller.rootAssets.elementAt(index - controller.rootLocations.length), isInitialExpanded: controller.textSearch.isNotEmpty,);
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

  List<OptionFilter> _buildSensorTypes() {
    return SensorType.values.map((sensorType) {
      return OptionFilter(
        title: sensorType.toShortString(),
        icon: sensorType.getIcon(),
        onTap: () {
          controller.toggleSensorType(sensorType.toShortString());
        },
        isActive: controller.sensorTypeSelectedList.contains(sensorType.toShortString()),
      );
    }).toList();
  }
}