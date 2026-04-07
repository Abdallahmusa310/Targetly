import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/Clients/client_cubit/clinet_cubit.dart';
import 'package:targetly/logic/target/target_cubit/cubit/target_cubit.dart';
import 'package:targetly/ui/screens/home_screen/widgets/state_card.dart';

class StatList extends StatelessWidget {
  const StatList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TargetCubit, TargetState>(
      builder: (context, state) {
        final clientcubit = context.watch<ClinetCubit>();
        final totalclient = clientcubit.getClientsCount();
        final totalfees = clientcubit.getTotalFees();
        double comissionpercent = 0;
        if (state is TargetSuccess) {
          comissionpercent = state.target?.commission ?? 0;
        }
        final comissionvalue = totalfees * (comissionpercent / 100);
        return Row(
          children: [
            Expanded(
              child: BuildStatCard(
                title: 'Commission',
                value: comissionvalue.toString(),
                icon: Icon(Icons.monetization_on, color: Colors.white),
                color: Color(0xFF5B5F97),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: BuildStatCard(
                title: 'Clients',
                value: totalclient.toString(),
                icon: Icon(Icons.people, color: Colors.white),
                color: Color.fromARGB(255, 13, 157, 201),
              ),
            ),
          ],
        );
      },
    );
  }
}
