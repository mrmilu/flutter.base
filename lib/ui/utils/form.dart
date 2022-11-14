formValueIsEmpty(Map<String, Object?>? data, String keyValue) {
  if(data == null) return true;
  return ((data[keyValue] as String?)?.isEmpty ?? true);
} // TODO review usage, change it for form consumer