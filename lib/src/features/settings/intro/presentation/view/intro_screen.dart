part of '../imports/view_imports.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _IntroView();
  }
}

class _IntroView extends StatefulWidget {
  const _IntroView();

  @override
  State<_IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<_IntroView> {
  late final IntroViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = IntroViewModel();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: IntroBody(viewModel: _viewModel));
  }
}
