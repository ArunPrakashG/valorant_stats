bool isNullOrEmpty(String? value) => value == null || value.isEmpty;

bool isNullOrOfType<T>(dynamic value) => value == null || value is T;
