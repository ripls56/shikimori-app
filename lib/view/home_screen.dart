import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shikimori_app/cubit/home_cubit_cubit.dart';
import '../cubit/home_cubit_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: HomeCubit(),
      builder: (context, state) {
        var rates =
            context.select((HomeCubit cubit) => cubit.state.userRatesList);
        return SafeArea(
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (() {
                      context.read<HomeCubit>().getRateList(1156346);
                    }),
                    child: const Text("get"),
                  ),
                  if (rates.isNotEmpty)
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: rates.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          title: Text(rates[index].targetType),
                        );
                      }),
                    )
                  else
                    Container()
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
      },
    );
  }
}
