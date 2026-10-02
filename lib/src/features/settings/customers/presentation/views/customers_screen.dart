part of '../imports/presentation_imports.dart';

class CustomersScreen extends StatefulWidget {
  const CustomersScreen({super.key});

  @override
  State<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends State<CustomersScreen> {
  late final CustomersViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = CustomersViewModel(injector<CustomersRepository>())..load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.customers),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (_, _) => CustomersBody(viewModel: _viewModel),
      ),
    );
  }
}
