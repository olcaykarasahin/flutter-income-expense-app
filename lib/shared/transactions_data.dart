import 'package:flutter/material.dart';
import 'package:gelir_gider/models/transaction_model.dart';

const Map<PaymentType, IconData> incomePaymentMap = {
  PaymentType.cash: Icons.payments,
  PaymentType.bankCard: Icons.account_balance,
};

const Map<PaymentType, IconData> expensePaymentMap = {
  PaymentType.cash: Icons.payments,
  PaymentType.bankCard: Icons.account_balance,
  PaymentType.creditCard: Icons.credit_card,
};

const Map<String, IconData> expenseCategoryIcons = {
  "Yemek/Market": Icons.shopping_cart,
  "Ulaşım": Icons.directions_bus,
  "Kira": Icons.home,
  "Faturalar": Icons.receipt_long,
  "Alışveriş": Icons.shopping_bag,
  "Sağlık": Icons.local_hospital,
  "Eğitim": Icons.school,
  "Abonelik": Icons.subscriptions,
  "Diğer": Icons.more_horiz,
};
const Map<String, IconData> incomeCategoryIcons = {
  "Maaş": Icons.payments,
  "Ek Gelir": Icons.add_circle,
  "Diğer": Icons.more_horiz,
};

const List<String> months = [
  "Ocak",
  "Şubat",
  "Mart",
  "Nisan",
  "Mayıs",
  "Haziran",
  "Temmuz",
  "Agustos",
  "Eylül",
  "Ekim",
  "Kasım",
  "Aralık",
];
