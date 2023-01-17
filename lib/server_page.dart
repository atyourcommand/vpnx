import 'package:flutter/material.dart';
import 'package:vpnx/home_screen.dart';
import 'package:flutter/cupertino.dart';

class ServerPage extends StatelessWidget {
  final Server server;

  const ServerPage({
    Key? key,
    required this.server,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(server.name),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Image.network(
                'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                height: 400,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Text(
                server.name,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              CupertinoButton.filled(
                onPressed: () {},
                child: const Text('Connect'),
              ),
            ],
          ),
        ),
      );
}
