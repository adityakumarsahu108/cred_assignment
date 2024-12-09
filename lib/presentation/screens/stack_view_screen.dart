import 'package:cred_assignment/presentation/widgets/credit_amount_widget.dart';
import 'package:cred_assignment/presentation/widgets/money_transfer_widget.dart';
import 'package:cred_assignment/presentation/widgets/plan_selection_card.dart';
import 'package:flutter/material.dart';

class StackViewScreen extends StatefulWidget {
  const StackViewScreen({super.key});

  @override
  State<StackViewScreen> createState() => _StackViewScreenState();
}

class _StackViewScreenState extends State<StackViewScreen> {
  final ValueNotifier<int> _currentWidgetIndex = ValueNotifier<int>(0);
  final ValueNotifier<bool> _isExpanded = ValueNotifier<bool>(false);

  void _expandWidget(int index) {
    _currentWidgetIndex.value = index;
    _isExpanded.value = true;
  }

  void _collapseWidget() {
    _isExpanded.value = false;
  }

  @override
  void dispose() {
    _currentWidgetIndex.dispose();
    _isExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.cancel_outlined,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.question_mark_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          // Credit Amount Widget
          ValueListenableBuilder<int>(
            valueListenable: _currentWidgetIndex,
            builder: (context, index, _) {
              return ValueListenableBuilder<bool>(
                valueListenable: _isExpanded,
                builder: (context, isExpanded, _) {
                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    top: isExpanded && index == 0 ? 0 : 10,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            _collapseWidget();
                          }
                        },
                        child: CreditAmountWidget(
                          onNext: () {
                            _expandWidget(1);
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          // Plan Selection Card Widget
          ValueListenableBuilder<int>(
            valueListenable: _currentWidgetIndex,
            builder: (context, index, _) {
              return ValueListenableBuilder<bool>(
                valueListenable: _isExpanded,
                builder: (context, isExpanded, _) {
                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    top: index >= 1 ? 180 : MediaQuery.of(context).size.height,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        if (index == 1) {
                          _collapseWidget();
                        }
                      },
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: PlanSelectionCard(
                          onNext: () {
                            _expandWidget(2);
                          },
                          onBack: () {
                            _expandWidget(0);
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          // Money Transfer Widget
          ValueListenableBuilder<int>(
            valueListenable: _currentWidgetIndex,
            builder: (context, index, _) {
              return ValueListenableBuilder<bool>(
                valueListenable: _isExpanded,
                builder: (context, isExpanded, _) {
                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    top: index == 2 ? 280 : MediaQuery.of(context).size.height,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        if (index == 2) {
                          _collapseWidget();
                        }
                      },
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: MoneyTransferWidget(
                          onBack: () {
                            _expandWidget(1);
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
