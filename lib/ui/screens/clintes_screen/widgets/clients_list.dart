import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/Clients/client_cubit/clinet_cubit.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/clinet_card.dart';

class ClientsList extends StatefulWidget {
  const ClientsList({super.key});

  @override
  State<ClientsList> createState() => _ClientsListState();
}

class _ClientsListState extends State<ClientsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClinetCubit, ClinetState>(
      builder: (context, state) {
        if (state is Clinetloading) {
          return const Center(child: CircularProgressIndicator());
        }
        final clientlist = state.clinet;
        if (clientlist == null || clientlist.isEmpty) {
          return const Center(child: Text('No clients found'));
        }
        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ClinetCard(clinetModel: clientlist[index]);
          },
          itemCount: clientlist.length,
        );
      },
    );
  }
}
