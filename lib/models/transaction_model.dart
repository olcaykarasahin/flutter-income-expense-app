enum TransactionType { income, expense }

enum PaymentType { cash, bankCard, creditCard }

extension PaymentTypeX on PaymentType {
  String get label {
    switch (this) {
      case PaymentType.cash:
        return "Nakit";
      case PaymentType.bankCard:
        return "Banka Kartı";
      case PaymentType.creditCard:
        return "Kredi Kartı";
    }
  }
}

extension TransactionTypeX on TransactionType {
  String get label {
    switch (this) {
      case TransactionType.income:
        return "Gelir";
      case TransactionType.expense:
        return "Gider";
    }
  }
}

class TransactionModel {
  final String id;
  final DateTime date;
  final TransactionType type;
  final PaymentType paymentType;
  final String category;
  final String comment;
  final double amount;

  TransactionModel({
    required this.id,
    required this.date,
    required this.type,
    this.paymentType = PaymentType.cash,
    required this.category,
    required this.comment,
    required this.amount,
  });

  bool get isIncome => type == TransactionType.income;
}
