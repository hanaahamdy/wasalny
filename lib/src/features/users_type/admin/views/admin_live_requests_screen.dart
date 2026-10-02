import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../../core/network/network_service.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/dialogs/success_dialog.dart';
import '../view_models/admin_live_requests_view_model.dart';
import 'widgets/admin_live_request_card.dart';

class AdminLiveRequestsScreen extends StatefulWidget {
  const AdminLiveRequestsScreen({super.key});

  @override
  State<AdminLiveRequestsScreen> createState() =>
      _AdminLiveRequestsScreenState();
}

class _AdminLiveRequestsScreenState extends State<AdminLiveRequestsScreen> {
  late final AdminLiveRequestsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AdminLiveRequestsViewModel(injector<NetworkService>());
    _viewModel.loadRequests();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.scenarioBackground,
        appBar: CustomAppBar(title: LocaleKeys.workflowLiveRequests),
        body: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, _) {
            if (_viewModel.isLoading && _viewModel.requests.isEmpty) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.scenarioPrimary,
                ),
              );
            }

            if (_viewModel.errorMessage != null &&
                _viewModel.requests.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(AppPadding.pW20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _viewModel.errorMessage!,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppSize.sH12),
                      FilledButton(
                        onPressed: _viewModel.loadRequests,
                        child: Text(LocaleKeys.retry),
                      ),
                    ],
                  ),
                ),
              );
            }

            return RefreshIndicator(
              color: AppColors.scenarioPrimary,
              onRefresh: _viewModel.loadRequests,
              child: _viewModel.requests.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * .3,
                        ),
                        Center(child: Text(LocaleKeys.workflowNoRequests)),
                      ],
                    )
                  : ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.all(AppPadding.pW16),
                      itemCount: _viewModel.requests.length,
                      itemBuilder: (context, index) => AdminLiveRequestCard(
                        request: _viewModel.requests[index],
                        isProcessing: _viewModel.isProcessing(
                          _viewModel.requests[index].id,
                        ),
                        onAccept: () =>
                            _acceptRequest(_viewModel.requests[index].id),
                        onReject: () =>
                            _rejectRequest(_viewModel.requests[index].id),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _acceptRequest(int requestId) async {
    final accepted = await _viewModel.acceptRequest(requestId);
    if (!mounted) return;
    if (accepted) {
      await successDialog(
        context: context,
        title: LocaleKeys.adminLiveAccepted,
      );
      return;
    }
    _showResult(_viewModel.errorMessage!);
  }

  Future<void> _rejectRequest(int requestId) async {
    final shouldReject = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(LocaleKeys.adminLiveReject),
        content: Text(LocaleKeys.adminLiveRejectConfirmation),
        actions: [
          TextButton(
            onPressed: () => Go.back(false),
            child: Text(LocaleKeys.cancel),
          ),
          FilledButton(
            onPressed: () => Go.back(true),
            child: Text(LocaleKeys.adminLiveReject),
          ),
        ],
      ),
    );
    if (shouldReject != true || !mounted) return;

    final rejected = await _viewModel.rejectRequest(requestId);
    if (!mounted) return;
    _showResult(
      rejected ? LocaleKeys.adminLiveRejected : _viewModel.errorMessage!,
    );
  }

  void _showResult(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
