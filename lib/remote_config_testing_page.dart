import 'package:flutter/material.dart';
import 'package:flutter_training/remote_config_provider.dart';
import 'package:provider/provider.dart';

class RemoteConfigTesting extends StatelessWidget {
  const RemoteConfigTesting({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RemoteConfigProvider>(
      builder:
          ((context, value, child) =>
              !value.isLoading
                  ? Scaffold(
                    appBar: AppBar(title: Text("Remote Config")),
                    body: Center(child: CircularProgressIndicator()),
                  )
                  : Scaffold(
                    appBar: AppBar(title: Text("Remote Config")),
                    body: Center(child: Text("Data from config}")),
                  )),
    );
  }
}
