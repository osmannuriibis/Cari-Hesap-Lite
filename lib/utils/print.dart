// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:developer';

/// Prints a string representation of the object to the console.
void bas(Object? value, [Object? thisObject]) {
  if (value != null) {
    String line = value.toString();

    log(
      line,
      zone: Zone.current,
      name: (thisObject == null)
          ? value.runtimeType.toString()
          : thisObject.runtimeType.toString(),
      time: DateTime.now(),
    );
  } else {
    log('null');
  }
}
