import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_test/features/assets/presenter/components/card_select_asset.dart';
import 'package:tractian_test/features/assets/presenter/controllers/asset_controller.dart';
import 'package:tractian_test/ui/text_styles.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AssetController controller = Modular.get<AssetController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('TRACTIAN', style: headlineLarge.copyWith(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardSelectAsset(
                onTap: () async {
                  await controller.get(id: '01');
                  Modular.to.pushNamed('asset');
                },
                title: 'Jaguar Unit',
            ),
            const SizedBox(height: 32,),
            CardSelectAsset(
                onTap: () async {
                  await controller.get(id: '02');
                  Modular.to.pushNamed('asset');
                },
                title: 'Tobias Unit',
            ),
            const SizedBox(height: 32,),
            CardSelectAsset(
                onTap: () async {
                  await controller.get(id: '03');
                  Modular.to.pushNamed('/asset');
                },
                title: 'Apex Unit',
            ),
          ],
        ),
      ),
    );
  }

}