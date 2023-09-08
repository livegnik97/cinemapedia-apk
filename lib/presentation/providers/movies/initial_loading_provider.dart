

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

final initLoadingProvider = Provider<bool>((ref){
  final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final step2 = ref.watch(popularMoviesProvider).isEmpty;
  final step3 = ref.watch(upcomingMoviesProvider).isEmpty;
  final step4 = ref.watch(topMoviesProvider).isEmpty;
  return step1 || step2 || step3 || step4;
});

final initLoadingPercentProvider = Provider<double>((ref){
  final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty ? 0 : 1;
  final step2 = ref.watch(popularMoviesProvider).isEmpty ? 0 : 1;
  final step3 = ref.watch(upcomingMoviesProvider).isEmpty ? 0 : 1;
  final step4 = ref.watch(topMoviesProvider).isEmpty ? 0 : 1;

  return (step1 + step2 + step3 + step4) / 4;
});