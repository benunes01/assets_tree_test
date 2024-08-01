import 'package:flutter/material.dart';
import 'package:tractian_test/features/assets/infra/models/location_model.dart';
import 'package:tractian_test/features/assets/presenter/components/asset_tile.dart';
import 'package:tractian_test/ui/text_styles.dart';

class LocationTile extends StatefulWidget {
  final Location location;
  final bool isInitialExpanded;

  const LocationTile({
    super.key,
    required this.location,
    this.isInitialExpanded = false,
  });

  @override
  State<LocationTile> createState() => _LocationTileState();
}

class _LocationTileState extends State<LocationTile> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isInitialExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: _buildTitle(),
      initiallyExpanded: _isExpanded,
      trailing: const SizedBox.shrink(),
      leading: _buildLeading(),
      onExpansionChanged: (value) {
        setState(() {
          _isExpanded = value;
        });
      },
      childrenPadding: const EdgeInsets.only(left: 16),
      children: _buildChildren(),
    );
  }

  Widget _buildTitle() {
    return Transform.translate(
      offset: const Offset(-18, 0),
      child: Row(
        children: [
          const Icon(
            Icons.place_outlined,
            color: Colors.blue,
            size: 18,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              widget.location.name,
              style: bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget? _buildLeading() {
    final bool hasChildren = widget.location.assets.isNotEmpty || widget.location.subLocations.isNotEmpty;
    if (!hasChildren) return null;

    return Icon(
      _isExpanded
          ? Icons.keyboard_arrow_down_outlined
          : Icons.keyboard_arrow_right_outlined,
      size: 15,
    );
  }

  List<Widget> _buildChildren() {
    return [
      ...widget.location.subLocations.map(
            (subLocation) => LocationTile(
          location: subLocation,
          isInitialExpanded: widget.isInitialExpanded,
        ),
      ),
      ...widget.location.assets.map(
            (asset) => AssetTile(
          asset: asset,
          isInitialExpanded: widget.isInitialExpanded,
        ),
      ),
    ];
  }
}
