class CeriaCore {
  static CeriaCore _instance;

  static void init(CeriaCore inst) {
    if (_instance != null) {
      throw Exception('CeriaCore instance already initialized');
    }
    _instance = inst;
  }

  static CeriaCore get instance => _instance != null
      ? _instance
      : throw Exception("CeriaCore instance has not been initialized");

  String restApiBaseUrl = 'cerita.lumira.live';
}
