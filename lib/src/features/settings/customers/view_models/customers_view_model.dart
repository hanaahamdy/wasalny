import 'dart:async';

import 'package:flutter/foundation.dart';

import '../domain/repositories/customers_repository.dart';
import '../entity/customer.dart';

class CustomersViewModel extends ChangeNotifier {
  final CustomersRepository _repository;

  CustomersViewModel(this._repository);

  List<Customer> _customers = const [];
  bool _isLoading = false;
  bool _isSearching = false;
  String? _errorMessage;
  Timer? _searchDebounce;
  int _requestSequence = 0;

  List<Customer> get customers => _customers;
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  String? get errorMessage => _errorMessage;

  void search(String query) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(
      const Duration(milliseconds: 400),
      () => _fetchClients(query: query.trim(), isSearch: true),
    );
  }

  Future<void> load() => _fetchClients();

  Future<void> _fetchClients({String query = '', bool isSearch = false}) async {
    final requestId = ++_requestSequence;
    if (isSearch) {
      _isSearching = true;
    } else {
      _isLoading = true;
    }
    _errorMessage = null;
    notifyListeners();

    final isPhone = query.isNotEmpty && RegExp(r'^[0-9+ ]+$').hasMatch(query);
    final result = await _repository.fetchClients(
      name: query.isNotEmpty && !isPhone ? query : null,
      phone: isPhone ? query : null,
    );
    if (requestId != _requestSequence) return;
    result.when(
      (customers) => _customers = customers,
      (failure) => _errorMessage = failure.message,
    );
    _isLoading = false;
    _isSearching = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }
}
