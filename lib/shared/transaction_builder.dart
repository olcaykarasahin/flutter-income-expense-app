import 'package:gelir_gider/models/transaction_model.dart';

TransactionModel buildTransaction({
  required String id,
  required DateTime date,
  required bool isIncome,
  required PaymentType paymentType,
  required String category,
  required String comment,
  required double amount,
}) {
  return TransactionModel(
    id: id,
    date: date,
    type: isIncome ? TransactionType.income : TransactionType.expense,
    paymentType: paymentType,
    category: category,
    comment: comment,
    amount: amount,
  );
}
