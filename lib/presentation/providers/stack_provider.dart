import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cred_assignment/data/repositories/stack_repositories.dart';
import 'package:cred_assignment/domain/entities/stack_items.dart';
import '../../domain/use_cases/get_stack_items.dart';


final stackItemsProvider = FutureProvider<List<StackItem>>((ref) async {
  final repository = StackRepository();
  final useCase = GetStackItems(repository);
  return useCase();
});


final expandedIndexProvider = StateProvider<int?>((ref) => null);
final isNextScreenActiveProvider1 = StateProvider<bool>((ref) => false);
final isNextScreenActiveProvider2 = StateProvider<bool>((ref) => false);
final creditAmountProvider = StateProvider<int>((ref) => 1000);
final selectedPlanIndexProvider = StateProvider<int>((ref) => 0);
final selectedCreditAmountProvider = StateProvider<String?>((ref) => null);
final selectedPlanDetailsProvider = StateProvider<Map<String, String?>>((ref) {
  return {'emi': null, 'duration': null};
});
