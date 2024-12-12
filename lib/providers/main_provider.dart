import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'main_provider.g.dart';

@riverpod
String currentTitle(Ref ref) {
  return '내가 너를 어떻게 부르면 될까?';
}


