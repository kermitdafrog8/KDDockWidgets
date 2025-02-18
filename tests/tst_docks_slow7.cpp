/*
  This file is part of KDDockWidgets.

  SPDX-FileCopyrightText: 2019 Klarälvdalens Datakonsult AB, a KDAB Group company <info@kdab.com>
  Author: Sérgio Martins <sergio.martins@kdab.com>

  SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only

  Contact KDAB at <info@kdab.com> for commercial licensing options.
*/

#include "utils.h"
#include "Config.h"
#include "core/LayoutSaver_p.h"
#include "core/Position_p.h"
#include "core/WindowBeingDragged_p.h"
#include "core/layouting/Item_p.h"
#include "core/ViewFactory.h"
#include "core/DropArea.h"
#include "core/MainWindow.h"
#include "core/DockWidget.h"
#include "core/DockWidget_p.h"
#include "core/Separator.h"
#include "core/TabBar.h"
#include "core/Stack.h"
#include "core/SideBar.h"
#include "core/Platform.h"

#include <QtTest>

using namespace KDDockWidgets;
using namespace KDDockWidgets::Core;
using namespace KDDockWidgets::Tests;

class TestDocks : public QObject
{
    Q_OBJECT
private Q_SLOTS:
    void tst_dragByTabBar();
    void tst_negativeAnchorPosition();
    void tst_negativeAnchorPosition2();
    void tst_negativeAnchorPosition3();
    void tst_negativeAnchorPosition4();
    void tst_negativeAnchorPosition5();
    void tst_negativeAnchorPosition6();
    void tst_negativeAnchorPosition7();
    void tst_crash2();
    void tst_keepLast();
};

void TestDocks::tst_dragByTabBar()
{
    auto func = [](bool documentMode, bool tabsAlwaysVisible) {
        EnsureTopLevelsDeleted e;
        auto flags = KDDockWidgets::Config::self().flags()
            | KDDockWidgets::Config::Flag_HideTitleBarWhenTabsVisible;
        if (tabsAlwaysVisible)
            flags |= KDDockWidgets::Config::Flag_AlwaysShowTabs;

        KDDockWidgets::Config::self().setFlags(flags);

        auto m = createMainWindow();

        auto dropArea = m->dropArea();
        auto dock1 = createDockWidget(
            "dock1", Platform::instance()->tests_createView({ true, {}, Size(400, 400) }));

        auto dock2 = createDockWidget(
            "dock2", Platform::instance()->tests_createView({ true, {}, Size(400, 400) }));
        auto dock3 = createDockWidget(
            "dock3", Platform::instance()->tests_createView({ true, {}, Size(400, 400) }));
        m->addDockWidgetAsTab(dock1);
        m->view()->resize(Size(osWindowMinWidth(), 200));

        dock2->addDockWidgetAsTab(dock3);
        if (documentMode)
            dock2->dptr()->group()->stack()->setDocumentMode(true);

        auto fw = dock2->floatingWindow();
        fw->view()->move(m->pos() + Point(500, 500));
        QVERIFY(fw->isVisible());
        QVERIFY(!fw->titleBar()->isVisible());

        dragFloatingWindowTo(fw, dropArea, DropLocation_Right);
    };

    func(false, false);
    func(true, false);
    func(false, true);
    func(true, true);
}

void TestDocks::tst_negativeAnchorPosition()
{
    // Tests that we don't hit:
    // void KDDockWidgets::Anchor::setPosition(int, KDDockWidgets::Anchor::SetPositionOptions)
    // Negative position

    EnsureTopLevelsDeleted e;
    auto m = createMainWindow(Size(1002, 806));

    auto w1 = Platform::instance()->tests_createView({ true, {}, Size(104, 104) });
    w1->resize(994, 718);
    auto w2 = Platform::instance()->tests_createView({ true, {}, Size(133, 343) });
    w2->resize(392, 362);
    auto w3 = Platform::instance()->tests_createView({ true, {}, Size(133, 343) });
    w3->resize(392, 362);

    Core::DropArea *layout = m->multiSplitter();

    auto d1 = createDockWidget("1", w1);
    auto d2 = createDockWidget("2", w2);
    auto d3 = createDockWidget("3", w3);

    m->addDockWidgetAsTab(d1);

    m->addDockWidget(d2, Location_OnTop);
    m->addDockWidget(d3, Location_OnTop);

    d2->close();

    WAIT_FOR_RESIZE(d3->view());
    d2->open(); // Should not result in negative anchor positions (Test will fail due to a spdlog warning)
    WAIT_FOR_RESIZE(d3->view());
    layout->checkSanity();

    d2->close();
    WAIT_FOR_RESIZE(d3->view());
    layout->checkSanity();

    // Now resize the Window, after removing middle one
    const int availableToShrink =
        layout->layoutSize().height() - layout->view()->minSize().height();
    const Size newSize = { layout->layoutWidth(), layout->layoutHeight() - availableToShrink };

    QVERIFY(layout->layoutMinimumSize().expandedTo(newSize) == newSize);

    layout->setLayoutSize(newSize);

    d2->destroyLater();
    WAIT_FOR_DELETED(d2);
    layout->checkSanity();
}

void TestDocks::tst_negativeAnchorPosition2()
{
    // Tests that the "Out of bounds position" warning doesn't appear. Test will abort if yes.
    EnsureTopLevelsDeleted e;
    auto m = createMainWindow(Size(800, 500), MainWindowOption_None);
    auto dropArea = m->dropArea();
    Core::DropArea *layout = dropArea;

    auto dock1 = createDockWidget("1", Platform::instance()->tests_createView({ true }), {}, {},
                                  /*show=*/false);
    auto dock2 = createDockWidget("2", Platform::instance()->tests_createView({ true }), {}, {},
                                  /*show=*/false);
    auto dock3 = createDockWidget("3", Platform::instance()->tests_createView({ true }), {}, {},
                                  /*show=*/false);

    m->addDockWidget(dock1, Location_OnLeft);
    m->addDockWidget(dock2, Location_OnRight, nullptr, InitialVisibilityOption::StartHidden);
    m->addDockWidget(dock3, Location_OnRight);
    QCOMPARE(layout->placeholderCount(), 1);
    QCOMPARE(layout->count(), 3);

    dock1->setFloating(true);
    dock1->setFloating(false);
    dock2->destroyLater();
    layout->checkSanity();
    QVERIFY(Platform::instance()->tests_waitForDeleted(dock2));
}

void TestDocks::tst_negativeAnchorPosition3()
{
    // 1. Another case, when floating a dock:
    EnsureTopLevelsDeleted e;
    std::vector<DockDescriptor> docks = {
        { Location_OnLeft, -1, nullptr, InitialVisibilityOption::StartVisible },
        { Location_OnRight, -1, nullptr, InitialVisibilityOption::StartVisible },
        { Location_OnLeft, -1, nullptr, InitialVisibilityOption::StartVisible },
        { Location_OnBottom, -1, nullptr, InitialVisibilityOption::StartHidden },
        { Location_OnRight, -1, nullptr, InitialVisibilityOption::StartVisible }
    };
    auto m = createMainWindow(docks);
    auto dropArea = m->dropArea();
    Core::DropArea *layout = dropArea;
    layout->checkSanity();

    auto dock1 = docks.at(1).createdDock;
    auto dock3 = docks.at(3).createdDock;

    dock1->setFloating(true);
    layout->checkSanity();
}

void TestDocks::tst_negativeAnchorPosition4()
{
    // 1. Tests that we don't get a warning
    // Out of bounds position= -5 ; oldPosition= 0 KDDockWidgets::Anchor(0x55e726be9090, name =
    // "left") KDDockWidgets::MainWindow(0x55e726beb8d0)
    EnsureTopLevelsDeleted e;
    std::vector<DockDescriptor> docks = {
        { Location_OnLeft, -1, nullptr, InitialVisibilityOption::StartHidden },
        { Location_OnTop, -1, nullptr, InitialVisibilityOption::StartVisible },
        { Location_OnRight, -1, nullptr, InitialVisibilityOption::StartVisible },
        { Location_OnLeft, -1, nullptr, InitialVisibilityOption::StartVisible },
        { Location_OnRight, -1, nullptr, InitialVisibilityOption::StartVisible }
    };

    auto m = createMainWindow(docks);
    auto dropArea = m->dropArea();
    Core::DropArea *layout = dropArea;
    layout->checkSanity();

    auto dock1 = docks.at(1).createdDock;
    auto dock2 = docks.at(2).createdDock;
    dock2->setFloating(true);
    auto fw2 = dock2->floatingWindow();
    dropArea->addWidget(fw2->dropArea()->view(), Location_OnLeft, dock1->dptr()->group()->layoutItem());
    dock2->setFloating(true);
    fw2 = dock2->floatingWindow();

    dropArea->addWidget(fw2->dropArea()->view(), Location_OnRight, dock1->dptr()->group()->layoutItem());

    layout->checkSanity();
    docks.at(0).createdDock->destroyLater();
    docks.at(4).createdDock->destroyLater();
    WAIT_FOR_DELETED(docks.at(4).createdDock);
}

void TestDocks::tst_negativeAnchorPosition5()
{
    EnsureTopLevelsDeleted e;
    std::vector<DockDescriptor> docks = {
        { Location_OnBottom, -1, nullptr, InitialVisibilityOption::StartHidden },
        { Location_OnBottom, -1, nullptr, InitialVisibilityOption::StartHidden },
        { Location_OnBottom, -1, nullptr, InitialVisibilityOption::StartHidden },
    };

    auto m = createMainWindow(docks);
    auto dropArea = m->dropArea();
    Core::DropArea *layout = dropArea;
    layout->checkSanity();

    auto dock0 = docks.at(0).createdDock;
    auto dock1 = docks.at(1).createdDock;

    dock1->open();
    QVERIFY(layout->checkSanity());
    dock0->open();
    QVERIFY(layout->checkSanity());

    // Cleanup
    for (auto dock : DockRegistry::self()->dockwidgets())
        dock->destroyLater();

    QVERIFY(Platform::instance()->tests_waitForDeleted(dock0));
}

void TestDocks::tst_negativeAnchorPosition6()
{
    // Tests a case when we add a widget to left/right but the layout doesn't have enough height (or
    // vice-versa)
    EnsureTopLevelsDeleted e;

    auto m = createMainWindow(Size(501, 500), MainWindowOption_None);
    m->view()->resize(Size(100, 100));
    m->show();

    auto layout = m->multiSplitter();

    auto w1 = Platform::instance()->tests_createView({ true, {}, Size(400, 100) });
    auto w2 = Platform::instance()->tests_createView({ true, {}, Size(400, 100) });
    auto w3 = Platform::instance()->tests_createView({ true, {}, Size(400, 100) });
    auto w4 = Platform::instance()->tests_createView({ true, {}, Size(400, 900) });

    auto d1 = createDockWidget("1", w1);
    auto d2 = createDockWidget("2", w2);
    auto d3 = createDockWidget("3", w3);
    auto d4 = createDockWidget("4", w4);

    m->addDockWidget(d1, Location_OnBottom);
    m->addDockWidget(d2, Location_OnBottom);
    m->addDockWidget(d3, Location_OnBottom);

    QCOMPARE(layout->count(), 3);
    QCOMPARE(layout->placeholderCount(), 0);

    m->addDockWidget(d4, Location_OnRight, d3);

    layout->checkSanity();

    Item *centralItem = m->dropArea()->centralFrame();
    layout->rectForDrop(nullptr, Location_OnTop, centralItem);
    layout->checkSanity();
}

void TestDocks::tst_negativeAnchorPosition7()
{
    EnsureTopLevelsDeleted e;
    auto m = createMainWindow(Size(501, 500), MainWindowOption_None);
    m->show();
    auto w1 = Platform::instance()->tests_createView({ true, {}, Size(400, 400) });
    auto w2 = Platform::instance()->tests_createView({ true, {}, Size(400, 400) });

    auto d1 = newDockWidget("1");
    d1->setGuestView(w1->asWrapper());
    auto d2 = newDockWidget("2");
    d2->setGuestView(w2->asWrapper());

    auto w3 = Platform::instance()->tests_createView({ true, {}, Size(100, 100) });
    auto d3 = newDockWidget("3");
    d3->setGuestView(w3->asWrapper());

    // Stack 1, 2
    m->addDockWidget(d2, Location_OnTop);
    m->addDockWidget(d1, Location_OnTop);

    // add a small one to the middle

    // Stack: 1, 3, 2
    m->addDockWidget(d3, Location_OnTop, d2);
    m->layout()->checkSanity();
}

void TestDocks::tst_crash2()
{
    auto func = [](bool show) {
        {
            EnsureTopLevelsDeleted e;
            auto m = createMainWindow(Size(501, 500), MainWindowOption_None);
            auto layout = m->multiSplitter();
            m->setVisible(show);

            Core::DockWidget::List docks;
            const int num = 4;
            for (int i = 0; i < num; ++i)
                docks.push_back(newDockWidget(QString::number(i)));

            std::vector<KDDockWidgets::Location> locations = { Location_OnLeft, Location_OnRight,
                                                               Location_OnRight, Location_OnRight };

            std::vector<KDDockWidgets::InitialVisibilityOption> options = {
                InitialVisibilityOption::StartHidden, InitialVisibilityOption::StartHidden,
                InitialVisibilityOption::StartVisible, InitialVisibilityOption::StartHidden
            };

            std::vector<bool> floatings = { true, false, false, false };

            for (int i = 0; i < num; ++i) {

                m->addDockWidget(docks[i], locations[i], nullptr, options[i]);
                layout->checkSanity();
                docks[i]->setFloating(floatings[i]);
            }

            qDeleteAll(docks);
            qDeleteAll(DockRegistry::self()->groups());
        }

        {
            EnsureTopLevelsDeleted e;
            auto m = createMainWindow(Size(501, 500), MainWindowOption_None);
            auto layout = m->multiSplitter();
            m->show();

            const int num = 3;
            Core::DockWidget::List docks;
            for (int i = 0; i < num; ++i)
                docks.push_back(newDockWidget(QString::number(i)));

            std::vector<KDDockWidgets::Location> locations = { Location_OnLeft, Location_OnLeft,
                                                               Location_OnRight };

            std::vector<KDDockWidgets::InitialVisibilityOption> options = {
                InitialVisibilityOption::StartVisible, InitialVisibilityOption::StartVisible,
                InitialVisibilityOption::StartHidden
            };

            std::vector<bool> floatings = { true, false, false };

            for (int i = 0; i < num; ++i) {
                m->addDockWidget(docks[i], locations[i], nullptr, options[i]);
                layout->checkSanity();
                if (i == 2) {
                    // Wait for the resizes. This used to make the app crash.
                    QTest::qWait(1000);
                }

                docks[i]->setFloating(floatings[i]);
            }
            layout->checkSanity();

            qDeleteAll(docks);
            qDeleteAll(DockRegistry::self()->groups());
        }
    };

    func(true);
    func(false);
}

void TestDocks::tst_keepLast()
{
    // 1 event loop for DelayedDelete. Avoids LSAN warnings.
    QTest::qWait(1);
}

#define KDDW_TEST_NAME TestDocks
#include "test_main_qt.h"

#include "tst_docks_slow7.moc"
