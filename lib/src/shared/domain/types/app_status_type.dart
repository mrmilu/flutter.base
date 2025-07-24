abstract class AppStatusType {
  const AppStatusType();
  factory AppStatusType.open() = AppStatusTypeOpen;
  factory AppStatusType.close() = AppStatusTypeClose;
  factory AppStatusType.maintenance() = AppStatusTypeMaintenance;

  void when({
    required void Function(AppStatusTypeOpen) open,
    required void Function(AppStatusTypeClose) close,
    required void Function(AppStatusTypeMaintenance) maintenance,
  }) {
    if (this is AppStatusTypeOpen) {
      open.call(this as AppStatusTypeOpen);
    }

    if (this is AppStatusTypeClose) {
      close.call(this as AppStatusTypeClose);
    }

    if (this is AppStatusTypeMaintenance) {
      maintenance.call(this as AppStatusTypeMaintenance);
    }

    open.call(this as AppStatusTypeOpen);
  }

  R map<R>({
    required R Function(AppStatusTypeOpen) open,
    required R Function(AppStatusTypeClose) close,
    required R Function(AppStatusTypeMaintenance) maintenance,
  }) {
    if (this is AppStatusTypeOpen) {
      return open.call(this as AppStatusTypeOpen);
    }

    if (this is AppStatusTypeClose) {
      return close.call(this as AppStatusTypeClose);
    }

    if (this is AppStatusTypeMaintenance) {
      return maintenance.call(this as AppStatusTypeMaintenance);
    }

    return open.call(this as AppStatusTypeOpen);
  }

  void maybeWhen({
    void Function(AppStatusTypeOpen)? open,
    void Function(AppStatusTypeClose)? close,
    void Function(AppStatusTypeMaintenance)? maintenance,
    required void Function() orElse,
  }) {
    if (this is AppStatusTypeOpen && open != null) {
      open.call(this as AppStatusTypeOpen);
    }

    if (this is AppStatusTypeClose && close != null) {
      close.call(this as AppStatusTypeClose);
    }

    if (this is AppStatusTypeMaintenance && maintenance != null) {
      maintenance.call(this as AppStatusTypeMaintenance);
    }

    orElse.call();
  }

  R maybeMap<R>({
    R Function(AppStatusTypeOpen)? open,
    R Function(AppStatusTypeClose)? close,
    R Function(AppStatusTypeMaintenance)? maintenance,
    required R Function() orElse,
  }) {
    if (this is AppStatusTypeOpen && open != null) {
      return open.call(this as AppStatusTypeOpen);
    }

    if (this is AppStatusTypeClose && close != null) {
      return close.call(this as AppStatusTypeClose);
    }

    if (this is AppStatusTypeMaintenance && maintenance != null) {
      return maintenance.call(this as AppStatusTypeMaintenance);
    }

    return orElse.call();
  }

  factory AppStatusType.fromString(String value) {
    if (value == 'open') {
      return AppStatusType.open();
    }

    if (value == 'close') {
      return AppStatusType.close();
    }

    if (value == 'maintenance') {
      return AppStatusType.maintenance();
    }

    return AppStatusType.open();
  }

  @override
  String toString() {
    if (this is AppStatusTypeOpen) {
      return 'open';
    }

    if (this is AppStatusTypeClose) {
      return 'close';
    }

    if (this is AppStatusTypeMaintenance) {
      return 'maintenance';
    }

    return 'open';
  }
}

class AppStatusTypeOpen extends AppStatusType {}

class AppStatusTypeClose extends AppStatusType {}

class AppStatusTypeMaintenance extends AppStatusType {}
