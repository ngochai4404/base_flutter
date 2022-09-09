import 'package:blocapptest/presentation/home/blog/home_cubit.dart';
import 'package:blocapptest/presentation/home/blog/home_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bloc = HomeCubit();

  @override
  void initState() {
    super.initState();
    bloc.getUserInfo();
  }

  @override
  Widget build(BuildContext ctx) {
    return BlocProvider(
      create: (ctx) => bloc,
      child: ContentHome(),
    );
  }
}

class ContentHome extends StatefulWidget {
  @override
  State<ContentHome> createState() => _ContentHomeState();
}

class _ContentHomeState extends State<ContentHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: BlocBuilder<HomeCubit, HomeState>(
              builder: (ctx, state) => Container(
                  child: state is HomeDataInitial
                      ? Text("CVHT")
                      : Text("Hi " + (state as HomeDataLoadSuccess).data))),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed("/login");
                },
                icon: Icon(Icons.logout))
          ],
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                  padding: const EdgeInsets.all(4.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/map");
                      },
                      iconSize: 50.0,
                      icon: Icon(
                        Icons.map_rounded,
                        color: Colors.white,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                  padding: const EdgeInsets.all(4.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("/pdf");
                      },
                      iconSize: 50.0,
                      icon: Icon(
                        Icons.picture_as_pdf,
                        color: Colors.white,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                  padding: const EdgeInsets.all(4.0),
                  child: IconButton(
                      onPressed: () {
                        getToken();

                      },
                      iconSize: 50.0,
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      )),
                ),
              ),
            ],
          ),
        ));
  }

  void getToken() {
    FirebaseMessaging.instance.getToken().then((value) => print("TOken is $value"));
  }
}
// return BlocBuilder<HomeCubit, HomeState>(
//     builder: (ctx, state) => Container(
//         child: state is HomeDataInitial
//             ? Text("")
//             : Text(
//                 (state as HomeDataLoadSuccess).data )));
