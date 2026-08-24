part of '../imports/presentation_imports.dart';

class CreateDeliveryScreen extends StatelessWidget {
  const CreateDeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>CreateDeliveryCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text(LocaleKeys.addDelivery)),
        body: const CreateDeliveryBody(),
      ),
    );
  }
}
