import 'package:flutter/material.dart';
import 'package:shikimori_app/api_client.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: (() {
                    var apiClient = ApiClient();
                    apiClient.getAnimeRateList();
                  }),
                  child: Text("get"))
            ],
          ),
        ),
        appBar: AppBar(),
        drawer: Drawer(
          child: ListView(
            children: const [
              ListTile(
                title: Text("Аниме"),
              ),
              ListTile(
                title: Text("Манга"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
