import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medquest/features/setup/presentation/riverpod/setup_providers.dart';

class SetupPage extends ConsumerStatefulWidget {
  const SetupPage({super.key});

  @override
  ConsumerState<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends ConsumerState<SetupPage> {
  final TextEditingController yearController = TextEditingController();
  final TextEditingController moduleController = TextEditingController();

  @override
  void dispose() {
    yearController.dispose();
    moduleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(setupNotifiersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup Page'),
      ),
      body: state.when(
        data: (data) => Center(
          child: Column(
            children: [
              DropdownMenu<String>(
                dropdownMenuEntries: state.asData?.value.years.years
                        .map<DropdownMenuEntry<String>>(
                          (year) => DropdownMenuEntry<String>(
                            value: year.name,
                            label: year.name,
                          ),
                        )
                        .toList() ??
                    [],
                controller: yearController,
                label: const Text('Select Year'),
                onSelected: (value) {
                  ref.read(setupNotifiersProvider.notifier).getModules(value!);
                },
              ),
              SizedBox(height: 20),
              DropdownMenu<String>(
                dropdownMenuEntries: state.asData?.value.modules.modules
                        .map<DropdownMenuEntry<String>>(
                          (module) => DropdownMenuEntry<String>(
                            value: module.toString(),
                            label: module.toString(),
                          ),
                        )
                        .toList() ??
                    [],
                controller: moduleController,
                label: const Text('Select Module'),
                enabled:
                    state.asData?.value.modules.modules.isNotEmpty ?? false,
              )
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, st) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}
