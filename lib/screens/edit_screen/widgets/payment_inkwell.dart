import 'package:flutter/material.dart';
import 'package:gelir_gider/models/transaction_model.dart';

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

  static Map<PaymentType, IconData> incomePaymentMap = {
    PaymentType.cash: Icons.payments,
    PaymentType.bankCard: Icons.account_balance,
  };

  static Map<PaymentType, IconData> expensePaymentMap = {
    PaymentType.cash: Icons.payments,
    PaymentType.bankCard: Icons.account_balance,
    PaymentType.creditCard: Icons.credit_card,
  };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => _openModalBottomSheet(context),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: "Ödeme Türü",
          labelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Color(0xFF4A90E2),
          ),
          prefixIcon: Icon(Icons.account_balance_wallet),
          border: OutlineInputBorder(),
        ),
        child: Row(
          children: [
            Text(
              selectedPaymentType.label,
              style: const TextStyle(fontSize: 18),
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

    showModalBottomSheet(
      backgroundColor: const Color(0xFF4A90E2),

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
                  iconColor: Colors.white,

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
