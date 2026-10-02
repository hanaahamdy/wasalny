part of '../aliaa_screen.dart';

class _ClientNumberDialog extends StatefulWidget {
  final WorkflowOrder order;
  final AliaaViewModel viewModel;

  const _ClientNumberDialog({required this.order, required this.viewModel});

  @override
  State<_ClientNumberDialog> createState() => _ClientNumberDialogState();
}

class _ClientNumberDialogState extends State<_ClientNumberDialog> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        LocaleKeys.workflowClientNumberTitle(name: widget.order.clientName),
      ),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          autofocus: true,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
          ],
          decoration: InputDecoration(
            labelText: LocaleKeys.workflowClientPhoneNumber,
            border: const OutlineInputBorder(),
          ),
          validator: (value) => value == null || value.trim().length < 7
              ? LocaleKeys.workflowValidNumber
              : null,
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.pop(context),
          child: Text(LocaleKeys.workflowCancel),
        ),
        FilledButton(
          onPressed: _isSubmitting ? null : _sendToCustomer,
          child: _isSubmitting
              ? SizedBox.square(
                  dimension: AppSize.sH18,
                  child: CircularProgressIndicator(strokeWidth: AppSize.sH2),
                )
              : Text(LocaleKeys.workflowSaveComplete),
        ),
      ],
    );
  }

  Future<void> _sendToCustomer() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    final messenger = ScaffoldMessenger.of(context);
    final sent = await widget.viewModel.sendToCustomer(
      widget.order.id,
      _controller.text,
    );
    if (!mounted) return;
    if (sent) {
      final navigator = Navigator.of(context);
      final successContext = navigator.context;
      navigator.pop();
      if (!successContext.mounted) return;
      await successDialog(
        context: successContext,
        title: LocaleKeys.workflowClientNumberAdded,
      );
    } else {
      setState(() => _isSubmitting = false);
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            widget.viewModel.errorMessage ?? LocaleKeys.exceptionError,
          ),
        ),
      );
    }
  }
}
