import 'package:flutter/material.dart';
import 'package:tractian_test/features/assets/infra/models/asset_model.dart';

class AssetTile extends StatefulWidget {
  final Asset asset;
  bool isInitialExpanded;

  AssetTile({
    super.key,
    required this.asset,
    this.isInitialExpanded = false,
  });

  @override
  State<AssetTile> createState() => _AssetTileState();
}

class _AssetTileState extends State<AssetTile> {


  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: widget.isInitialExpanded,
      title: Transform.translate(
        offset: const Offset(-18, 0),
        child: Row(
          children: [
            const Icon(Icons.settings_input_component, color: Colors.blue, size: 18,),
            const SizedBox(width: 6,),
            Text(widget.asset.name),
            if(widget.asset.sensorType != null) const Row(
              children: [
                SizedBox(width: 6,),
                Icon(Icons.flash_on, color: Colors.green, size: 18)
              ],
            )
          ],
        ),
      ),
      trailing: const SizedBox.shrink(),
      leading: widget.asset.children.isNotEmpty ? Icon(widget.isInitialExpanded ? Icons.keyboard_arrow_down_outlined : Icons.keyboard_arrow_right_outlined, size: 15,) : null,
      onExpansionChanged: (value) {
        setState(() {
          widget.isInitialExpanded = value;
        });
      },
      childrenPadding: const EdgeInsets.only(left: 16),
      children: [
        ...widget.asset.children.map((subAsset) => AssetTile(asset: subAsset)).toList(),
      ],
    );
  }
}

