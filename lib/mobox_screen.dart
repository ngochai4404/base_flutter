// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MoboxScreen extends StatelessWidget {
  // const MoboxScreen({Key? key}) : super(key: key);
  late MapboxMapController mapController;
  Future<Uint8List> loadMarkerImage() async {
    var byteData = await rootBundle.load("assets/icon/food.png");
    return byteData.buffer.asUint8List();
  }

  void _onMapCreated(MapboxMapController controller){
    mapController = controller;
    mapController.addCircle(
      CircleOptions(
          geometry: LatLng(21.028511, 105.804817), circleColor: "#FF0000"),
    );

  }

  void _onStyleLoadedCallback() async{
    var markerImage = await loadMarkerImage();
    mapController.addImage('food', markerImage);
    await  mapController.addSymbol(SymbolOptions(
      geometry: LatLng(21.028511, 105.804817),
      iconSize: 0.2,
      iconImage: "food",
    ));

    await  mapController.addSymbol(SymbolOptions(
      geometry: LatLng(21.023251, 105.806210),
      iconSize: 0.2,
      iconImage: "food",
    ));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: Text("Mobox")),
        body: MapboxMap(
          accessToken:
              "pk.eyJ1IjoibmdvY2hhaTQ0MDQiLCJhIjoiY2w3NXpvOGpiMXd3azNwbXEwMGE3N3dwNyJ9.Kw6u0vfahX3lduaq_7v73A",
          myLocationRenderMode: MyLocationRenderMode.NORMAL,
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          onStyleLoadedCallback: _onStyleLoadedCallback,
          myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
          minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
          initialCameraPosition:
              CameraPosition(target: LatLng(21.028511, 105.804817), zoom: 12),
        ),
      );
  }
}
