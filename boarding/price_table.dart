import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceTable extends StatelessWidget {
  final Map<String, dynamic> pricing;
  final NumberFormat _currencyFormat = NumberFormat.currency(
    symbol: 'Rs ',
    decimalDigits: 0,
  );

  PriceTable({super.key, required this.pricing});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.blue.shade100,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...pricing.entries.map((entry) {
              if (entry.value is Map<String, dynamic>) {
                return _buildCategoryWithSubPrices(
                  entry.key,
                  entry.value as Map<String, dynamic>,
                );
              } else {
                return _buildSimplePrice(entry.key, entry.value);
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSimplePrice(String service, dynamic price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(service),
          Text(
            _currencyFormat.format(price),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryWithSubPrices(
    String category,
    Map<String, dynamic> subPrices,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...subPrices.entries.map((subEntry) {
          return Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${subEntry.key}:'),
                Text(
                  _currencyFormat.format(subEntry.value),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 8),
      ],
    );
  }
}
