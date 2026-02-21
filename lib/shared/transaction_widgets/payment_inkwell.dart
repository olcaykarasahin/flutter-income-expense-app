import 'package:flutter/material.dart';
import 'package:gelir_gider/models/transaction_model.dart';
import 'package:gelir_gider/shared/transactions_data.dart';

class PaymentInkWellWidget extends StatelessWidget {
  final bool isIncome;
  final PaymentType selectedPaymentType;
  final ValueChanged<PaymentType> onChanged;

  const PaymentInkWellWidget({
    super.key,
    required this.isIncome,
    required this.selectedPaymentType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => _openModalBottomSheet(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: "Ödeme Türü",
          labelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: colorScheme.primary,
          ),
          prefixIcon: const Icon(Icons.account_balance_wallet),
          border: const OutlineInputBorder(),
        ),
        child: Row(
          children: [
            Text(
              selectedPaymentType.label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  void _openModalBottomSheet(BuildContext context) {
    final paymentMap = isIncome ? incomePaymentMap : expensePaymentMap;
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...paymentMap.keys.map((payment) {
                return ListTile(
                  leading: Icon(paymentMap[payment]),
                  title: Center(
                    child: Text(
                      payment.label,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  trailing: payment == selectedPaymentType
                      ? const Icon(Icons.check)
                      : const SizedBox(),

                  textColor: payment == selectedPaymentType
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurface,

                  iconColor: payment == selectedPaymentType
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurfaceVariant,

                  tileColor: payment == selectedPaymentType
                      ? colorScheme.primaryContainer
                      : null,

                  onTap: () {
                    Navigator.pop(context);
                    onChanged(payment);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
