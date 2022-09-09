import 'package:blocapptest/widgets/views/state_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class LoadingOnly extends StatelessWidget {
  final Stream<StateLayout> stream;
  final Widget child;

  const LoadingOnly({Key? key, required this.child, required this.stream})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StateLayout>(
      stream: stream,
      builder: (context, snapshot) {
        return ModalProgressHUD(
          inAsyncCall: snapshot.data == StateLayout.showLoading,
          progressIndicator: const CupertinoActivityIndicator(),
          child: child,
        );
      },
    );
  }
}

class ModalProgressHUD extends StatefulWidget {
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Widget progressIndicator;
  final Offset? offset;
  final bool dismissible;
  final Widget child;

  const ModalProgressHUD({
    Key? key,
    required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.grey,
    this.progressIndicator = const CircularProgressIndicator.adaptive(),
    this.offset,
    this.dismissible = false,
    required this.child,
  }) : super(key: key);

  @override
  State<ModalProgressHUD> createState() => _ModalProgressHUDState();
}

class _ModalProgressHUDState extends State<ModalProgressHUD> {
  final keyContainer = GlobalKey();
  Size size = const Size(0, 0);

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _isAsyncCall.sink.add(widget.inAsyncCall);
    });
  }


  @override
  void didUpdateWidget(covariant ModalProgressHUD oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    _isAsyncCall.sink.add(widget.inAsyncCall);
  }

  final BehaviorSubject<bool> _isAsyncCall = BehaviorSubject();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _isAsyncCall.close();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      color: Colors.transparent,
      key: keyContainer,
      child: Stack(
        children: [
          widget.child,
          StreamBuilder<bool>(
              stream: _isAsyncCall.stream,
              builder: (context, snapshot) {
                return Visibility(
                  visible: widget.inAsyncCall,
                  child: Center(
                      child: Center(child: widget.progressIndicator)),
                );
              }),
          StreamBuilder<bool>(
              stream: _isAsyncCall.stream,
              builder: (context, snapshot) {
                return Visibility(
                  visible: widget.inAsyncCall,
                  child: Container(
                    height: height,
                    width: width,
                    color: Colors.transparent,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
