import 'package:cred_assignment/presentation/providers/stack_provider.dart';
import 'package:cred_assignment/presentation/widgets/custom_button.dart';
import 'package:cred_assignment/presentation/widgets/plan_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlanSelectionCard extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const PlanSelectionCard({
    super.key,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stackItemsAsync = ref.watch(stackItemsProvider);
    final selectedPlanIndex = ref.watch(selectedPlanIndexProvider);
    final isNextScreenActive = ref.watch(isNextScreenActiveProvider2);

    return InkWell(
      onTap: () {
        ref.read(isNextScreenActiveProvider1.notifier).state = false;
        onBack();
      },
      child: Material(
        color: Colors.transparent,
        child: stackItemsAsync.when(
          data: (stackItems) {
            final stackItem = stackItems.isNotEmpty && stackItems.length > 1
                ? stackItems[1]
                : null;

            if (stackItem == null ||
                stackItem.items == null ||
                stackItem.items!.isEmpty) {
              return const Center(
                child: Text(
                  "No plans available.",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final items = stackItem.items!;

            String title = isNextScreenActive
                ? "${items[selectedPlanIndex]['emi'] ?? "₹0/mo"}  (${items[selectedPlanIndex]['duration'] ?? "0 months"})"
                : stackItem.openStateTitle ?? "No title";

            return ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 500),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[800],
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        )),
                    const SizedBox(height: 8),
                    Text(
                      stackItem.openStateSubtitle ?? "No subtitle",
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: PlanCard(
                              amount: item['emi'] ?? "₹0/mo",
                              months: item['duration'] ?? "0 months",
                              recommended: item['tag'] == "recommended",
                              isSelected: selectedPlanIndex == index,
                              onTap: () {
                                ref
                                    .read(selectedPlanIndexProvider.notifier)
                                    .state = index;
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        stackItem.openStateFooter ?? "Create your own plan",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                    Expanded(child: Container()),
                    SizedBox(
                      width: double.infinity,
                      child: CustomElevatedButton(
                        ctaText: stackItem.ctaText ?? "No data",
                        onPressed: () {
                          ref.read(isNextScreenActiveProvider2.notifier).state =
                              true;
                          onNext();
                        },
                      ),
                    ),
                    const SizedBox(height: 200),
                  ],
                ),
              ),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(color: Colors.orange),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              "Error: $error",
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
