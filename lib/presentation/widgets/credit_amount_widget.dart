import 'package:cred_assignment/presentation/providers/stack_provider.dart';
import 'package:cred_assignment/presentation/widgets/credit_amount_slider.dart';
import 'package:cred_assignment/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreditAmountWidget extends ConsumerWidget {
  final VoidCallback onNext;

  const CreditAmountWidget({super.key, required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stackItemsAsync = ref.watch(stackItemsProvider);
    final creditAmount = ref.watch(creditAmountProvider);
    final selectedCreditAmount = ref.watch(selectedCreditAmountProvider);
    final isNextScreenActive = ref.watch(isNextScreenActiveProvider1);

    return stackItemsAsync.when(
      data: (stackItems) {
        final stackItem = stackItems.isNotEmpty ? stackItems[0] : null;

        if (stackItem == null) {
          return const Center(
            child: Text(
              "No data available.",
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        String description =
            stackItem.cardDescription ?? "No description available.";

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: Colors.blueGrey[900],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Text(
                isNextScreenActive
                    ? "Credit Amount:  ₹${creditAmount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}"
                    : (stackItem.openStateTitle ?? "No data"),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Text(
                stackItem.openStateSubtitle ?? "No data",
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CreditAmountSlider(
                  minValue: stackItem.cardMinRange?.toDouble() ?? 0.0,
                  maxValue: stackItem.cardMaxRange?.toDouble() ?? 1000000.0,
                  initialValue: creditAmount.toDouble(),
                  creditAmount: creditAmount,
                  onChange: (value) {
                    if (value != creditAmount) {
                      ref.read(creditAmountProvider.notifier).state =
                          value.toInt();
                    }
                  },
                  amountText: stackItem.openStateFooter ?? "₹$creditAmount",
                  descriptionText: description,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: CustomElevatedButton(
                  ctaText: stackItem.ctaText ?? "Next",
                  onPressed: () {
                    if (selectedCreditAmount != creditAmount.toString()) {
                      ref.read(selectedCreditAmountProvider.notifier).state =
                          creditAmount.toString();
                    }
                    ref.read(isNextScreenActiveProvider1.notifier).state = true;
                    ref.read(isNextScreenActiveProvider2.notifier).state =
                        false;
                    onNext();
                  },
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      },

      loading: () => const Center(
        child: CircularProgressIndicator(color: Colors.orange),
      ),

      error: (error, stackTrace) => Center(
        child: Text(
          "An error occurred: $error",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
