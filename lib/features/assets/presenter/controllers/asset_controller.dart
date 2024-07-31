import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import 'package:tractian_test/features/assets/domain/usecases/get_asset_usecase.dart';
import 'package:tractian_test/features/assets/infra/models/asset_model.dart';
import 'package:tractian_test/features/assets/infra/models/location_model.dart';
import 'package:tractian_test/features/assets/presenter/controllers/isolate/process_data_tree.dart';

part 'asset_controller.g.dart';

class AssetController = AssetControllerBase with _$AssetController;

abstract class AssetControllerBase with Store {
  final GetAssetUseCase useCase;

  AssetControllerBase({required this.useCase});

  @observable
  bool isLoading = false;

  @observable
  ObservableList<Asset> rootAssets = ObservableList<Asset>();
  @observable
  ObservableList<Location> rootLocations = ObservableList<Location>();

  List<Asset> assetListSaved = [];
  List<Location> locationListSaved = [];

  @observable
  String textSearch = '';

  @observable
  bool isCritic = false;

  @observable
  ObservableList<String> sensorTypeSelectedList = ObservableList<String>();

  @action
  Future<void> setTextSearch(String text) async {
    textSearch = text;
    await _rebuildTree();
  }

  @action
  Future<void> toggleIsCritic() async {
    isCritic = !isCritic;
    await _rebuildTree();
  }

  @action
  Future<void> toggleSensorType(String sensor) async {
    if (sensorTypeSelectedList.contains(sensor)) {
      sensorTypeSelectedList.remove(sensor);
    } else {
      sensorTypeSelectedList.add(sensor);
    }
    await _rebuildTree();
  }

  @action
  Future<void> get({required String id}) async {
    final res = await useCase.call(id);
    res.fold((success) async {
      assetListSaved = List<Asset>.from(success.assets);
      locationListSaved = List<Location>.from(success.locations);
      await _rebuildTree();
    }, (failure) {
      log(failure.message ?? '');
    });
  }

  Future<void> _rebuildTree() async {
    isLoading = true;
    final data = {
      'locations': locationListSaved.map((e) => e.toJson()).toList(),
      'assets': assetListSaved.map((e) => e.toJson()).toList(),
      'textSearch': textSearch,
      'isCritic': isCritic,
      'sensorsType': [...sensorTypeSelectedList]
    };

    final result = await compute(ProcessDataTree.buildTreeInIsolate, data);

    rootAssets = ObservableList<Asset>.of(
        (result['rootAssets'] as List).map((e) => Asset.fromJson(e)).toList()
    );
    rootLocations = ObservableList<Location>.of(
        (result['rootLocations'] as List).map((e) => Location.fromJson(e)).toList()
    );

    _sortAssetsAndLocations();

    isLoading = false;
  }

  void _sortAssetsAndLocations() {
    rootAssets.sort((a, b) => b.children.length.compareTo(a.children.length));
    rootLocations.sort((a, b) {
      int aCount = a.subLocations.length + a.assets.length;
      int bCount = b.subLocations.length + b.assets.length;
      return bCount.compareTo(aCount);
    });
  }
}
