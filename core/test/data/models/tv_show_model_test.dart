import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('should be a subclass of TVShow entity', () async {
    final result = testTVShowModel.toEntity();
    expect(result, testTVShow);
  });
}
