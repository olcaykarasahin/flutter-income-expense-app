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
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colorScheme.outline, width: 2),
      ),
      child: InkWell(
        onTap: () => openShowModalBottomSheet(context),
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
    );
  }

  void openShowModalBottomSheet(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    showModalBottomSheet(
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
                tileColor: selectedCategory == null
                    ? colorScheme.primaryContainer
                    : null,
                leading: const Icon(Icons.all_inbox),
                textColor: selectedCategory == null
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurface,
                iconColor: selectedCategory == null
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant,

                title: const Center(
                  child: Text(
                    "Tüm Kategoriler",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
                trailing: selectedCategory == null
                    ? const Icon(Icons.check)
                    : const SizedBox(),

                onTap: () {
                  Navigator.pop(context);
                  onChanged(null);
                },
              ),
              ...categories.keys.map((category) {
                return ListTile(
                  tileColor: category == selectedCategory
                      ? colorScheme.primaryContainer
                      : null,
                  leading: Icon(categories[category]),
                  textColor: category == selectedCategory
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurface,
                  iconColor: category == selectedCategory
                      ? colorScheme.onPrimaryContainer
                      : colorScheme.onSurfaceVariant,

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
