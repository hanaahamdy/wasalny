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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(
          LocaleKeys.workflowClientNumberTitle(widget.order.clientName),
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
            onPressed: () => Navigator.pop(context),
            child: Text(LocaleKeys.workflowCancel),
          ),
          FilledButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) return;
              final messenger = ScaffoldMessenger.of(context);
              widget.viewModel.completeOrder(
                widget.order.id,
                _controller.text.trim(),
              );
              Navigator.pop(context);
              messenger.showSnackBar(
                SnackBar(
                  content: Text(LocaleKeys.workflowClientNumberAdded),
                ),
              );
            },
            child: Text(LocaleKeys.workflowSaveComplete),
          ),
        ],
      );
  }
}
