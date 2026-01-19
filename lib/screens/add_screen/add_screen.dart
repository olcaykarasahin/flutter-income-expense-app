import 'package:flutter/material.dart';
import 'package:gelir_gider/models/transaction_model.dart';
import 'package:gelir_gider/providers/transaction_provider.dart';
import 'package:gelir_gider/shared/transaction_builder.dart';
import 'package:gelir_gider/shared/transaction_widgets/amount_textformfield.dart';
import 'package:gelir_gider/shared/transaction_widgets/category_dropdown.dart';
import 'package:gelir_gider/shared/transaction_widgets/comment_textformfield.dart';
import 'package:gelir_gider/shared/transaction_widgets/date_inkwell.dart';
import 'package:gelir_gider/shared/transaction_widgets/payment_inkwell.dart';
import 'package:provider/provider.dart';

class AddScreen extends StatefulWidget {
  final bool isIncome;
  const AddScreen({super.key, required this.isIncome});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  late DateTime _selectedDate;
  late bool _isIncome;
  late TextEditingController _amountController;
  late TextEditingController _commentController;
  late PaymentType _selectedPaymentType;
  late String _selectedCategory;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _isIncome = widget.isIncome;
    _amountController = TextEditingController();
    _commentController = TextEditingController();
    _selectedPaymentType = PaymentType.cash;
    _selectedCategory = _isIncome ? "Maaş" : "Yemek/Market";
  }

  @override
  void dispose() {
    _amountController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isIncome ? "Gelir Ekle" : "Gider Ekle"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DateInkwell(
                  date: _selectedDate,
                  onChanged: (newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  },
                ),

                const SizedBox(height: 20),

                PaymentInkWellWidget(
                  isIncome: _isIncome,
                  selectedPaymentType: _selectedPaymentType,
                  onChanged: (newPaymentType) {
                    setState(() {
                      _selectedPaymentType = newPaymentType;
                    });
                  },
                ),

                const SizedBox(height: 20),

                CategoryDropdownWidget(
                  isIncome: _isIncome,
                  selectedCategory: _selectedCategory,
                  onChanged: (newCategory) {
                    setState(() {
                      _selectedCategory = newCategory;
                    });
                  },
                ),

                const SizedBox(height: 20),

                CommentTextFormField(commentcontroller: _commentController),

                const SizedBox(height: 20),

                AmountTextFormFieldWidget(
                  isIncome: _isIncome,
                  controller: _amountController,
                ),

                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A90E2),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "İşlemi İptal Et",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4A90E2),
                      ),
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        final isValid = _formKey.currentState!.validate();
                        if (!isValid) return;

                        final amount = double.tryParse(
                          _amountController.text.replaceAll(',', '.'),
                        );

                        if (amount == null) {
                          return;
                        }

                        final transaction = buildTransaction(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          date: _selectedDate,
                          isIncome: _isIncome,
                          paymentType: _selectedPaymentType,
                          category: _selectedCategory,
                          comment: _commentController.text.trim(),
                          amount: amount,
                        );
                        context.read<TransactionProvider>().addTransaction(
                          transaction,
                        );

                        Navigator.pop(context);
                      },

                      child: const Text(
                        "İşlemi Kaydet",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
