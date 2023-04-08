/*
  This file is part of KDDockWidgets.

  SPDX-FileCopyrightText: 2019-2023 Klarälvdalens Datakonsult AB, a KDAB Group company <info@kdab.com>
  Author: Sérgio Martins <sergio.martins@kdab.com>

  SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only

  Contact KDAB at <info@kdab.com> for commercial licensing options.
*/

#ifndef KDDOCKWIDGETS_TESTS_UTILS_H
#define KDDOCKWIDGETS_TESTS_UTILS_H

// clazy:excludeall=ctor-missing-parent-argument,missing-qobject-macro,range-loop,missing-typeinfo,detaching-member,function-args-by-ref,non-pod-global-static,reserve-candidates,qstring-allocations

#include "Config.h"
#include "DockRegistry.h"
#include "kddockwidgets/KDDockWidgets.h"

#include "kddockwidgets/controllers/DropIndicatorOverlay.h"
#include "kddockwidgets/controllers/DropArea.h"
#include "kddockwidgets/controllers/TitleBar.h"
#include "kddockwidgets/controllers/Stack.h"
#include "kddockwidgets/controllers/FloatingWindow.h"
#include "kddockwidgets/controllers/DockWidget.h"
#include "kddockwidgets/controllers/DockWidget_p.h"

#include "Utils_p.h"

#include <QPointer>
#include <QVector>
#include <QtTest/QTest>

#include <memory>

static bool s_pauseBeforePress = false; // for debugging
static bool s_pauseBeforeMove = false; // for debugging
#define DEBUGGING_PAUSE_DURATION 5000 // 5 seconds

// clazy:excludeall=ctor-missing-parent-argument,missing-qobject-macro,range-loop,missing-typeinfo,detaching-member,function-args-by-ref,non-pod-global-static,reserve-candidates

namespace KDDockWidgets {

namespace Tests {

enum ButtonAction {
    ButtonAction_None,
    ButtonAction_Press = 1,
    ButtonAction_Release = 2
};
Q_DECLARE_FLAGS(ButtonActions, ButtonAction)

struct DockDescriptor
{
    Location loc;
    int relativeToIndex;
    QPointer<Controllers::DockWidget> createdDock;
    KDDockWidgets::InitialVisibilityOption option;
};

inline QPoint dragPointForWidget(Controllers::Group *group, int index)
{
    if (group->hasSingleDockWidget()) {
        Q_ASSERT(index == 0);
        return group->titleBar()->mapToGlobal(QPoint(5, 5));
    } else {
        QRect rect = group->stack()->tabBar()->rectForTab(index);
        return group->stack()->tabBar()->view()->mapToGlobal(rect.center());
    }
}

struct EnsureTopLevelsDeleted
{
    EnsureTopLevelsDeleted()
        : m_originalFlags(Config::self().flags())
        , m_originalInternalFlags(Config::self().internalFlags())
        , m_originalSeparatorThickness(Config::self().separatorThickness())
    {
    }

    ~EnsureTopLevelsDeleted()
    {
        qDeleteAll(DockRegistry::self()->floatingWindows(/*includeBeingDeleted=*/true));
        qDeleteAll(DockRegistry::self()->dockwidgets());

        if (!DockRegistry::self()->isEmpty()) {
            auto dr = DockRegistry::self();
            qWarning() << "There's still top-level widgets present!"
                       << "\nfloatings:" << dr->floatingWindows(/*includeBeingDeleted=*/true)
                       << "\nmainwindows:" << dr->mainWindowsNames()
                       << "\ndocks:" << dr->dockWidgetNames();
        }

        // Other cleanup, since we use this class everywhere
        Config::self().setDockWidgetFactoryFunc(nullptr);
        Config::self().setInternalFlags(m_originalInternalFlags);
        Config::self().setFlags(m_originalFlags);
        Config::self().setSeparatorThickness(m_originalSeparatorThickness);
    }

    const Config::Flags m_originalFlags;
    const Config::InternalFlags m_originalInternalFlags;
    const int m_originalSeparatorThickness;
};

bool shouldBlacklistWarning(const QString &msg, const QString &category = {});

std::unique_ptr<Controllers::MainWindow>
createMainWindow(QSize sz = { 1000, 1000 },
                 KDDockWidgets::MainWindowOptions options = MainWindowOption_HasCentralFrame,
                 const QString &name = {}, bool show = true);



std::unique_ptr<Controllers::MainWindow> createMainWindow(QVector<DockDescriptor> &docks);

Controllers::DockWidget *createDockWidget(const QString &name, View *guest,
                                          DockWidgetOptions options = {},
                                          LayoutSaverOptions layoutSaverOptions = {},
                                          bool show = true, const QString &affinityName = {});

Controllers::DockWidget *createDockWidget(const QString &name);

void nestDockWidget(Controllers::DockWidget *dock, Controllers::DropArea *dropArea,
                    Controllers::Group *relativeTo, KDDockWidgets::Location location);


void doubleClickOn(QPoint globalPos, std::shared_ptr<Window> receiver);
void pressOn(QPoint globalPos, View *receiver);
void pressOn(QPoint globalPos, std::shared_ptr<Window> receiver);
void releaseOn(QPoint globalPos, View *receiver);
void clickOn(QPoint globalPos, View *receiver);
void moveMouseTo(QPoint globalDest, View *receiver);

inline Controllers::FloatingWindow *createFloatingWindow()
{
    static int count = 0;
    count++;
    auto dock = createDockWidget(QString("dock %1").arg(count));
    return dock->d->morphIntoFloatingWindow();
}

inline View *draggableFor(View *view)
{
    View *draggable = nullptr;
    if (auto dw = view->asDockWidgetController()) {
        if (auto group = dw->d->group())
            draggable = group->titleBar()->view();
    } else if (auto fw = view->asFloatingWindowController()) {
        Controllers::Group *group = fw->hasSingleFrame()
            ? static_cast<Controllers::Group *>(fw->groups().first())
            : nullptr;

        if ((KDDockWidgets::Config::self().flags()
             & KDDockWidgets::Config::Flag_HideTitleBarWhenTabsVisible)
            && group && group->hasTabsVisible()) {
            draggable = group->stack()->view();
        } else {
            draggable = fw->titleBar()->view();
        }
    } else if (view->is(Type::Stack) || view->is(Type::TitleBar)) {
        draggable = view;
    }

    qDebug() << "Draggable is" << draggable << "for" << view;
    return draggable;
}

inline void drag(View *sourceWidget, QPoint pressGlobalPos, QPoint globalDest,
                 ButtonActions buttonActions = ButtonActions(ButtonAction_Press)
                     | ButtonAction_Release)
{
    if (buttonActions & ButtonAction_Press) {
        if (s_pauseBeforePress)
            QTest::qWait(DEBUGGING_PAUSE_DURATION);

        pressOn(pressGlobalPos, sourceWidget);
    }

    sourceWidget->activateWindow();

    if (s_pauseBeforeMove)
        QTest::qWait(DEBUGGING_PAUSE_DURATION);

    moveMouseTo(globalDest, sourceWidget);
    pressGlobalPos = sourceWidget->mapToGlobal(QPoint(10, 10));
    if (buttonActions & ButtonAction_Release)
        releaseOn(globalDest, sourceWidget);
}

inline void drag(View *sourceView, QPoint globalDest,
                 ButtonActions buttonActions = ButtonActions(ButtonAction_Press)
                     | ButtonAction_Release)
{
    Q_ASSERT(sourceView && sourceView->controller()->isVisible());

    View *draggable = draggableFor(sourceView);

    Q_ASSERT(draggable && draggable->controller()->isVisible());
    const QPoint pressGlobalPos = draggable->mapToGlobal(QPoint(15, 15));

    drag(draggable, pressGlobalPos, globalDest, buttonActions);
}

inline void dragFloatingWindowTo(Controllers::FloatingWindow *fw, QPoint globalDest,
                                 ButtonActions buttonActions = ButtonActions(ButtonAction_Press)
                                     | ButtonAction_Release)
{
    View *draggable = draggableFor(fw->view());
    Q_ASSERT(draggable);
    Q_ASSERT(draggable->controller()->isVisible());
    drag(draggable, draggable->mapToGlobal(QPoint(10, 10)), globalDest, buttonActions);
}

inline void dragFloatingWindowTo(Controllers::FloatingWindow *fw, Controllers::DropArea *target,
                                 DropLocation dropLocation)
{
    auto draggable = draggableFor(fw->view());
    Q_ASSERT(draggable);

    // First we drag over it, so the drop indicators appear:
    drag(draggable, draggable->mapToGlobal(QPoint(10, 10)),
         target->window()->mapToGlobal(target->window()->rect().center()), ButtonAction_Press);

    // Now we drag over the drop indicator and only then release mouse:
    Controllers::DropIndicatorOverlay *dropIndicatorOverlay = target->dropIndicatorOverlay();
    const QPoint dropPoint = dropIndicatorOverlay->posForIndicator(dropLocation);

    drag(draggable, QPoint(), dropPoint, ButtonAction_Release);
}

}

}

Q_DECLARE_METATYPE(KDDockWidgets::Tests::DockDescriptor)


#endif
