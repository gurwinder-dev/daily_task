import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/draft_model.dart';

class AutoSaveService {
  final String draftId;
  Timer? _debounce;

  AutoSaveService(this.draftId);

  void autoSave({
    required String title,
    required String description,
    required Function onSaved,
    Duration debounceDuration = const Duration(seconds: 2),
  }) {
    _debounce?.cancel();
    _debounce = Timer(debounceDuration, () async {
      final prefs = await SharedPreferences.getInstance();
      final draft = DraftModel(
        id: draftId,
        title: title,
        description: description,
        lastEdited: DateTime.now(),
      );
      prefs.setString('draft_$draftId', jsonEncode(draft.toJson()));
      onSaved();
    });
  }

  void dispose() {
    _debounce?.cancel();
  }

  static Future<List<DraftModel>> getAllDrafts() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getKeys().where((key) => key.startsWith('draft_'))
        .map((key) => DraftModel.fromJson(jsonDecode(prefs.getString(key)!))).toList();
  }

  static Future<void> deleteDraft(String id) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('draft_$id');
  }

  static Future<DraftModel?> getDraftById(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('draft_$id');
    if (json == null) return null;
    return DraftModel.fromJson(jsonDecode(json));
  }
}
