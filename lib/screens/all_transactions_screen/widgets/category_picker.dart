import 'package:flutter/material.dart';

class CategoryPicker extends StatelessWidget {
  final Map<String, IconData> categories;
  final String? selectedCategory;
  final ValueChanged<String?> onChanged;

  const CategoryPicker({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => openShowModalBottomSheet(context),
        child: Card(
          color: Colors.grey.shade300,
          elevation: 1.5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(30),
            side: const BorderSide(color: Colors.black, width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  selectedCategory ?? "Tüm Kategoriler",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openShowModalBottomSheet(BuildContext context) {
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
              ListTile(
                leading: const Icon(Icons.all_inbox),
                textColor: selectedCategory == null
                    ? Colors.white
                    : Colors.black,

                title: const Center(
                  child: Text(
                    "Tüm Kategoriler",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                trailing: selectedCategory == null
                    ? const Icon(Icons.check)
                    : const SizedBox(),
                iconColor: Colors.white,

                onTap: () {
                  Navigator.pop(context);
                  onChanged(null);
                },
              ),
              ...categories.keys.map((category) {
                return ListTile(
                  leading: Icon(categories[category]),
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
