import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'main_provider.g.dart';

@riverpod
String mainProvider(Ref ref) {
  return 'Hello, World!';
}
