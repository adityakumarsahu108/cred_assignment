import 'package:cred_assignment/presentation/widgets/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cred_assignment/presentation/providers/stack_provider.dart';

class MoneyTransferWidget extends ConsumerWidget {
  final VoidCallback onBack;

  const MoneyTransferWidget({super.key, required this.onBack});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stackItemsAsync = ref.watch(stackItemsProvider);

    return InkWell(
      onTap: () {
        ref.read(isNextScreenActiveProvider2.notifier).state = false;
        onBack();
      },
      child: Material(
        color: Colors.transparent,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 400,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: Colors.blueGrey[700],
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: stackItemsAsync.when(
              data: (stackItems) {
                final stackItem = stackItems.isNotEmpty ? stackItems[2] : null;

                if (stackItem == null) {
                  return const Center(
                    child: Text(
                      "No data available.",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                final accountToggleState = List.generate(
                  stackItem.items?.length ?? 0,
                  (_) => ValueNotifier<bool>(false),
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        stackItem.openStateTitle ??
                            "Where should we send the money?",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        stackItem.openStateSubtitle ??
                            "Amount will be credited to this bank account. EMI will also be debited from this bank account.",
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (stackItem.items != null)
                      ...List.generate(stackItem.items!.length, (index) {
                        final item = stackItem.items![index];
                        return ValueListenableBuilder<bool>(
                          valueListenable: accountToggleState[index],
                          builder: (context, isSelected, _) {
                            return ListTile(
                              leading: const Icon(Icons.account_balance,
                                  color: Colors.white),
                              title: Text(
                                item['title']?.toString() ?? 'No data',
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                item['subtitle']?.toString() ?? 'No data',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              trailing: Switch(
                                value: isSelected,
                                onChanged: (value) {
                                  for (var notifier in accountToggleState) {
                                    notifier.value = false;
                                  }
                                  accountToggleState[index].value = value;
                                },
                                activeColor: Colors.orange,
                              ),
                            );
                          },
                        );
                      }),
                    const SizedBox(height: 5),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        stackItem.openStateFooter ?? 'Change account',
                        style: const TextStyle(color: Colors.orange),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomElevatedButton(
                        ctaText: stackItem.ctaText ?? 'Tap for 1-click KYC',
                        onPressed: () {
                          final selectedAccountIndex = accountToggleState
                              .indexWhere((notifier) => notifier.value);
                          if (selectedAccountIndex != -1) {
                            final selectedAccount =
                                stackItem.items![selectedAccountIndex];
                            if (kDebugMode) {
                              print('Selected Account: $selectedAccount');
                            }
                          } else {
                            if (kDebugMode) {
                              print('No account selected');
                            }
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 90),
                  ],
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
        ),
      ),
    );
  }
}
