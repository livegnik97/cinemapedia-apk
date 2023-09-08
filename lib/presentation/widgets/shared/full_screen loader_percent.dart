import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/movies/initial_loading_provider.dart';

class FullScreenLoaderPercent extends ConsumerWidget {
  const FullScreenLoaderPercent({super.key});

  Stream<String> getLoadingMessages() {
    final messages = <String>[
      "Cargando películas",
      "Comprando palomitas",
      "Cargando populares",
      "Llamando a mi novia",
      "Ya mero...",
      "Esto está tardando :("
    ];
    return Stream.periodic(const Duration(milliseconds: 1200), (step){
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialLoadingPercent = ref.watch(initLoadingPercentProvider);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Espere por favor"),
          const SizedBox(height: 10),
          CircularProgressIndicator(strokeWidth: 2, value: initialLoadingPercent),
          const SizedBox(height: 10),

          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if(!snapshot.hasData)
                return const Text("Cargando...");
              return Text(snapshot.data!);
            },
          ),
        ]
      ),
    );
  }
}