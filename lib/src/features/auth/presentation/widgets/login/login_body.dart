part of '../../imports/view_imports.dart';

class _LoginBody extends StatefulWidget {
  const _LoginBody();

  @override
  State<_LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<_LoginBody> {
  final LoginParams params = LoginParams();
  _LoginTab selectedTab = _LoginTab.phone;

  @override
  void dispose() {
    params.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Form(
      key: params.formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pW20,
          vertical: AppPadding.pH8,
        ),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _LoginHeader(),
            AppSize.sH12.szH,
            _LoginFormCard(
              params: params,
              selectedTab: selectedTab,
              onTabChanged: (tab) => setState(() => selectedTab = tab),
            ),
          ],
        ),
      ),
    );
  }
}
