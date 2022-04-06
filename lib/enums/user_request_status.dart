enum UserRequestStatus {
  accepted,
  waiting,
  denied,
}

extension UserRequestStatusValues on UserRequestStatus {
  static const map = {
    UserRequestStatus.waiting: 0,
    UserRequestStatus.accepted: 1,
    UserRequestStatus.denied: -1
  };

  int? get statusValueInt => map[this];
}

UserRequestStatus? getUserRequestStatusByValue(int value) {
  for (var item in UserRequestStatusValues.map.entries) {
    if (item.value == value) return item.key;
  }
  return null;
}
