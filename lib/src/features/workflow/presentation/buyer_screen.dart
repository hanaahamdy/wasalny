import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../domain/workflow_order.dart';
import 'widgets/workflow_widgets.dart';

class BuyerScreen extends StatefulWidget {
  const BuyerScreen({super.key});

  @override
  State<BuyerScreen> createState() => _BuyerScreenState();
}

class _BuyerScreenState extends State<BuyerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _clientController = TextEditingController();
  final _facebookController = TextEditingController();
  final List<_CategoryInput> _categories = [_CategoryInput()];
  bool _facebookLive = false;

  double get _total => _categories.fold(0, (sum, item) => sum + item.total);

  @override
  void dispose() {
    _clientController.dispose();
    _facebookController.dispose();
    for (final item in _categories) {
      item.dispose();
    }
    super.dispose();
  }

  void _addCategory() => setState(() => _categories.add(_CategoryInput()));

  void _removeCategory(int index) {
    if (_categories.length == 1) return;
    setState(() => _categories.removeAt(index).dispose());
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    WorkflowStore.instance.addOrder(
      clientName: _clientController.text.trim(),
      categories: _categories
          .map(
            (item) => WorkflowCategory(
              name: item.name.text.trim(),
              count: int.parse(item.count.text),
              unitPrice: double.parse(item.price.text),
            ),
          )
          .toList(),
      facebookLiveRequested: _facebookLive,
      facebookRequest: _facebookController.text.trim(),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Order sent. Waiting for admin approval.')),
    );
    _clientController.clear();
    _facebookController.clear();
    for (final item in _categories) {
      item.dispose();
    }
    setState(() {
      _categories
        ..clear()
        ..add(_CategoryInput());
      _facebookLive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WorkflowPage(
      title: 'Buyer order',
      child: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _clientController,
              decoration: const InputDecoration(labelText: 'Client name', border: OutlineInputBorder()),
              validator: _required,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text('Categories', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                ),
                TextButton.icon(onPressed: _addCategory, icon: const Icon(Icons.add), label: const Text('Add category')),
              ],
            ),
            ...List.generate(
              _categories.length,
              (index) => _CategoryEditor(
                index: index,
                input: _categories[index],
                canRemove: _categories.length > 1,
                onChanged: () => setState(() {}),
                onRemove: () => _removeCategory(index),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Expanded(child: Text('Total price', style: TextStyle(fontWeight: FontWeight.bold))),
                    Text('${_total.toStringAsFixed(2)} EGP', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Request Facebook Live'),
                      subtitle: const Text('This request will wait for admin approval'),
                      value: _facebookLive,
                      onChanged: (value) => setState(() => _facebookLive = value),
                    ),
                    if (_facebookLive)
                      TextFormField(
                        controller: _facebookController,
                        maxLines: 2,
                        decoration: const InputDecoration(labelText: 'Live request details', border: OutlineInputBorder()),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.send_outlined),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14),
                child: Text('Send for admin approval'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? _required(String? value) => value == null || value.trim().isEmpty ? 'Required' : null;
}

class _CategoryInput {
  final name = TextEditingController();
  final count = TextEditingController(text: '1');
  final price = TextEditingController();

  double get total => (int.tryParse(count.text) ?? 0) * (double.tryParse(price.text) ?? 0);

  void dispose() {
    name.dispose();
    count.dispose();
    price.dispose();
  }
}

class _CategoryEditor extends StatelessWidget {
  final int index;
  final _CategoryInput input;
  final bool canRemove;
  final VoidCallback onChanged;
  final VoidCallback onRemove;

  const _CategoryEditor({required this.index, required this.input, required this.canRemove, required this.onChanged, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text('Category ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold))),
                if (canRemove) IconButton(onPressed: onRemove, icon: const Icon(Icons.delete_outline, color: Colors.red)),
              ],
            ),
            TextFormField(
              controller: input.name,
              decoration: const InputDecoration(labelText: 'Category name', border: OutlineInputBorder()),
              validator: (value) => value == null || value.trim().isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: input.count,
                    onChanged: (_) => onChanged(),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(labelText: 'Count', border: OutlineInputBorder()),
                    validator: (value) => (int.tryParse(value ?? '') ?? 0) < 1 ? 'Invalid' : null,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: input.price,
                    onChanged: (_) => onChanged(),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                    decoration: const InputDecoration(labelText: 'Unit price', border: OutlineInputBorder()),
                    validator: (value) => (double.tryParse(value ?? '') ?? 0) <= 0 ? 'Invalid' : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
