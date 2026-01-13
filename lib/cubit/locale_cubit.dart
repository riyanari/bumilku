import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as dev;

const String kLocaleKey = 'app_locale';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('id')) {
    _loadSavedLocale();
  }

  /// LOAD locale dari SharedPreferences saat cubit dibuat
  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(kLocaleKey);

    if (code != null) {
      dev.log('[LANG] Loaded saved locale: $code', name: 'LocaleCubit');
      emit(Locale(code));
    } else {
      dev.log('[LANG] No saved locale, default id', name: 'LocaleCubit');
    }
  }

  /// SAVE helper
  Future<void> _saveLocale(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(kLocaleKey, code);
    dev.log('[LANG] Saved locale: $code', name: 'LocaleCubit');
  }

  void setIndonesian() async {
    dev.log('[LANG] setIndonesian() called. Before: $state', name: 'LocaleCubit');
    await _saveLocale('id');
    emit(const Locale('id'));
    dev.log('[LANG] emitted id. After: $state', name: 'LocaleCubit');
  }

  void setEnglish() async {
    dev.log('[LANG] setEnglish() called. Before: $state', name: 'LocaleCubit');
    await _saveLocale('en');
    emit(const Locale('en'));
    dev.log('[LANG] emitted en. After: $state', name: 'LocaleCubit');
  }
}
