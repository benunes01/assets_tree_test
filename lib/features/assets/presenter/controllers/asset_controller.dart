import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:isolate';

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

  @action
  setTextSearch(String text) async {
    textSearch = text;
    await _runBuildTreeInIsolate(List<Location>.from(locationListSaved), List<Asset>.from(assetListSaved));
  }

  @action
  Future<void> get({required String id}) async {
    final res = await useCase.call(id);
    res.fold((success) async {
      assetListSaved = List<Asset>.from(success.assets);
      locationListSaved = List<Location>.from(success.locations);
      await _runBuildTreeInIsolate(List<Location>.from(locationListSaved), List<Asset>.from(assetListSaved));
    }, (failure) {
      log(failure.message ?? '');
    });
  }

  Future<void> _runBuildTreeInIsolate(List<Location> locations, List<Asset> assets) async {
    isLoading = true;

    final data = {
      'locations': locations.map((e) => e.toJson()).toList(),
      'assets': assets.map((e) => e.toJson()).toList(),
      'textSearch': textSearch,
    };

    final result = await compute(ProcessDataTree.buildTreeInIsolate, data);

    rootAssets.clear();
    rootLocations.clear();
    rootLocations.addAll((result['rootLocations'] as List).map((e) => Location.fromJson(e)).toList());
    rootAssets.addAll((result['rootAssets'] as List).map((e) => Asset.fromJson(e)).toList());

    rootAssets.sort((a, b) => b.children.length.compareTo(a.children.length));
    rootLocations.sort((a, b) {
      int aCount = a.subLocations.length + a.assets.length;
      int bCount = b.subLocations.length + b.assets.length;
      return bCount.compareTo(aCount);
    });

    isLoading = false;
  }

}
