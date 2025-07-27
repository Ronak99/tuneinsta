import 'package:flutter/material.dart';

class CustomSelector<T> extends StatelessWidget {
  final String label;
  final List<T> selectedItems;
  final List<T> allItems;
  final String Function(T item) getLabel;
  final void Function(T item) onAdd;
  final void Function(T item) onRemove;

  const CustomSelector({
    super.key,
    required this.label,
    required this.selectedItems,
    required this.allItems,
    required this.getLabel,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.brown.shade50,
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
           Text(
              label,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          const SizedBox(height: 12),
          Wrap(
            children: allItems.map((item) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: selectedItems.contains(item),
                    onChanged: (isSelected) {
                      if(isSelected!) {
                        onAdd(item);
                      } else {
                        onRemove(item);
                      }
                    },
                  ),
                  const SizedBox(width: 4),
                  Text(getLabel(item)),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
