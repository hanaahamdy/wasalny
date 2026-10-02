part of '../buyer_screen.dart';

class BuyerLiveRequestScreen extends StatefulWidget {
  const BuyerLiveRequestScreen({super.key});
  @override
  State<BuyerLiveRequestScreen> createState() => _BuyerLiveRequestScreenState();
}

class _BuyerLiveRequestScreenState extends State<BuyerLiveRequestScreen> {
  late final BuyerViewModel _viewModel;
  final _formKey = GlobalKey<FormState>();
  final _broadcastTitleController = TextEditingController();
  final _detailsController = TextEditingController();
  int? _requestId;

  @override
  void initState() {
    super.initState();
    _viewModel = BuyerViewModel(injector<NetworkService>());
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _broadcastTitleController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  Future<void> _requestLive() async {
    if (!_formKey.currentState!.validate()) return;
    final request = await _viewModel.addLiveRequest(
      broadcastTitle: _broadcastTitleController.text.trim(),
      details: _detailsController.text.trim(),
    );
    if (!mounted) return;
    if (request == null) {
      await showAppErrorDialog(
        context: context,
        message: _viewModel.liveRequestError ?? LocaleKeys.exceptionError,
      );
      return;
    }
    setState(() => _requestId = request.id);
  }

  @override
  Widget build(BuildContext context) => WorkflowPage(
    title: LocaleKeys.workflowLiveRequest,
    child: _requestId == null ? _buildForm() : _buildStatus(),
  );

  Widget _buildForm() => Form(
    key: _formKey,
    child: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.moreProfileIconBackground,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(
                Icons.verified_user_outlined,
                color: AppColors.scenarioPrimary,
              ),
              const SizedBox(width: 12),
              Expanded(child: Text(LocaleKeys.workflowLiveApprovalNotice)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _broadcastTitleController,
          decoration: InputDecoration(
            labelText: LocaleKeys.workflowLiveTitle,
            border: const OutlineInputBorder(),
          ),
          validator: _required,
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: _detailsController,
          maxLines: 4,
          decoration: InputDecoration(
            labelText: LocaleKeys.workflowLiveDetails,
            hintText: LocaleKeys.workflowLiveDetailsHint,
            border: const OutlineInputBorder(),
          ),
          validator: _required,
        ),
        const SizedBox(height: 20),
        ListenableBuilder(
          listenable: _viewModel,
          builder: (context, _) => FilledButton.icon(
            onPressed: _viewModel.isSubmittingLiveRequest ? null : _requestLive,
            icon: _viewModel.isSubmittingLiveRequest
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.send_outlined),
            label: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Text(LocaleKeys.workflowAskAdminLive),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildStatus() => ListenableBuilder(
    listenable: _viewModel,
    builder: (context, _) {
      final request = _viewModel.liveRequests.firstWhere(
        (item) => item.id == _requestId,
      );
      final approved = request.status == WorkflowLiveStatus.approved;
      final started = request.status == WorkflowLiveStatus.started;
      final statusColor = started || approved
          ? AppColors.successGreen
          : AppColors.bookingPendingYellow;
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            color: AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor: statusColor.withValues(alpha: .12),
                    child: Icon(
                      started
                          ? Icons.videocam
                          : approved
                          ? Icons.check_circle_outline
                          : Icons.hourglass_top,
                      size: 34,
                      color: statusColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    started
                        ? LocaleKeys.workflowLiveStarted
                        : approved
                        ? LocaleKeys.workflowApprovedReady
                        : LocaleKeys.workflowWaitingAdmin,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    started
                        ? LocaleKeys.workflowNewSessionNotice
                        : approved
                        ? LocaleKeys.workflowAdminApprovedSession
                        : LocaleKeys.workflowStartUnlockNotice,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: approved
                          ? () => _viewModel.startLive(request.id)
                          : null,
                      icon: const Icon(Icons.live_tv_outlined),
                      label: Text(
                        started
                            ? LocaleKeys.workflowLiveActive
                            : LocaleKeys.workflowStartLive,
                      ),
                    ),
                  ),
                  if (started) ...[
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => setState(() {
                        _requestId = null;
                        _detailsController.clear();
                      }),
                      child: Text(LocaleKeys.workflowRequestAnotherLive),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
    },
  );

  String? _required(String? value) => value == null || value.trim().isEmpty
      ? LocaleKeys.workflowRequired
      : null;
}
