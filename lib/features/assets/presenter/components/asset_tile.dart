import 'package:flutter/material.dart';
import 'package:tractian_test/features/assets/infra/enum/sensor_type_enum.dart';
import 'package:tractian_test/features/assets/infra/models/asset_model.dart';
import 'package:tractian_test/ui/text_styles.dart';

class AssetTile extends StatefulWidget {
  final Asset asset;
  final bool isInitialExpanded;

  const AssetTile({
    super.key,
    required this.asset,
    this.isInitialExpanded = false,
  });

  @override
  State<AssetTile> createState() => _AssetTileState();
}

class _AssetTileState extends State<AssetTile> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isInitialExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: _isExpanded,
      title: Transform.translate(
        offset: const Offset(-18, 0),
        child: Row(
          children: [
            Icon(widget.asset.sensorType != null ? Icons.settings_input_component : Icons.format_indent_increase_outlined, color: Colors.blue, size: 18,),
            const SizedBox(width: 6,),
            Flexible(
                child: Text(widget.asset.name,
                  style: bodyMedium,
                  overflow: TextOverflow.ellipsis,
                )),
            _buildIconSensorType(widget.asset.sensorType),
            if(widget.asset.status == 'alert') Row(
              children: [
                const SizedBox(width: 6,),
                Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(100)
                  ),
                )
              ],
            )
          ],
        ),
      ),
      trailing: const SizedBox.shrink(),
      leading: widget.asset.children.isNotEmpty ? Icon(widget.isInitialExpanded ? Icons.keyboard_arrow_down_outlined : Icons.keyboard_arrow_right_outlined, size: 15,) : null,
      onExpansionChanged: (value) {
        setState(() {
          _isExpanded = value;
        });
      },
      childrenPadding: const EdgeInsets.only(left: 16),
      children: [
        ...widget.asset.children.map((subAsset) => AssetTile(asset: subAsset)),
      ],
    );
  }

  Widget _buildIconSensorType(String? sensorType) {
    SensorType? curSensorType = SensorTypeExtension.fromString(sensorType);
    switch (curSensorType) {
      case SensorType.energy:
        return const Row(
          children: [
            SizedBox(width: 6,),
            Icon(Icons.flash_on, color: Colors.green, size: 16,),
          ],
        );
      case SensorType.vibration:
        return const Row(
          children: [
            SizedBox(width: 6,),
            Icon(Icons.vibration, color: Colors.orange,),
          ],
        );
      default:
        return Container();
    }
  }
}

