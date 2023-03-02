import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimori_app/api_client.dart';
import 'package:shikimori_app/presentation/home_screen/view/home_screen.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../feature/data/models/creditional/creditional.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileEmpty());

  Future<void> getCreditional() async {
    try {
      var apiClient = ApiClient();
      var response = await apiClient.getCreditionals();
      emit(ProfileInitial(response));
    } catch (ex) {
      emit(ProfileEmpty());
    }
  }

  Future<void> authorize(BuildContext context) async {
    var apiClient = ApiClient();
    var response = await getInitialLink();
    final linksStream = linkStream.listen((event) {
      if (event!.startsWith(apiClient.redirectUri.toString())) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
      }
    });
    launchUrl(Uri.parse('http://dfiosjgoisdfjgsfiod.com'),
        mode: LaunchMode.externalApplication);
  }
}
