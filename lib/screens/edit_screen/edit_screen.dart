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

class EditTransactionScreen extends StatefulWidget {
  final TransactionModel updatedTransactionModel;

  const EditTransactionScreen({
    super.key,
    required this.updatedTransactionModel,
  });

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
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
    _selectedDate = widget.updatedTransactionModel.date;
    _isIncome = widget.updatedTransactionModel.isIncome;
    _amountController = TextEditingController(
      text: widget.updatedTransactionModel.amount.toString(),
    );
    _commentController = TextEditingController(
      text: widget.updatedTransactionModel.comment,
    );
    _selectedPaymentType = widget.updatedTransactionModel.paymentType;
    _selectedCategory = widget.updatedTransactionModel.category;
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
      appBar: AppBar(title: const Text("İşlem Değişikliği"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
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
                  onChanged: (newPaymnet) {
                    setState(() {
                      _selectedPaymentType = newPaymnet;
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "İşlemi İptal Et",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
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

                        final updated = buildTransaction(
                          id: widget.updatedTransactionModel.id,
                          date: _selectedDate,
                          isIncome: _isIncome,
                          paymentType: _selectedPaymentType,
                          category: _selectedCategory,
                          comment: _commentController.text.trim(),
                          amount: amount,
                        );

                        final provider = context.read<TransactionProvider>();

                        provider.updateTransaction(updated.id, updated);

                        provider.setSelectedMonth(
                          _selectedDate.year,
                          _selectedDate.month,
                        );

                        Navigator.pop(context);
                      },

                      child: const Text(
                        "İşlemi Güncelle",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
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
