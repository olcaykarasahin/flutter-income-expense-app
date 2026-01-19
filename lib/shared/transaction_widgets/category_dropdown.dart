import 'package:flutter/material.dart';
import 'package:gelir_gider/shared/transactions_data.dart';

class CategoryDropdownWidget extends StatelessWidget {
  final bool isIncome;
  final String selectedCategory;
  final ValueChanged<String> onChanged;

  const CategoryDropdownWidget({
    super.key,
    required this.isIncome,
    required this.selectedCategory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openModalBottomSheet(context),
      borderRadius: BorderRadius.circular(8),
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: "Kategori",
          labelStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Color(0xFF4A90E2),
          ),
          prefixIcon: Icon(Icons.assignment),
          border: OutlineInputBorder(),
        ),
        child: Row(
          children: [
            Text(selectedCategory, style: const TextStyle(fontSize: 18)),
            const Spacer(),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }

  void _openModalBottomSheet(BuildContext context) {
    final categoryMap = isIncome ? incomeCategoryIcons : expenseCategoryIcons;

    showModalBottomSheet(
      backgroundColor: const Color(0xFF4A90E2),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...categoryMap.keys.map((category) {
                return ListTile(
                  leading: Icon(categoryMap[category]),
                  textColor: category == selectedCategory
                      ? Colors.white
                      : Colors.black,

                  title: Center(
                    child: Text(
                      category,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  trailing: category == selectedCategory
                      ? const Icon(Icons.check)
                      : const SizedBox(),
                  iconColor: Colors.white,
                  onTap: () {
                    Navigator.pop(context);
                    onChanged(category);
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
