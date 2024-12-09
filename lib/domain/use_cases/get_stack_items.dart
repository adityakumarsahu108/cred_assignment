import 'package:cred_assignment/data/repositories/stack_repositories.dart';
import 'package:cred_assignment/domain/entities/stack_items.dart';

class GetStackItems {
  final StackRepository repository;

  GetStackItems(this.repository);

  Future<List<StackItem>> call() async {
    return await repository.fetchStackItems();
  }
}
