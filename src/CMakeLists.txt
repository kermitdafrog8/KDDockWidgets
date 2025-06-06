# This file is part of KDDockWidgets.
#
# SPDX-FileCopyrightText: 2019 Klarälvdalens Datakonsult AB, a KDAB Group company <info@kdab.com>
# Author: Sergio Martins <sergio.martins@kdab.com>
#
# SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only
#
# Contact KDAB at <info@kdab.com> for commercial licensing options.
#

if(POLICY CMP0043)
    cmake_policy(SET CMP0043 NEW)
endif()

if(KDDW_FRONTEND_QT)
    add_definitions(
        -DQT_NO_SIGNALS_SLOTS_KEYWORDS -DQT_USE_QSTRINGBUILDER -DQT_NO_NARROWING_CONVERSIONS_IN_CONNECT
        -DQT_STRICT_ITERATORS -DQT_NO_KEYWORDS -DQT_NO_FOREACH
    )
endif()

set(KDDW_LAYOUTING_SRCS core/layouting/Item.cpp core/layouting/ItemFreeContainer.cpp core/Logging.cpp KDDockWidgets.cpp)

set(KDDW_BACKEND_SRCS
    Config.cpp
    LayoutSaver.cpp
    core/Position.cpp
    core/DelayedCall.cpp
    core/Draggable.cpp
    core/WindowBeingDragged.cpp
    core/DragController.cpp
    core/WidgetResizeHandler.cpp
    core/Action.cpp
    core/DockRegistry.cpp
    core/FocusScope.cpp
    core/DockWidget.cpp
    core/DropArea.cpp
    core/DropIndicatorOverlay.cpp
    core/FloatingWindow.cpp
    core/Group.cpp
    core/Layout.cpp
    core/MainWindow.cpp
    core/MDILayout.cpp
    core/Separator.cpp
    core/SideBar.cpp
    core/Stack.cpp
    core/TitleBar.cpp
    core/TabBar.cpp
    core/ViewFactory.cpp
    core/Window.cpp
    core/Screen.cpp
    core/ViewGuard.cpp
    core/Controller.cpp
    core/Platform.cpp
    core/View.cpp
    core/indicators/NullDropIndicatorOverlay.cpp
    core/indicators/ClassicDropIndicatorOverlay.cpp
    core/indicators/SegmentedDropIndicatorOverlay.cpp
    core/views/ClassicIndicatorWindowViewInterface.cpp
    core/views/MainWindowMDIViewInterface.cpp
    core/views/MainWindowViewInterface.cpp
    core/views/GroupViewInterface.cpp
    core/views/DockWidgetViewInterface.cpp
    core/views/StackViewInterface.cpp
    core/views/TabBarViewInterface.cpp
    core/views/TitleBarViewInterface.cpp
    core/views/SideBarViewInterface.cpp
    kddockwidgets_resources.qrc
)

# Sources shared by Qt frontends (QtWidgets and QtQuick)
set(KDDW_QTCOMMON_SRCS
    qtcommon/Platform.cpp
    qtcommon/Window.cpp
    qtcommon/View.cpp
    qtcommon/Screen.cpp
    qtcommon/ViewWrapper.cpp
    qtcommon/CustomFrameHelper.cpp
    qtcommon/DragControllerWayland_p.cpp
)

set(KDDW_FRONTEND_QTWIDGETS_SRCS
    qtwidgets/Action.cpp
    qtwidgets/Window.cpp
    qtwidgets/Platform.cpp
    qtwidgets/views/View.cpp
    qtwidgets/views/ViewWrapper.cpp
    qtwidgets/views/FloatingWindow.cpp
    qtwidgets/views/DockWidget.cpp
    qtwidgets/views/DropArea.cpp
    qtwidgets/views/MDILayout.cpp
    qtwidgets/views/Group.cpp
    qtwidgets/views/MainWindow.cpp
    qtwidgets/views/MainWindowMDI.cpp
    qtwidgets/views/MDIArea.cpp
    qtwidgets/views/RubberBand.cpp
    qtwidgets/views/Separator.cpp
    qtwidgets/views/TitleBar.cpp
    qtwidgets/views/TabBar.cpp
    qtwidgets/views/Stack.cpp
    qtwidgets/views/SideBar.cpp
    qtwidgets/views/ClassicIndicatorsWindow.cpp
    qtwidgets/views/SegmentedDropIndicatorOverlay.cpp
    qtwidgets/ViewFactory.cpp
    qtwidgets/DebugWindow.cpp
    qtwidgets/ObjectViewer.cpp
)

set(KDDW_FRONTEND_QTWIDGETS_VIEW_HEADERS
    qtwidgets/views/View.h
    qtwidgets/views/FloatingWindow.h
    qtwidgets/views/DockWidget.h
    qtwidgets/views/DropArea.h
    qtwidgets/views/MDILayout.h
    qtwidgets/views/Group.h
    qtwidgets/views/MainWindow.h
    qtwidgets/views/MainWindowMDI.h
    qtwidgets/views/MDIArea.h
    qtwidgets/views/RubberBand.h
    qtwidgets/views/Separator.h
    qtwidgets/views/TitleBar.h
    qtwidgets/views/TabBar.h
    qtwidgets/views/Stack.h
    qtwidgets/views/SideBar.h
    qtwidgets/views/ClassicIndicatorsWindow.h
    qtwidgets/views/SegmentedDropIndicatorOverlay.h
)

set(KDDW_FRONTEND_QTQUICK_SRCS
    qtquick/Action.cpp
    qtquick/Window.cpp
    qtquick/Platform.cpp
    qtquick/Helpers.cpp
    qtquick/ViewFactory.cpp
    qtquick/QmlTypes.cpp
    qtquick/views/DropArea.cpp
    qtquick/views/DockWidget.cpp
    qtquick/views/FloatingWindow.cpp
    qtquick/views/MainWindow.cpp
    qtquick/views/MainWindowMDI.cpp
    qtquick/views/MDILayout.cpp
    qtquick/views/RubberBand.cpp
    qtquick/views/Separator.cpp
    qtquick/views/Stack.cpp
    qtquick/views/TabBar.cpp
    qtquick/views/View.cpp
    qtquick/views/ViewWrapper.cpp
    qtquick/views/ClassicIndicatorsWindow.cpp
)

if(NOT KDDockWidgets_QML_MODULE)
    set(KDDW_FRONTEND_QTQUICK_SRCS ${KDDW_FRONTEND_QTQUICK_SRCS} qtquick/kddockwidgets_qtquick.qrc)
endif()

set(KDDW_FRONTEND_QTQUICK_VIEW_HEADERS
    qtquick/views/DropArea.h
    qtquick/views/DockWidget.h
    qtquick/views/FloatingWindow.h
    qtquick/views/Group.h
    qtquick/views/MainWindow.h
    qtquick/views/MainWindowMDI.h
    qtquick/views/MDILayout.h
    qtquick/views/RubberBand.h
    qtquick/views/Separator.h
    qtquick/views/Stack.h
    qtquick/views/TabBar.h
    qtquick/views/TitleBar.h
    qtquick/views/View.h
    qtquick/views/ClassicIndicatorsWindow.h
)

set(KDDW_FRONTEND_QTCOMPAT_SRCS qtcompat/Object.cpp)

set(KDDW_FRONTEND_FLUTTER_SRCS flutter/kddw_bindings.cpp)

set(KDDW_FRONTEND_FLUTTER_SRCS ${KDDW_FRONTEND_FLUTTER_SRCS} ${KDDW_FRONTEND_QTCOMPAT_SRCS})

if(KDDockWidgets_DEVELOPER_MODE)
    set(KDDW_FRONTEND_QTQUICK_SRCS ${KDDW_FRONTEND_QTQUICK_SRCS} qtquick/TestHelpers.cpp)
    set(KDDW_FRONTEND_QTWIDGETS_SRCS ${KDDW_FRONTEND_QTWIDGETS_SRCS} qtwidgets/TestHelpers.cpp)
    set(KDDW_QTCOMMON_SRCS ${KDDW_QTCOMMON_SRCS} qtcommon/TestHelpers_qt.cpp)
endif()

set(KDDW_PUBLIC_HEADERS docks_export.h Config.h KDDockWidgets.h LayoutSaver.h Qt5Qt6Compat_p.h QtCompat_p.h)

set(KDDW_CORE_HEADERS
    core/DockWidget.h
    core/DropIndicatorOverlay.h
    core/DropArea.h
    core/FloatingWindow.h
    core/Group.h
    core/Layout.h
    core/MDILayout.h
    core/SideBar.h
    core/TabBar.h
    core/FocusScope.h
    core/MainWindow.h
    core/Separator.h
    core/Stack.h
    core/TitleBar.h
    core/View.h
    core/EventFilterInterface.h
    core/Draggable_p.h
    core/WindowBeingDragged_p.h
    core/WidgetResizeHandler_p.h
    core/DockRegistry.h
    core/Controller.h
    core/ViewFactory.h
    core/Platform.h
    core/Action.h
)

set(KDDW_VIEWINTERFACE_HEADERS
    core/views/StackViewInterface.h
    core/views/SideBarViewInterface.h
    core/views/ClassicIndicatorWindowViewInterface.h
    core/views/TabBarViewInterface.h
    core/views/TitleBarViewInterface.h
    core/views/DockWidgetViewInterface.h
    core/views/MainWindowMDIViewInterface.h
    core/views/MainWindowViewInterface.h
    core/views/GroupViewInterface.h
)

set(KDDW_INDICATOR_HEADERS core/indicators/NullDropIndicatorOverlay.h core/indicators/ClassicDropIndicatorOverlay.h
                           core/indicators/SegmentedDropIndicatorOverlay.h
)

set(DOCKSLIBS_SRCS ${KDDW_LAYOUTING_SRCS})

if(KDDW_FRONTEND_QTWIDGETS)
    set(DOCKSLIBS_SRCS ${DOCKSLIBS_SRCS} ${KDDW_FRONTEND_QTWIDGETS_SRCS})
endif()

if(KDDW_FRONTEND_QTQUICK)
    set(DOCKSLIBS_SRCS ${DOCKSLIBS_SRCS} ${KDDW_FRONTEND_QTQUICK_SRCS})
endif()

if(KDDW_FRONTEND_QT)
    set(DOCKSLIBS_SRCS ${DOCKSLIBS_SRCS} ${KDDW_BACKEND_SRCS} ${KDDW_QTCOMMON_SRCS})
endif()

if(KDDW_FRONTEND_FLUTTER)
    set(DOCKSLIBS_SRCS ${DOCKSLIBS_SRCS} ${KDDW_FRONTEND_FLUTTER_SRCS})
endif()

if(KDDW_FRONTEND_NONE)
    set(DOCKSLIBS_SRCS ${DOCKSLIBS_SRCS} qtcompat/Object.cpp)
endif()

# Generate C/C++ CamelCase forwarding headers (only public includes)
include(ECMGenerateHeaders)
ecm_generate_headers(camelcase_HEADERS ORIGINAL CAMELCASE HEADER_NAMES Config LayoutSaver)

add_library(kddockwidgets ${KDDockWidgets_LIBRARY_MODE} ${DOCKSLIBS_SRCS} ${KDDW_PUBLIC_HEADERS})

add_library(KDAB::kddockwidgets ALIAS kddockwidgets)
set_target_properties(kddockwidgets PROPERTIES OUTPUT_NAME "kddockwidgets${KDDockWidgets_LIBRARY_QTID}")
set_compiler_flags(kddockwidgets)

if(KDDockWidgets_QT6)
    set(DOCKS_INCLUDES_INSTALL_PATH "include/kddockwidgets-qt6")
else()
    set(DOCKS_INCLUDES_INSTALL_PATH "include/")
endif()

target_include_directories(
    kddockwidgets
    PUBLIC $<INSTALL_INTERFACE:${DOCKS_INCLUDES_INSTALL_PATH}>
           $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/fwd_headers>
    PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}
)

if(KDDW_FRONTEND_QTWIDGETS)
    if(KDockWidgets_PRETTY_QTWIDGETS_HEADERS)
        target_include_directories(
            kddockwidgets PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/fwd_headers/qtwidgets_pretty>
        )
    endif()
endif()

if(KDDW_FRONTEND_QTQUICK)
    target_include_directories(
        kddockwidgets PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/fwd_headers/qtquick>
                             $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/qtquick>
    )
endif()

if(KDDW_FRONTEND_FLUTTER)
    target_include_directories(
        kddockwidgets
        PRIVATE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/qtcompat>
                $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/core>
                $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/core/layouting>
                $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
                $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}>
    )

    # So bindings are exported
    target_compile_definitions(kddockwidgets PRIVATE BUILDING_KDDockWidgets)

    if(MSVC)
        set(FLUTTER_ENGINE_LIBRARY flutter_engine.dll.lib)
    else()
        if(KDDockWidgets_FLUTTER_TESTS_AOT)
            set(FLUTTER_ENGINE_LIBRARY rel/libflutter_engine.so)
        else()
            set(FLUTTER_ENGINE_LIBRARY dbg/libflutter_engine.so)
        endif()

        set_source_files_properties(
            ${KDDW_FRONTEND_DARTBINDINGS_SRCS}
            PROPERTIES COMPILE_FLAGS "-Wno-unused-function -Wno-unused-variable -Wno-format-security \
                -Wno-unused-parameter -Wno-shadow -Wno-sign-conversion"
        )
    endif()
endif()

if(KDDW_FRONTEND_NONE)
    target_include_directories(
        kddockwidgets PRIVATE $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/core>
                              $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}> $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}>
    )
endif()

if(KDDW_FRONTEND_QT)
    target_compile_definitions(
        kddockwidgets PRIVATE QT_NO_CAST_TO_ASCII QT_NO_CAST_FROM_ASCII QT_NO_URL_CAST_FROM_STRING
                              QT_NO_CAST_FROM_BYTEARRAY
    )
endif()

if(KDDockWidgets_STATIC)
    target_compile_definitions(kddockwidgets PUBLIC KDDOCKWIDGETS_STATICLIB)
else()
    target_compile_definitions(kddockwidgets PRIVATE BUILDING_DOCKS_LIBRARY)
endif()

if(CMAKE_COMPILER_IS_GNUCXX OR IS_CLANG_BUILD)
    target_compile_options(kddockwidgets PRIVATE -Wshadow)
    if(NOT MSVC)
        target_compile_options(kddockwidgets PRIVATE -fvisibility=hidden)
    endif()

    # Disable -Wconversion for Qt6. The qsizetype to int conversions are harmless
    if(NOT KDDockWidgets_QT6)
        target_compile_options(kddockwidgets PRIVATE -Wconversion)
    endif()

    if(IS_CLANG_BUILD)
        target_compile_options(kddockwidgets PRIVATE -Wweak-vtables)
    endif()
endif()

if(WIN32)
    # To unbreak std::min/max
    target_compile_definitions(kddockwidgets PRIVATE NOMINMAX)
endif()

# BEGIN coverage
add_library(kddw_coverage_options INTERFACE)

if(KDDockWidgets_CODE_COVERAGE
   AND (CMAKE_COMPILER_IS_GNUCXX OR IS_CLANG_BUILD)
   AND NOT MSVC
)
    if(KDDockWidgets_DEVELOPER_MODE)
        # Add required flags (GCC & LLVM/Clang)
        target_compile_options(kddw_coverage_options INTERFACE --coverage)
        if(CMAKE_VERSION VERSION_GREATER_EQUAL 3.13)
            target_link_options(kddw_coverage_options INTERFACE --coverage)
        else()
            target_link_libraries(kddw_coverage_options INTERFACE --coverage)
        endif()
    endif()
endif()
# END coverage

if(KDDW_FRONTEND_QTWIDGETS)
    target_link_libraries(
        kddockwidgets
        PUBLIC Qt${QT_VERSION_MAJOR}::Widgets
        PRIVATE Qt${QT_VERSION_MAJOR}::WidgetsPrivate
    )

    if(KDDockWidgets_QT6)
        target_link_libraries(kddockwidgets PRIVATE Qt6::GuiPrivate # qx11extras_p.h
        )
    endif()

    target_compile_definitions(kddockwidgets PUBLIC KDDW_FRONTEND_QTWIDGETS KDDW_FRONTEND_QT)
endif()

if(KDDW_FRONTEND_QTQUICK)
    target_link_libraries(kddockwidgets PUBLIC Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::QuickControls2)
    target_link_libraries(kddockwidgets PRIVATE Qt${QT_VERSION_MAJOR}::GuiPrivate Qt${QT_VERSION_MAJOR}::QuickPrivate)
    target_compile_definitions(kddockwidgets PUBLIC KDDW_FRONTEND_QTQUICK KDDW_FRONTEND_QT)
endif()

if(NOT KDDW_FRONTEND_QT)
    include(GenerateExportHeader)
    generate_export_header(
        kddockwidgets EXPORT_FILE_NAME "${CMAKE_BINARY_DIR}/kddockwidgets_export.h" EXPORT_MACRO_NAME DOCKS_EXPORT
    )
endif()

if(KDDW_FRONTEND_FLUTTER)
    target_compile_definitions(kddockwidgets PUBLIC KDDW_FRONTEND_FLUTTER)
endif()

if(KDDockWidgets_CODE_COVERAGE)
    target_link_libraries(kddockwidgets PUBLIC kddw_coverage_options)
endif()

kddw_link_to_kdbindings(kddockwidgets)

if(KDDockWidgets_HAS_SPDLOG)
    target_link_libraries(kddockwidgets PRIVATE spdlog::spdlog)
endif()

if(KDDW_FRONTEND_QT)
    if(WIN32)
        target_link_libraries(kddockwidgets PRIVATE Qt${QT_VERSION_MAJOR}::GuiPrivate dwmapi)
    elseif(
        NOT APPLE
        AND NOT EMSCRIPTEN
        AND NOT KDDockWidgets_QT6
        AND KDDockWidgets_X11EXTRAS
    )
        find_package(Qt${QT_VERSION_MAJOR}X11Extras CONFIG)
        target_link_libraries(kddockwidgets PUBLIC Qt${QT_VERSION_MAJOR}::X11Extras)
    endif()

    if(KDDockWidgets_DEVELOPER_MODE)
        find_package(Qt${QT_VERSION_MAJOR}Test ${QT_MIN_VERSION} REQUIRED)
        target_link_libraries(kddockwidgets PUBLIC Qt${QT_VERSION_MAJOR}::Test)
    endif()
endif()

if(KDDockWidgets_XLib)
    target_link_libraries(kddockwidgets PRIVATE X11)
endif()

include(nlohmann.cmake)
link_to_nlohman(kddockwidgets)

set_target_properties(kddockwidgets PROPERTIES SOVERSION ${KDDockWidgets_SOVERSION} VERSION ${KDDockWidgets_VERSION})

# version libraries on Windows
if(WIN32)
    if(CMAKE_BUILD_TYPE)
        set(postfix "${KDDockWidgets_VERSION_MAJOR}${KDDockWidgets_LIBRARY_POSTFIX}")

        string(TOUPPER ${CMAKE_BUILD_TYPE} UPPER_BUILD_TYPE)
        if(${UPPER_BUILD_TYPE} MATCHES "^DEBUG")
            string(CONCAT postfix ${postfix} "d")
            set_target_properties(kddockwidgets PROPERTIES DEBUG_POSTFIX ${postfix})
        else()
            set_target_properties(kddockwidgets PROPERTIES ${UPPER_BUILD_TYPE}_POSTFIX ${postfix})
        endif()
    elseif(CMAKE_CONFIGURATION_TYPES)
        # Visual Studio generator
        set_target_properties(kddockwidgets PROPERTIES DEBUG_POSTFIX d)
    endif()
endif()

if(KDDW_FRONTEND_QT)
    install(
        TARGETS kddockwidgets
        EXPORT kddockwidgetsTargets
        RUNTIME DESTINATION ${INSTALL_RUNTIME_DIR}
        LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
        ARCHIVE DESTINATION ${INSTALL_ARCHIVE_DIR}
    )
    if(MSVC AND NOT KDDockWidgets_STATIC)
        install(
            FILES "$<TARGET_PDB_FILE_DIR:kddockwidgets>/$<TARGET_PDB_FILE_NAME:kddockwidgets>"
            DESTINATION ${INSTALL_RUNTIME_DIR}
            CONFIGURATIONS Debug RelWithDebInfo
        )
    endif()

    # install(FILES ${camelcase_HEADERS} DESTINATION
    # ${DOCKS_INCLUDES_INSTALL_PATH}/kddockwidgets)
    install(FILES ${KDDW_PUBLIC_HEADERS} DESTINATION ${DOCKS_INCLUDES_INSTALL_PATH}/kddockwidgets)
    install(FILES ${KDDW_CORE_HEADERS} DESTINATION ${DOCKS_INCLUDES_INSTALL_PATH}/kddockwidgets/core)
    install(FILES ${KDDW_VIEWINTERFACE_HEADERS} DESTINATION ${DOCKS_INCLUDES_INSTALL_PATH}/kddockwidgets/core/views)
    install(FILES ${KDDW_INDICATOR_HEADERS} DESTINATION ${DOCKS_INCLUDES_INSTALL_PATH}/kddockwidgets/core/indicators)
endif()

if(KDDW_FRONTEND_QTWIDGETS)

    set(KDDW_QTWIDGET_HEADERS qtwidgets/ViewFactory.h)

    set(KDDW_QTWIDGET_VIEW_HEADERS
        qtwidgets/views/DockWidget.h
        qtwidgets/views/Separator.h
        qtwidgets/views/RubberBand.h
        qtwidgets/views/SideBar.h
        qtwidgets/views/FloatingWindow.h
        qtwidgets/views/View.h
        qtwidgets/views/MainWindowMDI.h
        qtwidgets/views/MDILayout.h
        qtwidgets/views/MDIArea.h
        qtwidgets/views/DropArea.h
        qtwidgets/views/Stack.h
        qtwidgets/views/Group.h
        qtwidgets/views/TabBar.h
        qtwidgets/views/ClassicIndicatorsWindow.h
        qtwidgets/views/SegmentedDropIndicatorOverlay.h
        qtwidgets/views/MainWindow.h
        qtwidgets/views/TitleBar.h
    )

    install(FILES ${KDDW_QTWIDGET_HEADERS} DESTINATION ${DOCKS_INCLUDES_INSTALL_PATH}/kddockwidgets)
    install(FILES ${KDDW_QTWIDGET_HEADERS} DESTINATION ${DOCKS_INCLUDES_INSTALL_PATH}/kddockwidgets/qtwidgets/)

    install(FILES ${KDDW_QTWIDGET_VIEW_HEADERS} DESTINATION ${DOCKS_INCLUDES_INSTALL_PATH}/kddockwidgets/qtwidgets/)
    install(FILES ${KDDW_FRONTEND_QTWIDGETS_VIEW_HEADERS}
            DESTINATION ${DOCKS_INCLUDES_INSTALL_PATH}/kddockwidgets/qtwidgets/views/
    )

    if(KDockWidgets_PRETTY_QTWIDGETS_HEADERS)
        set(KDDW_QTWIDGET_PRETTY_HEADERS
            fwd_headers/qtwidgets_pretty/kddockwidgets/MainWindow.h
            fwd_headers/qtwidgets_pretty/kddockwidgets/DockWidget.h
            fwd_headers/qtwidgets_pretty/kddockwidgets/ViewFactory.h
        )

        install(FILES ${KDDW_QTWIDGET_PRETTY_HEADERS} DESTINATION ${DOCKS_INCLUDES_INSTALL_PATH}/kddockwidgets)
    endif()
endif()

if(KDDW_FRONTEND_QTQUICK)
    set(QT_QML_GENERATE_QMLLS_INI ON)

    set(KDDW_MODULE_QML_ELEMENTS
        qtquick/Singletons.cpp
        qtquick/Singletons_p.h
        qtquick/Helpers.cpp
        qtquick/Helpers_p.h
        qtquick/ViewFactory.cpp
        qtquick/ViewFactory.h
        core/ViewFactory.h
        qtquick/MainWindowInstantiator.cpp
        qtquick/MainWindowInstantiator.h
        qtquick/LayoutSaverInstantiator.cpp
        qtquick/LayoutSaverInstantiator.h
        qtquick/DockWidgetInstantiator.cpp
        qtquick/DockWidgetInstantiator.h
        qtquick/MainWindowMDIInstantiator.cpp
        qtquick/MainWindowMDIInstantiator.h
        qtquick/views/Group.cpp
        qtquick/views/Group.h
        qtquick/views/TitleBar.cpp
        qtquick/views/TitleBar.h
    )

    if(NOT KDDockWidgets_QML_MODULE)
        # if we're not building a module, we need to build them explicitly
        target_sources(kddockwidgets PRIVATE ${KDDW_MODULE_QML_ELEMENTS})
    endif()

    set(KDDW_QTQUICK_HEADERS
        qtquick/Platform.h
        qtquick/Action.h
        qtquick/ViewFactory.h
        qtquick/DockWidgetInstantiator.h
        qtquick/LayoutSaverInstantiator.h
        qtquick/MainWindowInstantiator.h
        qtquick/MainWindowMDIInstantiator.h
    )

    set(KDDW_QTQUICK_VIEW_HEADERS
        qtquick/views/ClassicIndicatorsWindow.h
        qtquick/views/View.h
        qtquick/views/Separator.h
        qtquick/views/MainWindowMDI.h
        qtquick/views/RubberBand.h
        qtquick/views/MainWindow.h
        qtquick/views/Separator.h
        qtquick/views/FloatingWindow.h
        qtquick/views/SideBar.h
        qtquick/views/TabBar.h
        qtquick/views/DockWidget.h
        qtquick/views/Stack.h
        qtquick/views/MDILayout.h
        qtquick/views/DropArea.h
        qtquick/views/Group.h
        qtquick/views/TitleBar.h
    )

    if(KDDockWidgets_QML_MODULE)
        qt_policy(SET QTP0001 NEW)

        # fix resource paths since
        function(fix_resource_paths)
            foreach(srcfile IN LISTS ARGN)
                get_filename_component(FILENAME ${srcfile} NAME)
                set_source_files_properties(${srcfile} PROPERTIES QT_RESOURCE_ALIAS ${FILENAME})
            endforeach()
        endfunction()

        set(KDDW_QML_FILES
            qtquick/views/qml/DropArea.qml
            qtquick/views/qml/TitleBarBase.qml
            qtquick/views/qml/TitleBar.qml
            qtquick/views/qml/Group.qml
            qtquick/views/qml/FloatingWindow.qml
            qtquick/views/qml/TabBarBase.qml
            qtquick/views/qml/TabBar.qml
            qtquick/views/qml/Separator.qml
            qtquick/views/qml/MDIResizeHandlerHelper.qml
            qtquick/views/qml/RubberBand.qml
            qtquick/views/qml/TitleBarButton.qml
            qtquick/views/qml/ClassicIndicatorsOverlay.qml
            qtquick/views/qml/ClassicIndicator.qml
            qtquick/views/qml/DockWidgetView.qml
        )

        fix_resource_paths(${KDDW_QML_FILES})

        target_compile_definitions(kddockwidgets PUBLIC KDDW_QML_MODULE)

        qt_add_qml_module(
            kddockwidgets
            URI
            com.kdab.dockwidgets
            VERSION
            2.0
            QML_FILES
            ${KDDW_QML_FILES}
            SOURCES
            KDDockWidgets.h
            ${KDDW_MODULE_QML_ELEMENTS}
            OUTPUT_DIRECTORY
            ${CMAKE_BINARY_DIR}/com/kdab/dockwidgets
            DEPENDENCIES
            QtQuick
            # NO_PLUGIN # For now. Feel free to enable plugin but add CI test coverage
        )
    endif()

    install(FILES ${KDDW_QTQUICK_HEADERS} DESTINATION ${DOCKS_INCLUDES_INSTALL_PATH}/kddockwidgets/qtquick)
    install(FILES ${KDDW_QTQUICK_VIEW_HEADERS} DESTINATION ${DOCKS_INCLUDES_INSTALL_PATH}/kddockwidgets/qtquick)
    install(FILES ${KDDW_FRONTEND_QTQUICK_VIEW_HEADERS}
            DESTINATION ${DOCKS_INCLUDES_INSTALL_PATH}/kddockwidgets/qtquick/views
    )
endif()

if(KDDW_FRONTEND_QTWIDGETS OR KDDW_FRONTEND_QTQUICK)
    set(KDDW_QTCOMMON_HEADERS qtcommon/Platform.h qtcommon/View.h)
    install(FILES ${KDDW_QTCOMMON_HEADERS} DESTINATION ${DOCKS_INCLUDES_INSTALL_PATH}/kddockwidgets/qtcommon)

    # Generate library version files
    include(ECMSetupVersion)
    ecm_setup_version(
        ${KDDockWidgets_VERSION}
        VARIABLE_PREFIX
        KDDOCKWIDGETS
        VERSION_HEADER
        "${CMAKE_CURRENT_BINARY_DIR}/kddockwidgets_version.h"
        PACKAGE_VERSION_FILE
        "${CMAKE_CURRENT_BINARY_DIR}/KDDockWidgets${KDDockWidgets_LIBRARY_QTID}ConfigVersion.cmake"
        SOVERSION
        ${KDDockWidgets_SOVERSION}
        COMPATIBILITY
        AnyNewerVersion
    )
    install(FILES "${CMAKE_CURRENT_BINARY_DIR}/kddockwidgets_version.h"
            DESTINATION ${DOCKS_INCLUDES_INSTALL_PATH}/kddockwidgets
    )

    install(
        EXPORT kddockwidgetsTargets
        FILE KDDockWidgets${KDDockWidgets_LIBRARY_QTID}Targets.cmake
        NAMESPACE KDAB::
        DESTINATION ${INSTALL_LIBRARY_DIR}/cmake/KDDockWidgets${KDDockWidgets_LIBRARY_QTID}
    )

endif()

configure_file(KDDockWidgetsConfig.cmake.in KDDockWidgets${KDDockWidgets_LIBRARY_QTID}Config.cmake @ONLY)
install(FILES "${CMAKE_CURRENT_BINARY_DIR}/KDDockWidgets${KDDockWidgets_LIBRARY_QTID}Config.cmake"
              "${CMAKE_CURRENT_BINARY_DIR}/KDDockWidgets${KDDockWidgets_LIBRARY_QTID}ConfigVersion.cmake"
        DESTINATION ${INSTALL_LIBRARY_DIR}/cmake/KDDockWidgets${KDDockWidgets_LIBRARY_QTID}
)

if(KDDockWidgets_DEVELOPER_MODE AND KDDW_FRONTEND_QTWIDGETS)
    # Under developer mode since kddw might be a sub-folder of a project setting a
    # different value for QT_DISABLE_DEPRECATED_BEFORE
    target_compile_definitions(kddockwidgets PRIVATE QT_DISABLE_DEPRECATED_BEFORE=0x060000)

    option(KDDockWidgets_LINTER "Build the layout linter" ON)

    if(KDDockWidgets_LINTER)
        set(LINTER_SRCS layoutlinter_main.cpp)
        if(KDDW_FRONTEND_QTQUICK)
            # QtQuick needs main.qml to create views
            set(LINTER_SRCS ${LINTER_SRCS} ../tests/test_resources.qrc)
        endif()

        add_executable(kddockwidgets_linter ${LINTER_SRCS})
        target_link_libraries(kddockwidgets_linter PRIVATE kddockwidgets)
        link_to_nlohman(kddockwidgets_linter)
    endif()
endif()
