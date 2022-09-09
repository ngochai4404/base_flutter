// import 'package:blocapptest/blocs/entries_bloc.dart';
// import 'package:blocapptest/model/entries_response.dart';
// import 'package:blocapptest/navigation/router_generator.dart';
// import 'package:blocapptest/pdf_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:location/location.dart';
// import 'mobox_screen.dart';
// import 'dart:io' show Platform;
//
// void main() {
//   // runApp(MultiProvider(
//   //   providers: [
//   //     // BlocProvider(create: (context)=>HomeCubit())
//   //   ],
//   //   child: HomeScreen(),
//   // ));
//   runApp(AppMain());
// }
// class AppMain extends StatelessWidget {
//   const AppMain({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: '/',
//       onGenerateRoute: RouteGenerator.generateRoute
//     );
//   }
// }
//
// class MapScreen extends StatelessWidget {
//   const MapScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             title: Text("Map Screen"),
//           ),
//           body: MapComponent()),
//     );
//   }
// }
//
// class MapComponent extends StatelessWidget {
//   const MapComponent({Key? key}) : super(key: key);
//   static const pos =
//       CameraPosition(target: LatLng(21.028511, 105.804817), zoom: 12);
//
//   @override
//   Widget build(BuildContext context) {
//     // if (Platform.isAndroid || Platform.isIOS) {
//     Marker marker = Marker(
//         markerId: MarkerId("Tesst"), position: LatLng(21.028511, 105.804817));
//     List<Marker> markers = [];
//     markers.add(marker);
//     return GoogleMap(
//         markers: Set<Marker>.of(markers),
//         zoomControlsEnabled: true,
//         myLocationButtonEnabled: false,
//         initialCameraPosition: pos);
//     // }
//   }
// }
//
// class MyApp extends StatelessWidget {
//   final bloc = EntriesBloc();
//
//   MyApp({Key? key}) : super(key: key);
//
//   void initializeLocationAndSave() async {
//     // Ensure all permissions are collected for Locations
//     Location _location = Location();
//     bool? _serviceEnabled;
//     PermissionStatus? _permissionGranted;
//
//     _serviceEnabled = await _location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await _location.requestService();
//     }
//
//     _permissionGranted = await _location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await _location.requestPermission();
//     }
//
//     // Get capture the current user location
//     LocationData _locationData = await _location.getLocation();
//     LatLng currentLatLng =
//         LatLng(_locationData.latitude!, _locationData.longitude!);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     initializeLocationAndSave();
//     bloc.getData();
//     return MaterialApp(
//         home: Scaffold(
//       appBar: AppBar(
//         title: TextCustom(),
//       ),
//       body: StreamBuilder(
//           stream: bloc.entries,
//           builder: (context, AsyncSnapshot<EntriesResponse> snapshot) {
//             if (snapshot.hasData) {
//               return Column(
//                 children: [
//                   Text(snapshot.data?.count.toString() ?? "0 data"),
//                   Image.asset("assets/icon/food.png"),
//                   Expanded(
//                     child: SizedBox(
//                         child: ListView.builder(
//                             shrinkWrap: false,
//                             itemCount:
//                                 ((snapshot.data?.count ?? 0) / 40).round(),
//                             itemBuilder: (ctx, index) {
//                               return Text(snapshot.data?.entries?[index].link ??
//                                   "Empty");
//                             })),
//                   )
//                 ],
//               );
//             } else if (snapshot.hasError) {
//               return Text(snapshot.error?.toString() ?? "");
//             }
//             return Center(child: CircularProgressIndicator());
//           }),
//       floatingActionButton: BtnNav(),
//     ));
//   }
// }
//
// class BtnNav extends StatelessWidget {
//   const BtnNav({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton(
//       onPressed: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => MoboxScreen()));
//       },
//     );
//   }
// }
//
// class TextCustom extends StatelessWidget {
//   const TextCustom({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(context.watch<CounterProvider>().counter.toString());
//   }
// }
//
// class CounterProvider extends ChangeNotifier {
//   int _counter = 0;
//
//   int get counter => _counter;
//
//   void add() {
//     _counter++;
//     notifyListeners();
//   }
// }
