import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:vpnx/server_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return (
        //child: Text('Home Screen'),
        const ListTileApp());
  }
}

class Server {
  final String name;
  final String countryCode;
  final String serverProtocol;

  const Server({
    required this.name,
    required this.countryCode,
    required this.serverProtocol,
  });

  static Server fromJson(json) => Server(
        name: json['name'],
        countryCode: json['countryCode'],
        serverProtocol: json['serverProtocol'],
      );
}

class ListTileApp extends StatefulWidget {
  const ListTileApp({Key? key}) : super(key: key);
  @override
  State<ListTileApp> createState() => _ListTileAppState();
}

class _ListTileAppState extends State<ListTileApp> {
  late Future<List<Server>> serversFuture;

  static Future<List<Server>> getServers() async {
    final String res = await rootBundle.loadString('assets/servers.json');
    final serversData = await json.decode(res);
    final body = serversData['data'];
    return body.map<Server>(Server.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Server List")),
        body: FutureBuilder<List<Server>>(
          future: serversFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text(':-( ${snapshot.hasError}');
            } else if (snapshot.hasData) {
              final servers = snapshot.data!;
              return buildServers(servers);
            } else {
              throw ('Possible connection error');
            }
          },
        ),
      );

  @override
  void initState() {
    super.initState();
    serversFuture = getServers();
  }

  Widget buildServers(List<Server> servers) => ListView.builder(
        itemCount: servers.length,
        itemBuilder: (context, index) {
          final server = servers[index];
          return Card(
            child: ListTile(
              leading: Image(
                  image: AssetImage('icons/flags/png/${server.countryCode}.png',
                      package: 'country_icons')),
              subtitle: Text(server.serverProtocol),
              trailing: const Icon(Icons.arrow_forward_ios),
              isThreeLine: true,
              title: Text(server.name),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ServerPage(server: server),
                ));
              },
            ),
          );
        },
      );
}
