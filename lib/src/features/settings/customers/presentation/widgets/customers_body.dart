part of '../imports/presentation_imports.dart';

class CustomersBody extends StatelessWidget {
  final CustomersViewModel viewModel;

  const CustomersBody({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (viewModel.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(viewModel.errorMessage!),
            SizedBox(height: AppSize.sH10),
            TextButton(
              onPressed: viewModel.load,
              child: Text(LocaleKeys.retry),
            ),
          ],
        ),
      );
    }
    final customers = viewModel.customers;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            AppPadding.pW12,
            AppPadding.pH14,
            AppPadding.pW12,
            0,
          ),
          child: TextField(
            onChanged: viewModel.search,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: LocaleKeys.search,
              prefixIcon: const Icon(Icons.search),
              suffixIcon: viewModel.isSearching
                  ? Padding(
                      padding: EdgeInsets.all(AppPadding.pW12),
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    )
                  : null,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: customers.isEmpty
              ? Center(child: Text(LocaleKeys.noResultFound))
              : ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.pW12,
                    vertical: AppPadding.pH14,
                  ),
                  itemCount: customers.length,
                  separatorBuilder: (_, _) => SizedBox(height: AppSize.sH10),
                  itemBuilder: (_, index) =>
                      _CustomerCard(customer: customers[index]),
                ),
        ),
      ],
    );
  }
}
