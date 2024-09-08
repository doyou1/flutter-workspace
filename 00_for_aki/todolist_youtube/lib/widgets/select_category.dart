import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todolist_youtube/utils/utils.dart';
import 'package:todolist_youtube/widgets/circle_container.dart';
import 'package:todolist_youtube/providers/providers.dart';

class SelectCategory extends ConsumerWidget {
  const SelectCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<TaskCategories> categories = TaskCategories.values.toList();
    final selectedCategory = ref.watch(categoryProvider);

    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Text("Category", style: context.textTheme.titleLarge),
          Gap(10),
          Expanded(
              child: ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    final category = categories[index];
                    return InkWell(
                      onTap: () => _selectCategory(context, ref, category),
                      borderRadius: BorderRadius.circular(30),
                      child: CircleContainer(
                        color: category.color.withOpacity(0.3),
                        child: Icon(category.icon,
                            color: category == selectedCategory
                                ? context.colorScheme.primary
                                : category.color),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) => Gap(8),
                  itemCount: categories.length))
        ],
      ),
    );
  }
}

void _selectCategory(
    BuildContext context, WidgetRef ref, TaskCategories category) {
  ref.read(categoryProvider.notifier).state = category;
}
