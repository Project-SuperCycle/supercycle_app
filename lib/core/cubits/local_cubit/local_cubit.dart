import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:supercycle_app/core/services/lang_cache.dart' show LangCache;

part 'local_state.dart';

class LocalCubit extends Cubit<LocalState> {
  LocalCubit() : super(LocalInitial());

  Future<void> getSavedLang() async {
    final String cachedLang = await LangCache().getCachedLang();
    emit(ChangeLocalState(locale: Locale(cachedLang)));
  }

  Future<void> changeLang(String lang) async {
    await LangCache().cacheLang(lang);
    emit(ChangeLocalState(locale: Locale(lang)));
  }
}
