/*
  This file is part of KDDockWidgets.

  SPDX-FileCopyrightText: 2019-2022 Klarälvdalens Datakonsult AB, a KDAB Group company <info@kdab.com>
  Author: Sérgio Martins <sergio.martins@kdab.com>

  SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only

  Contact KDAB at <info@kdab.com> for commercial licensing options.
*/

//tag=1052
import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';
import 'TypeHelpers.dart';
import '../Bindings.dart';
import '../FinalizerHelpers.dart';

//tag=1051
var _dylib = Library.instance().dylib;
final _finalizer =
    _dylib.lookup<ffi.NativeFunction<Dart_WeakPersistentHandleFinalizer_Type>>(
        'c_KDDockWidgets__Platform_Finalizer');

//tag=1038
class Platform_DisplayType {
  static const Other = 0;
  static const X11 = 1;
  static const Wayland = 2;
  static const QtOffscreen = 3;
  static const QtEGLFS = 4;
  static const Windows = 5;
}

class Platform {
//tag=1060
  static var s_dartInstanceByCppPtr = Map<int, Platform>();
  var _thisCpp = null;
  bool _needsAutoDelete = false;
  get thisCpp => _thisCpp;
  set thisCpp(var ptr) {
    _thisCpp = ptr;
    ffi.Pointer<ffi.Void> ptrvoid = ptr.cast<ffi.Void>();
    if (_needsAutoDelete)
      newWeakPersistentHandle?.call(this, ptrvoid, 0, _finalizer);
  }

  static bool isCached(var cppPointer) {
//tag=1024
    return s_dartInstanceByCppPtr.containsKey(cppPointer.address);
  }

//tag=1061
  factory Platform.fromCache(var cppPointer, [needsAutoDelete = false]) {
    return (s_dartInstanceByCppPtr[cppPointer.address] ??
        Platform.fromCppPointer(cppPointer, needsAutoDelete)) as Platform;
  }
  Platform.fromCppPointer(var cppPointer, [this._needsAutoDelete = false]) {
//tag=1024
    thisCpp = cppPointer;
  }
//tag=1025
  Platform.init() {}
//tag=1024

//tag=1025
  int get m_numWarningsEmitted {
//tag=1028
    final int_Func_voidstar func = _dylib
        .lookup<ffi.NativeFunction<int_Func_voidstar_FFI>>(
            'c_KDDockWidgets__Platform___get_m_numWarningsEmitted')
        .asFunction();
//tag=1031
    return func(thisCpp);
  }
//tag=1024

//tag=1026
  set m_numWarningsEmitted(int m_numWarningsEmitted_) {
//tag=1028
    final void_Func_voidstar_int func = _dylib
        .lookup<ffi.NativeFunction<void_Func_voidstar_ffi_Int32_FFI>>(
            'c_KDDockWidgets__Platform___set_m_numWarningsEmitted_int')
        .asFunction();
//tag=1030
    func(thisCpp, m_numWarningsEmitted_);
  }

//tag=1023
//Platform()
  Platform() {
//tag=1075
    final voidstar_Func_void func = _dylib
        .lookup<ffi.NativeFunction<voidstar_Func_void_FFI>>(
            'c_KDDockWidgets__Platform__constructor')
        .asFunction();
    thisCpp = func();
    Platform.s_dartInstanceByCppPtr[thisCpp.address] = this;
    registerCallbacks();
  }
//tag=1024

//tag=1027
// applicationName() const
  QString applicationName() {
//tag=1028
    final voidstar_Func_voidstar func = _dylib
        .lookup<ffi.NativeFunction<voidstar_Func_voidstar_FFI>>(
            cFunctionSymbolName(626))
        .asFunction();
//tag=1033
    ffi.Pointer<void> result = func(thisCpp);
    return QString.fromCppPointer(result, true);
  }

//tag=1035
  static ffi.Pointer<void> applicationName_calledFromC(
      ffi.Pointer<void> thisCpp) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::applicationName() const! (${thisCpp.address})");
      throw Error();
    }
//tag=1037
    final result = dartInstance.applicationName();
    return result.thisCpp;
  }
//tag=1024

//tag=1027
// createDefaultViewFactory()
  ViewFactory createDefaultViewFactory() {
//tag=1028
    final voidstar_Func_voidstar func = _dylib
        .lookup<ffi.NativeFunction<voidstar_Func_voidstar_FFI>>(
            cFunctionSymbolName(627))
        .asFunction();
//tag=1033
    ffi.Pointer<void> result = func(thisCpp);
    return ViewFactory.fromCppPointer(result, false);
  }

//tag=1035
  static ffi.Pointer<void> createDefaultViewFactory_calledFromC(
      ffi.Pointer<void> thisCpp) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::createDefaultViewFactory()! (${thisCpp.address})");
      throw Error();
    }
//tag=1037
    final result = dartInstance.createDefaultViewFactory();
    return result.thisCpp;
  }
//tag=1024

//tag=1027
// createView(KDDockWidgets::Controller * arg__1, KDDockWidgets::View * parent) const
  View createView(Controller? arg__1, {required View? parent}) {
//tag=1028
    final voidstar_Func_voidstar_voidstar_voidstar func = _dylib
        .lookup<
                ffi.NativeFunction<
                    voidstar_Func_voidstar_voidstar_voidstar_FFI>>(
            cFunctionSymbolName(628))
        .asFunction();
//tag=1033
    ffi.Pointer<void> result = func(
        thisCpp,
        arg__1 == null ? ffi.nullptr : arg__1.thisCpp,
        parent == null ? ffi.nullptr : parent.thisCpp);
    return View.fromCppPointer(result, false);
  }

//tag=1035
  static ffi.Pointer<void> createView_calledFromC(ffi.Pointer<void> thisCpp,
      ffi.Pointer<void>? arg__1, ffi.Pointer<void>? parent) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::createView(KDDockWidgets::Controller * arg__1, KDDockWidgets::View * parent) const! (${thisCpp.address})");
      throw Error();
    }
//tag=1037
    final result = dartInstance.createView(Controller.fromCppPointer(arg__1),
        parent: View.fromCppPointer(parent));
    return result.thisCpp;
  }
//tag=1024

//tag=1027
// displayType() const
  int displayType() {
//tag=1028
    final int_Func_voidstar func = _dylib
        .lookup<ffi.NativeFunction<int_Func_voidstar_FFI>>(
            cFunctionSymbolName(629))
        .asFunction();
//tag=1031
    return func(thisCpp);
  }

//tag=1035
  static int displayType_calledFromC(ffi.Pointer<void> thisCpp) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::displayType() const! (${thisCpp.address})");
      throw Error();
    }
//tag=1037
    final result = dartInstance.displayType();
    return result;
  }
//tag=1024

//tag=1027
// hasActivePopup() const
  bool hasActivePopup() {
//tag=1028
    final bool_Func_voidstar func = _dylib
        .lookup<ffi.NativeFunction<bool_Func_voidstar_FFI>>(
            cFunctionSymbolName(630))
        .asFunction();
//tag=1029
    return func(thisCpp) != 0;
  }

//tag=1035
  static int hasActivePopup_calledFromC(ffi.Pointer<void> thisCpp) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::hasActivePopup() const! (${thisCpp.address})");
      throw Error();
    }
//tag=1037
    final result = dartInstance.hasActivePopup();
    return result ? 1 : 0;
  }
//tag=1024

//tag=1027
// inDisallowedDragView(QPoint globalPos) const
  bool inDisallowedDragView(QPoint globalPos) {
//tag=1028
    final bool_Func_voidstar_voidstar func = _dylib
        .lookup<ffi.NativeFunction<bool_Func_voidstar_voidstar_FFI>>(
            cFunctionSymbolName(631))
        .asFunction();
//tag=1029
    return func(thisCpp, globalPos == null ? ffi.nullptr : globalPos.thisCpp) !=
        0;
  }

//tag=1035
  static int inDisallowedDragView_calledFromC(
      ffi.Pointer<void> thisCpp, ffi.Pointer<void> globalPos) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::inDisallowedDragView(QPoint globalPos) const! (${thisCpp.address})");
      throw Error();
    }
//tag=1037
    final result =
        dartInstance.inDisallowedDragView(QPoint.fromCppPointer(globalPos));
    return result ? 1 : 0;
  }
//tag=1024

//tag=1027
// installMessageHandler()
  installMessageHandler() {
//tag=1028
    final void_Func_voidstar func = _dylib
        .lookup<ffi.NativeFunction<void_Func_voidstar_FFI>>(
            cFunctionSymbolName(632))
        .asFunction();
//tag=1030
    func(thisCpp);
  }

//tag=1035
  static void installMessageHandler_calledFromC(ffi.Pointer<void> thisCpp) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::installMessageHandler()! (${thisCpp.address})");
      throw Error();
    }
//tag=1036
    dartInstance.installMessageHandler();
  }

//tag=1024
  static
//tag=1027
// instance()
      Platform instance() {
//tag=1028
    final voidstar_Func_void func = _dylib
        .lookup<ffi.NativeFunction<voidstar_Func_void_FFI>>(
            'c_static_KDDockWidgets__Platform__instance')
        .asFunction();
//tag=1033
    ffi.Pointer<void> result = func();
    return Platform.fromCppPointer(result, false);
  }
//tag=1024

//tag=1027
// isLeftMouseButtonPressed() const
  bool isLeftMouseButtonPressed() {
//tag=1028
    final bool_Func_voidstar func = _dylib
        .lookup<ffi.NativeFunction<bool_Func_voidstar_FFI>>(
            cFunctionSymbolName(634))
        .asFunction();
//tag=1029
    return func(thisCpp) != 0;
  }

//tag=1035
  static int isLeftMouseButtonPressed_calledFromC(ffi.Pointer<void> thisCpp) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::isLeftMouseButtonPressed() const! (${thisCpp.address})");
      throw Error();
    }
//tag=1037
    final result = dartInstance.isLeftMouseButtonPressed();
    return result ? 1 : 0;
  }
//tag=1024

//tag=1027
// isProcessingAppQuitEvent() const
  bool isProcessingAppQuitEvent() {
//tag=1028
    final bool_Func_voidstar func = _dylib
        .lookup<ffi.NativeFunction<bool_Func_voidstar_FFI>>(
            cFunctionSymbolName(635))
        .asFunction();
//tag=1029
    return func(thisCpp) != 0;
  }

//tag=1035
  static int isProcessingAppQuitEvent_calledFromC(ffi.Pointer<void> thisCpp) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::isProcessingAppQuitEvent() const! (${thisCpp.address})");
      throw Error();
    }
//tag=1037
    final result = dartInstance.isProcessingAppQuitEvent();
    return result ? 1 : 0;
  }
//tag=1024

//tag=1027
// isQtQuick() const
  bool isQtQuick() {
//tag=1028
    final bool_Func_voidstar func = _dylib
        .lookup<ffi.NativeFunction<bool_Func_voidstar_FFI>>(
            'c_KDDockWidgets__Platform__isQtQuick')
        .asFunction();
//tag=1029
    return func(thisCpp) != 0;
  }
//tag=1024

//tag=1027
// isQtWidgets() const
  bool isQtWidgets() {
//tag=1028
    final bool_Func_voidstar func = _dylib
        .lookup<ffi.NativeFunction<bool_Func_voidstar_FFI>>(
            'c_KDDockWidgets__Platform__isQtWidgets')
        .asFunction();
//tag=1029
    return func(thisCpp) != 0;
  }
//tag=1024

//tag=1027
// name() const
  String name() {
//tag=1028
    final string_Func_voidstar func = _dylib
        .lookup<ffi.NativeFunction<string_Func_voidstar_FFI>>(
            cFunctionSymbolName(638))
        .asFunction();
//tag=1032
    ffi.Pointer<Utf8> result = func(thisCpp);
    return result.toDartString();
  }

//tag=1035
  static ffi.Pointer<Utf8> name_calledFromC(ffi.Pointer<void> thisCpp) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::name() const! (${thisCpp.address})");
      throw Error();
    }
//tag=1037
    final result = dartInstance.name();
    return result.toNativeUtf8();
  }
//tag=1024

//tag=1027
// organizationName() const
  QString organizationName() {
//tag=1028
    final voidstar_Func_voidstar func = _dylib
        .lookup<ffi.NativeFunction<voidstar_Func_voidstar_FFI>>(
            cFunctionSymbolName(639))
        .asFunction();
//tag=1033
    ffi.Pointer<void> result = func(thisCpp);
    return QString.fromCppPointer(result, true);
  }

//tag=1035
  static ffi.Pointer<void> organizationName_calledFromC(
      ffi.Pointer<void> thisCpp) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::organizationName() const! (${thisCpp.address})");
      throw Error();
    }
//tag=1037
    final result = dartInstance.organizationName();
    return result.thisCpp;
  }
//tag=1024

//tag=1027
// restoreMouseCursor()
  restoreMouseCursor() {
//tag=1028
    final void_Func_voidstar func = _dylib
        .lookup<ffi.NativeFunction<void_Func_voidstar_FFI>>(
            cFunctionSymbolName(640))
        .asFunction();
//tag=1030
    func(thisCpp);
  }

//tag=1035
  static void restoreMouseCursor_calledFromC(ffi.Pointer<void> thisCpp) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::restoreMouseCursor()! (${thisCpp.address})");
      throw Error();
    }
//tag=1036
    dartInstance.restoreMouseCursor();
  }
//tag=1024

//tag=1027
// screenNumberFor(KDDockWidgets::View * arg__1) const
  int screenNumberFor(View? arg__1) {
//tag=1028
    final int_Func_voidstar_voidstar func = _dylib
        .lookup<ffi.NativeFunction<int_Func_voidstar_voidstar_FFI>>(
            cFunctionSymbolName(641))
        .asFunction();
//tag=1031
    return func(thisCpp, arg__1 == null ? ffi.nullptr : arg__1.thisCpp);
  }

//tag=1035
  static int screenNumberFor_calledFromC(
      ffi.Pointer<void> thisCpp, ffi.Pointer<void>? arg__1) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::screenNumberFor(KDDockWidgets::View * arg__1) const! (${thisCpp.address})");
      throw Error();
    }
//tag=1037
    final result = dartInstance.screenNumberFor(View.fromCppPointer(arg__1));
    return result;
  }
//tag=1024

//tag=1027
// screenSizeFor(KDDockWidgets::View * arg__1) const
  QSize screenSizeFor(View? arg__1) {
//tag=1028
    final voidstar_Func_voidstar_voidstar func = _dylib
        .lookup<ffi.NativeFunction<voidstar_Func_voidstar_voidstar_FFI>>(
            cFunctionSymbolName(642))
        .asFunction();
//tag=1033
    ffi.Pointer<void> result =
        func(thisCpp, arg__1 == null ? ffi.nullptr : arg__1.thisCpp);
    return QSize.fromCppPointer(result, true);
  }

//tag=1035
  static ffi.Pointer<void> screenSizeFor_calledFromC(
      ffi.Pointer<void> thisCpp, ffi.Pointer<void>? arg__1) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::screenSizeFor(KDDockWidgets::View * arg__1) const! (${thisCpp.address})");
      throw Error();
    }
//tag=1037
    final result = dartInstance.screenSizeFor(View.fromCppPointer(arg__1));
    return result.thisCpp;
  }
//tag=1024

//tag=1027
// sendEvent(KDDockWidgets::View * arg__1, QEvent * arg__2) const
  sendEvent(View? arg__1, QEvent? arg__2) {
//tag=1028
    final void_Func_voidstar_voidstar_voidstar func = _dylib
        .lookup<ffi.NativeFunction<void_Func_voidstar_voidstar_voidstar_FFI>>(
            cFunctionSymbolName(643))
        .asFunction();
//tag=1030
    func(thisCpp, arg__1 == null ? ffi.nullptr : arg__1.thisCpp,
        arg__2 == null ? ffi.nullptr : arg__2.thisCpp);
  }

//tag=1035
  static void sendEvent_calledFromC(ffi.Pointer<void> thisCpp,
      ffi.Pointer<void>? arg__1, ffi.Pointer<void>? arg__2) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::sendEvent(KDDockWidgets::View * arg__1, QEvent * arg__2) const! (${thisCpp.address})");
      throw Error();
    }
//tag=1036
    dartInstance.sendEvent(
        View.fromCppPointer(arg__1), QEvent.fromCppPointer(arg__2));
  }
//tag=1024

//tag=1027
// setMouseCursor(Qt::CursorShape arg__1)
  setMouseCursor(int arg__1) {
//tag=1028
    final void_Func_voidstar_int func = _dylib
        .lookup<ffi.NativeFunction<void_Func_voidstar_ffi_Int32_FFI>>(
            cFunctionSymbolName(644))
        .asFunction();
//tag=1030
    func(thisCpp, arg__1);
  }

//tag=1035
  static void setMouseCursor_calledFromC(
      ffi.Pointer<void> thisCpp, int arg__1) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::setMouseCursor(Qt::CursorShape arg__1)! (${thisCpp.address})");
      throw Error();
    }
//tag=1036
    dartInstance.setMouseCursor(arg__1);
  }
//tag=1024

//tag=1027
// startDragDistance() const
  int startDragDistance() {
//tag=1028
    final int_Func_voidstar func = _dylib
        .lookup<ffi.NativeFunction<int_Func_voidstar_FFI>>(
            'c_KDDockWidgets__Platform__startDragDistance')
        .asFunction();
//tag=1031
    return func(thisCpp);
  }
//tag=1024

//tag=1027
// startDragDistance_impl() const
  int startDragDistance_impl() {
//tag=1028
    final int_Func_voidstar func = _dylib
        .lookup<ffi.NativeFunction<int_Func_voidstar_FFI>>(
            cFunctionSymbolName(646))
        .asFunction();
//tag=1031
    return func(thisCpp);
  }

//tag=1035
  static int startDragDistance_impl_calledFromC(ffi.Pointer<void> thisCpp) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::startDragDistance_impl() const! (${thisCpp.address})");
      throw Error();
    }
//tag=1037
    final result = dartInstance.startDragDistance_impl();
    return result;
  }
//tag=1024

//tag=1027
// tests_createNonClosableView(KDDockWidgets::View * parent)
  View tests_createNonClosableView({required View? parent}) {
//tag=1028
    final voidstar_Func_voidstar_voidstar func = _dylib
        .lookup<ffi.NativeFunction<voidstar_Func_voidstar_voidstar_FFI>>(
            cFunctionSymbolName(647))
        .asFunction();
//tag=1033
    ffi.Pointer<void> result =
        func(thisCpp, parent == null ? ffi.nullptr : parent.thisCpp);
    return View.fromCppPointer(result, false);
  }

//tag=1035
  static ffi.Pointer<void> tests_createNonClosableView_calledFromC(
      ffi.Pointer<void> thisCpp, ffi.Pointer<void>? parent) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::tests_createNonClosableView(KDDockWidgets::View * parent)! (${thisCpp.address})");
      throw Error();
    }
//tag=1037
    final result = dartInstance.tests_createNonClosableView(
        parent: View.fromCppPointer(parent));
    return result.thisCpp;
  }

//tag=1024
  static
//tag=1027
// tests_deinitPlatform()
      tests_deinitPlatform() {
//tag=1028
    final void_Func_void func = _dylib
        .lookup<ffi.NativeFunction<void_Func_void_FFI>>(
            'c_static_KDDockWidgets__Platform__tests_deinitPlatform')
        .asFunction();
//tag=1030
    func();
  }
//tag=1024

//tag=1027
// tests_deinitPlatform_impl()
  tests_deinitPlatform_impl() {
//tag=1028
    final void_Func_voidstar func = _dylib
        .lookup<ffi.NativeFunction<void_Func_voidstar_FFI>>(
            cFunctionSymbolName(649))
        .asFunction();
//tag=1030
    func(thisCpp);
  }

//tag=1035
  static void tests_deinitPlatform_impl_calledFromC(ffi.Pointer<void> thisCpp) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::tests_deinitPlatform_impl()! (${thisCpp.address})");
      throw Error();
    }
//tag=1036
    dartInstance.tests_deinitPlatform_impl();
  }
//tag=1024

//tag=1027
// tests_initPlatform_impl()
  tests_initPlatform_impl() {
//tag=1028
    final void_Func_voidstar func = _dylib
        .lookup<ffi.NativeFunction<void_Func_voidstar_FFI>>(
            cFunctionSymbolName(650))
        .asFunction();
//tag=1030
    func(thisCpp);
  }

//tag=1035
  static void tests_initPlatform_impl_calledFromC(ffi.Pointer<void> thisCpp) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::tests_initPlatform_impl()! (${thisCpp.address})");
      throw Error();
    }
//tag=1036
    dartInstance.tests_initPlatform_impl();
  }
//tag=1024

//tag=1027
// tests_wait(int ms)
  tests_wait(int ms) {
//tag=1028
    final void_Func_voidstar_int func = _dylib
        .lookup<ffi.NativeFunction<void_Func_voidstar_ffi_Int32_FFI>>(
            cFunctionSymbolName(651))
        .asFunction();
//tag=1030
    func(thisCpp, ms);
  }

//tag=1035
  static void tests_wait_calledFromC(ffi.Pointer<void> thisCpp, int ms) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::tests_wait(int ms)! (${thisCpp.address})");
      throw Error();
    }
//tag=1036
    dartInstance.tests_wait(ms);
  }
//tag=1024

//tag=1027
// tests_waitForDeleted(KDDockWidgets::View * arg__1, int timeout) const
  bool tests_waitForDeleted(View? arg__1, {int timeout = 2000}) {
//tag=1028
    final bool_Func_voidstar_voidstar_int func = _dylib
        .lookup<ffi.NativeFunction<bool_Func_voidstar_voidstar_ffi_Int32_FFI>>(
            cFunctionSymbolName(652))
        .asFunction();
//tag=1029
    return func(
            thisCpp, arg__1 == null ? ffi.nullptr : arg__1.thisCpp, timeout) !=
        0;
  }

//tag=1035
  static int tests_waitForDeleted_calledFromC(
      ffi.Pointer<void> thisCpp, ffi.Pointer<void>? arg__1, int timeout) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::tests_waitForDeleted(KDDockWidgets::View * arg__1, int timeout) const! (${thisCpp.address})");
      throw Error();
    }
//tag=1037
    final result = dartInstance
        .tests_waitForDeleted(View.fromCppPointer(arg__1), timeout: timeout);
    return result ? 1 : 0;
  }
//tag=1024

//tag=1027
// tests_waitForDeleted(QObject * arg__1, int timeout) const
  bool tests_waitForDeleted_2(QObject? arg__1, {int timeout = 2000}) {
//tag=1028
    final bool_Func_voidstar_voidstar_int func = _dylib
        .lookup<ffi.NativeFunction<bool_Func_voidstar_voidstar_ffi_Int32_FFI>>(
            cFunctionSymbolName(653))
        .asFunction();
//tag=1029
    return func(
            thisCpp, arg__1 == null ? ffi.nullptr : arg__1.thisCpp, timeout) !=
        0;
  }

//tag=1035
  static int tests_waitForDeleted_2_calledFromC(
      ffi.Pointer<void> thisCpp, ffi.Pointer<void>? arg__1, int timeout) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::tests_waitForDeleted(QObject * arg__1, int timeout) const! (${thisCpp.address})");
      throw Error();
    }
//tag=1037
    final result = dartInstance.tests_waitForDeleted_2(
        QObject.fromCppPointer(arg__1),
        timeout: timeout);
    return result ? 1 : 0;
  }
//tag=1024

//tag=1027
// tests_waitForEvent(KDDockWidgets::View * arg__1, QEvent::Type type, int timeout) const
  bool tests_waitForEvent(View? arg__1, int type, {int timeout = 5000}) {
//tag=1028
    final bool_Func_voidstar_voidstar_int_int func = _dylib
        .lookup<
                ffi.NativeFunction<
                    bool_Func_voidstar_voidstar_ffi_Int32_ffi_Int32_FFI>>(
            cFunctionSymbolName(654))
        .asFunction();
//tag=1029
    return func(thisCpp, arg__1 == null ? ffi.nullptr : arg__1.thisCpp, type,
            timeout) !=
        0;
  }

//tag=1035
  static int tests_waitForEvent_calledFromC(ffi.Pointer<void> thisCpp,
      ffi.Pointer<void>? arg__1, int type, int timeout) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::tests_waitForEvent(KDDockWidgets::View * arg__1, QEvent::Type type, int timeout) const! (${thisCpp.address})");
      throw Error();
    }
//tag=1037
    final result = dartInstance.tests_waitForEvent(
        View.fromCppPointer(arg__1), type,
        timeout: timeout);
    return result ? 1 : 0;
  }
//tag=1024

//tag=1027
// tests_waitForEvent(QObject * w, QEvent::Type type, int timeout) const
  bool tests_waitForEvent_2(QObject? w, int type, {int timeout = 5000}) {
//tag=1028
    final bool_Func_voidstar_voidstar_int_int func = _dylib
        .lookup<
                ffi.NativeFunction<
                    bool_Func_voidstar_voidstar_ffi_Int32_ffi_Int32_FFI>>(
            cFunctionSymbolName(655))
        .asFunction();
//tag=1029
    return func(thisCpp, w == null ? ffi.nullptr : w.thisCpp, type, timeout) !=
        0;
  }

//tag=1035
  static int tests_waitForEvent_2_calledFromC(
      ffi.Pointer<void> thisCpp, ffi.Pointer<void>? w, int type, int timeout) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::tests_waitForEvent(QObject * w, QEvent::Type type, int timeout) const! (${thisCpp.address})");
      throw Error();
    }
//tag=1037
    final result = dartInstance.tests_waitForEvent_2(
        QObject.fromCppPointer(w), type,
        timeout: timeout);
    return result ? 1 : 0;
  }
//tag=1024

//tag=1027
// tests_waitForResize(KDDockWidgets::Controller * arg__1, int timeout) const
  bool tests_waitForResize(Controller? arg__1, {int timeout = 2000}) {
//tag=1028
    final bool_Func_voidstar_voidstar_int func = _dylib
        .lookup<ffi.NativeFunction<bool_Func_voidstar_voidstar_ffi_Int32_FFI>>(
            cFunctionSymbolName(656))
        .asFunction();
//tag=1029
    return func(
            thisCpp, arg__1 == null ? ffi.nullptr : arg__1.thisCpp, timeout) !=
        0;
  }

//tag=1035
  static int tests_waitForResize_calledFromC(
      ffi.Pointer<void> thisCpp, ffi.Pointer<void>? arg__1, int timeout) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::tests_waitForResize(KDDockWidgets::Controller * arg__1, int timeout) const! (${thisCpp.address})");
      throw Error();
    }
//tag=1037
    final result = dartInstance.tests_waitForResize(
        Controller.fromCppPointer(arg__1),
        timeout: timeout);
    return result ? 1 : 0;
  }
//tag=1024

//tag=1027
// tests_waitForResize(KDDockWidgets::View * arg__1, int timeout) const
  bool tests_waitForResize_2(View? arg__1, {int timeout = 2000}) {
//tag=1028
    final bool_Func_voidstar_voidstar_int func = _dylib
        .lookup<ffi.NativeFunction<bool_Func_voidstar_voidstar_ffi_Int32_FFI>>(
            cFunctionSymbolName(657))
        .asFunction();
//tag=1029
    return func(
            thisCpp, arg__1 == null ? ffi.nullptr : arg__1.thisCpp, timeout) !=
        0;
  }

//tag=1035
  static int tests_waitForResize_2_calledFromC(
      ffi.Pointer<void> thisCpp, ffi.Pointer<void>? arg__1, int timeout) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::tests_waitForResize(KDDockWidgets::View * arg__1, int timeout) const! (${thisCpp.address})");
      throw Error();
    }
//tag=1037
    final result = dartInstance
        .tests_waitForResize_2(View.fromCppPointer(arg__1), timeout: timeout);
    return result ? 1 : 0;
  }
//tag=1024

//tag=1027
// ungrabMouse()
  ungrabMouse() {
//tag=1028
    final void_Func_voidstar func = _dylib
        .lookup<ffi.NativeFunction<void_Func_voidstar_FFI>>(
            cFunctionSymbolName(658))
        .asFunction();
//tag=1030
    func(thisCpp);
  }

//tag=1035
  static void ungrabMouse_calledFromC(ffi.Pointer<void> thisCpp) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::ungrabMouse()! (${thisCpp.address})");
      throw Error();
    }
//tag=1036
    dartInstance.ungrabMouse();
  }
//tag=1024

//tag=1027
// uninstallMessageHandler()
  uninstallMessageHandler() {
//tag=1028
    final void_Func_voidstar func = _dylib
        .lookup<ffi.NativeFunction<void_Func_voidstar_FFI>>(
            cFunctionSymbolName(659))
        .asFunction();
//tag=1030
    func(thisCpp);
  }

//tag=1035
  static void uninstallMessageHandler_calledFromC(ffi.Pointer<void> thisCpp) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::uninstallMessageHandler()! (${thisCpp.address})");
      throw Error();
    }
//tag=1036
    dartInstance.uninstallMessageHandler();
  }
//tag=1024

//tag=1027
// usesFallbackMouseGrabber() const
  bool usesFallbackMouseGrabber() {
//tag=1028
    final bool_Func_voidstar func = _dylib
        .lookup<ffi.NativeFunction<bool_Func_voidstar_FFI>>(
            cFunctionSymbolName(660))
        .asFunction();
//tag=1029
    return func(thisCpp) != 0;
  }

//tag=1035
  static int usesFallbackMouseGrabber_calledFromC(ffi.Pointer<void> thisCpp) {
    var dartInstance = Platform.s_dartInstanceByCppPtr[thisCpp.address];
    if (dartInstance == null) {
      print(
          "Dart instance not found for Platform::usesFallbackMouseGrabber() const! (${thisCpp.address})");
      throw Error();
    }
//tag=1037
    final result = dartInstance.usesFallbackMouseGrabber();
    return result ? 1 : 0;
  }

//tag=1022
  void release() {
    final void_Func_voidstar func = _dylib
        .lookup<ffi.NativeFunction<void_Func_voidstar_FFI>>(
            'c_KDDockWidgets__Platform__destructor')
        .asFunction();
    func(thisCpp);
  }

//tag=1019
  String cFunctionSymbolName(int methodId) {
    switch (methodId) {
      case 626:
        return "c_KDDockWidgets__Platform__applicationName";
      case 627:
        return "c_KDDockWidgets__Platform__createDefaultViewFactory";
      case 628:
        return "c_KDDockWidgets__Platform__createView_Controller_View";
      case 629:
        return "c_KDDockWidgets__Platform__displayType";
      case 630:
        return "c_KDDockWidgets__Platform__hasActivePopup";
      case 631:
        return "c_KDDockWidgets__Platform__inDisallowedDragView_QPoint";
      case 632:
        return "c_KDDockWidgets__Platform__installMessageHandler";
      case 634:
        return "c_KDDockWidgets__Platform__isLeftMouseButtonPressed";
      case 635:
        return "c_KDDockWidgets__Platform__isProcessingAppQuitEvent";
      case 638:
        return "c_KDDockWidgets__Platform__name";
      case 639:
        return "c_KDDockWidgets__Platform__organizationName";
      case 640:
        return "c_KDDockWidgets__Platform__restoreMouseCursor";
      case 641:
        return "c_KDDockWidgets__Platform__screenNumberFor_View";
      case 642:
        return "c_KDDockWidgets__Platform__screenSizeFor_View";
      case 643:
        return "c_KDDockWidgets__Platform__sendEvent_View_QEvent";
      case 644:
        return "c_KDDockWidgets__Platform__setMouseCursor_CursorShape";
      case 646:
        return "c_KDDockWidgets__Platform__startDragDistance_impl";
      case 647:
        return "c_KDDockWidgets__Platform__tests_createNonClosableView_View";
      case 649:
        return "c_KDDockWidgets__Platform__tests_deinitPlatform_impl";
      case 650:
        return "c_KDDockWidgets__Platform__tests_initPlatform_impl";
      case 651:
        return "c_KDDockWidgets__Platform__tests_wait_int";
      case 652:
        return "c_KDDockWidgets__Platform__tests_waitForDeleted_View_int";
      case 653:
        return "c_KDDockWidgets__Platform__tests_waitForDeleted_QObject_int";
      case 654:
        return "c_KDDockWidgets__Platform__tests_waitForEvent_View_Type_int";
      case 655:
        return "c_KDDockWidgets__Platform__tests_waitForEvent_QObject_Type_int";
      case 656:
        return "c_KDDockWidgets__Platform__tests_waitForResize_Controller_int";
      case 657:
        return "c_KDDockWidgets__Platform__tests_waitForResize_View_int";
      case 658:
        return "c_KDDockWidgets__Platform__ungrabMouse";
      case 659:
        return "c_KDDockWidgets__Platform__uninstallMessageHandler";
      case 660:
        return "c_KDDockWidgets__Platform__usesFallbackMouseGrabber";
    }
    return "";
  }

  static String methodNameFromId(int methodId) {
    switch (methodId) {
      case 626:
        return "applicationName";
      case 627:
        return "createDefaultViewFactory";
      case 628:
        return "createView";
      case 629:
        return "displayType";
      case 630:
        return "hasActivePopup";
      case 631:
        return "inDisallowedDragView";
      case 632:
        return "installMessageHandler";
      case 634:
        return "isLeftMouseButtonPressed";
      case 635:
        return "isProcessingAppQuitEvent";
      case 638:
        return "name";
      case 639:
        return "organizationName";
      case 640:
        return "restoreMouseCursor";
      case 641:
        return "screenNumberFor";
      case 642:
        return "screenSizeFor";
      case 643:
        return "sendEvent";
      case 644:
        return "setMouseCursor";
      case 646:
        return "startDragDistance_impl";
      case 647:
        return "tests_createNonClosableView";
      case 649:
        return "tests_deinitPlatform_impl";
      case 650:
        return "tests_initPlatform_impl";
      case 651:
        return "tests_wait";
      case 652:
        return "tests_waitForDeleted";
      case 653:
        return "tests_waitForDeleted_2";
      case 654:
        return "tests_waitForEvent";
      case 655:
        return "tests_waitForEvent_2";
      case 656:
        return "tests_waitForResize";
      case 657:
        return "tests_waitForResize_2";
      case 658:
        return "ungrabMouse";
      case 659:
        return "uninstallMessageHandler";
      case 660:
        return "usesFallbackMouseGrabber";
    }
    throw Error();
  }

//tag=1020
  void registerCallbacks() {
    assert(thisCpp != null);
    final RegisterMethodIsReimplementedCallback registerCallback = _dylib
        .lookup<ffi.NativeFunction<RegisterMethodIsReimplementedCallback_FFI>>(
            'c_KDDockWidgets__Platform__registerVirtualMethodCallback')
        .asFunction();

//tag=1021
    final callback626 = ffi.Pointer.fromFunction<voidstar_Func_voidstar_FFI>(
        Platform.applicationName_calledFromC);
    registerCallback(thisCpp, callback626, 626);
//tag=1021
    final callback627 = ffi.Pointer.fromFunction<voidstar_Func_voidstar_FFI>(
        Platform.createDefaultViewFactory_calledFromC);
    registerCallback(thisCpp, callback627, 627);
//tag=1021
    final callback628 =
        ffi.Pointer.fromFunction<voidstar_Func_voidstar_voidstar_voidstar_FFI>(
            Platform.createView_calledFromC);
    registerCallback(thisCpp, callback628, 628);
    const callbackExcept629 = 0;
//tag=1021
    final callback629 = ffi.Pointer.fromFunction<int_Func_voidstar_FFI>(
        Platform.displayType_calledFromC, callbackExcept629);
    registerCallback(thisCpp, callback629, 629);
    const callbackExcept630 = 0;
//tag=1021
    final callback630 = ffi.Pointer.fromFunction<bool_Func_voidstar_FFI>(
        Platform.hasActivePopup_calledFromC, callbackExcept630);
    registerCallback(thisCpp, callback630, 630);
    const callbackExcept631 = 0;
//tag=1021
    final callback631 =
        ffi.Pointer.fromFunction<bool_Func_voidstar_voidstar_FFI>(
            Platform.inDisallowedDragView_calledFromC, callbackExcept631);
    registerCallback(thisCpp, callback631, 631);
//tag=1021
    final callback632 = ffi.Pointer.fromFunction<void_Func_voidstar_FFI>(
        Platform.installMessageHandler_calledFromC);
    registerCallback(thisCpp, callback632, 632);
    const callbackExcept634 = 0;
//tag=1021
    final callback634 = ffi.Pointer.fromFunction<bool_Func_voidstar_FFI>(
        Platform.isLeftMouseButtonPressed_calledFromC, callbackExcept634);
    registerCallback(thisCpp, callback634, 634);
    const callbackExcept635 = 0;
//tag=1021
    final callback635 = ffi.Pointer.fromFunction<bool_Func_voidstar_FFI>(
        Platform.isProcessingAppQuitEvent_calledFromC, callbackExcept635);
    registerCallback(thisCpp, callback635, 635);
//tag=1021
    final callback638 = ffi.Pointer.fromFunction<string_Func_voidstar_FFI>(
        Platform.name_calledFromC);
    registerCallback(thisCpp, callback638, 638);
//tag=1021
    final callback639 = ffi.Pointer.fromFunction<voidstar_Func_voidstar_FFI>(
        Platform.organizationName_calledFromC);
    registerCallback(thisCpp, callback639, 639);
//tag=1021
    final callback640 = ffi.Pointer.fromFunction<void_Func_voidstar_FFI>(
        Platform.restoreMouseCursor_calledFromC);
    registerCallback(thisCpp, callback640, 640);
    const callbackExcept641 = 0;
//tag=1021
    final callback641 =
        ffi.Pointer.fromFunction<int_Func_voidstar_voidstar_FFI>(
            Platform.screenNumberFor_calledFromC, callbackExcept641);
    registerCallback(thisCpp, callback641, 641);
//tag=1021
    final callback642 =
        ffi.Pointer.fromFunction<voidstar_Func_voidstar_voidstar_FFI>(
            Platform.screenSizeFor_calledFromC);
    registerCallback(thisCpp, callback642, 642);
//tag=1021
    final callback643 =
        ffi.Pointer.fromFunction<void_Func_voidstar_voidstar_voidstar_FFI>(
            Platform.sendEvent_calledFromC);
    registerCallback(thisCpp, callback643, 643);
//tag=1021
    final callback644 =
        ffi.Pointer.fromFunction<void_Func_voidstar_ffi_Int32_FFI>(
            Platform.setMouseCursor_calledFromC);
    registerCallback(thisCpp, callback644, 644);
    const callbackExcept646 = 0;
//tag=1021
    final callback646 = ffi.Pointer.fromFunction<int_Func_voidstar_FFI>(
        Platform.startDragDistance_impl_calledFromC, callbackExcept646);
    registerCallback(thisCpp, callback646, 646);
//tag=1021
    final callback647 =
        ffi.Pointer.fromFunction<voidstar_Func_voidstar_voidstar_FFI>(
            Platform.tests_createNonClosableView_calledFromC);
    registerCallback(thisCpp, callback647, 647);
//tag=1021
    final callback649 = ffi.Pointer.fromFunction<void_Func_voidstar_FFI>(
        Platform.tests_deinitPlatform_impl_calledFromC);
    registerCallback(thisCpp, callback649, 649);
//tag=1021
    final callback650 = ffi.Pointer.fromFunction<void_Func_voidstar_FFI>(
        Platform.tests_initPlatform_impl_calledFromC);
    registerCallback(thisCpp, callback650, 650);
//tag=1021
    final callback651 =
        ffi.Pointer.fromFunction<void_Func_voidstar_ffi_Int32_FFI>(
            Platform.tests_wait_calledFromC);
    registerCallback(thisCpp, callback651, 651);
    const callbackExcept652 = 0;
//tag=1021
    final callback652 =
        ffi.Pointer.fromFunction<bool_Func_voidstar_voidstar_ffi_Int32_FFI>(
            Platform.tests_waitForDeleted_calledFromC, callbackExcept652);
    registerCallback(thisCpp, callback652, 652);
    const callbackExcept653 = 0;
//tag=1021
    final callback653 =
        ffi.Pointer.fromFunction<bool_Func_voidstar_voidstar_ffi_Int32_FFI>(
            Platform.tests_waitForDeleted_2_calledFromC, callbackExcept653);
    registerCallback(thisCpp, callback653, 653);
    const callbackExcept654 = 0;
//tag=1021
    final callback654 = ffi.Pointer.fromFunction<
            bool_Func_voidstar_voidstar_ffi_Int32_ffi_Int32_FFI>(
        Platform.tests_waitForEvent_calledFromC, callbackExcept654);
    registerCallback(thisCpp, callback654, 654);
    const callbackExcept655 = 0;
//tag=1021
    final callback655 = ffi.Pointer.fromFunction<
            bool_Func_voidstar_voidstar_ffi_Int32_ffi_Int32_FFI>(
        Platform.tests_waitForEvent_2_calledFromC, callbackExcept655);
    registerCallback(thisCpp, callback655, 655);
    const callbackExcept656 = 0;
//tag=1021
    final callback656 =
        ffi.Pointer.fromFunction<bool_Func_voidstar_voidstar_ffi_Int32_FFI>(
            Platform.tests_waitForResize_calledFromC, callbackExcept656);
    registerCallback(thisCpp, callback656, 656);
    const callbackExcept657 = 0;
//tag=1021
    final callback657 =
        ffi.Pointer.fromFunction<bool_Func_voidstar_voidstar_ffi_Int32_FFI>(
            Platform.tests_waitForResize_2_calledFromC, callbackExcept657);
    registerCallback(thisCpp, callback657, 657);
//tag=1021
    final callback658 = ffi.Pointer.fromFunction<void_Func_voidstar_FFI>(
        Platform.ungrabMouse_calledFromC);
    registerCallback(thisCpp, callback658, 658);
//tag=1021
    final callback659 = ffi.Pointer.fromFunction<void_Func_voidstar_FFI>(
        Platform.uninstallMessageHandler_calledFromC);
    registerCallback(thisCpp, callback659, 659);
    const callbackExcept660 = 0;
//tag=1021
    final callback660 = ffi.Pointer.fromFunction<bool_Func_voidstar_FFI>(
        Platform.usesFallbackMouseGrabber_calledFromC, callbackExcept660);
    registerCallback(thisCpp, callback660, 660);
  }
}
