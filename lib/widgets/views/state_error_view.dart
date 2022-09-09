import 'package:flutter/material.dart';

class StateErrorView extends StatelessWidget {
  final String? _message;
  final Function() _retry;

  const StateErrorView(this._message, this._retry, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (this._message == null) {
      return Container();
    }
    Future.delayed(
        Duration.zero,
        () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Error'),
                content: Text(_message ?? ""),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'OK');
                      _retry;
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            ));
    return Container();
  }
}
