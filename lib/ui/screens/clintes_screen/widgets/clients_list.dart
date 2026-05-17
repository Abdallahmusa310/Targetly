import 'package:easy_localization/easy_localization.dart';
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
    return BlocBuilder<ClinetCubit, Clientstate>(
      builder: (context, state) {
        if (state is Clientloading) {
          return const Center(child: CircularProgressIndicator());
        }

        final clientlist = state.clinet;

        if (clientlist == null || clientlist.isEmpty) {
          return Center(child: Text('No clients found'.tr()));
        }

        final sortedClientList = List.from(clientlist)
          ..sort((a, b) {
            final dateA = a.createdAt ?? DateTime(0);
            final dateB = b.createdAt ?? DateTime(0);
            return dateB.compareTo(dateA);
          });

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ClinetCard(clinetModel: sortedClientList[index]);
          },
          itemCount: sortedClientList.length,
        );
      },
    );
  }
}
