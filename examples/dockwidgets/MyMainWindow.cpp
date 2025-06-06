/*
  This file is part of KDDockWidgets.

  SPDX-FileCopyrightText: 2019 Klarälvdalens Datakonsult AB, a KDAB Group company <info@kdab.com>
  Author: Sérgio Martins <sergio.martins@kdab.com>

  SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only

  Contact KDAB at <info@kdab.com> for commercial licensing options.
*/

#include "MyMainWindow.h"
#include "MyWidget.h"
#include "CtrlKeyEventFilter.h"

#include <kddockwidgets/Config.h>
#include <kddockwidgets/LayoutSaver.h>

#include <kddockwidgets/core/DockWidget.h>
#include <kddockwidgets/core/MainWindow.h>
#include <kddockwidgets/core/Layout.h>

#include <QMenu>
#include <QMenuBar>
#include <QEvent>
#include <QDebug>
#include <QString>
#include <QTextEdit>
#include <QWindow>
#include <QPushButton>
#include <QVBoxLayout>
#include <QRandomGenerator>

#include <QApplication>

#include <utility>

// clazy:excludeall=qstring-allocations,ctor-missing-parent-argument,detaching-member

static MyWidget *newMyWidget()
{
    const int randomNumber = QRandomGenerator::global()->bounded(0, 100) + 1;
    if (randomNumber < 50) {
        if (randomNumber < 33) {
            return new MyWidget1();
        } else {
            return new MyWidget3();
        }
    } else {
        return new MyWidget2();
    }
}

MyMainWindow::MyMainWindow(const QString &uniqueName, KDDockWidgets::MainWindowOptions options,
                           ExampleOptions exampleOptions,
                           const QString &affinityName, QWidget *parent)
    : KDDockWidgets::QtWidgets::MainWindow(uniqueName, options, parent)
    , m_exampleOptions(exampleOptions)
{
    auto menubar = menuBar();
    auto fileMenu = new QMenu(QStringLiteral("File"), this);
    m_toggleMenu = new QMenu(QStringLiteral("Toggle"), this);
    auto miscMenu = new QMenu(QStringLiteral("Misc"), this);

    menubar->addMenu(fileMenu);
    menubar->addMenu(m_toggleMenu);
    menubar->addMenu(miscMenu);

    QAction *newAction = fileMenu->addAction(QStringLiteral("New DockWidget"));

    connect(newAction, &QAction::triggered, this, [] {
        static int count = 0;
        count++;
        auto w = newMyWidget();
        w->setGeometry(100, 100, 400, 400);
        auto dock = new KDDockWidgets::QtWidgets::DockWidget(
            QStringLiteral("new dock %1").arg(count));
        dock->setWidget(w);
        dock->resize(QSize(600, 600));
        dock->open();
    });

    auto saveLayoutAction = fileMenu->addAction(QStringLiteral("Save Layout"));
    connect(saveLayoutAction, &QAction::triggered, this, [] {
        KDDockWidgets::LayoutSaver saver;
        const bool result = saver.saveToFile(QStringLiteral("mylayout.json"));
        qDebug() << "Saving layout to disk. Result=" << result;
    });

    auto restoreLayoutAction = fileMenu->addAction(QStringLiteral("Restore Layout"));
    connect(restoreLayoutAction, &QAction::triggered, this, [this] {
        KDDockWidgets::RestoreOptions options = KDDockWidgets::RestoreOption_None;
        if (m_exampleOptions & ExampleOption::RestoreIsRelative)
            options |= KDDockWidgets::RestoreOption_RelativeToMainWindow;

        KDDockWidgets::LayoutSaver saver(options);
        saver.restoreFromFile(QStringLiteral("mylayout.json"));
    });

    auto closeAllAction = fileMenu->addAction(QStringLiteral("Close All"));
    connect(closeAllAction, &QAction::triggered, this, [this] {
        for (auto dw : std::as_const(m_dockwidgets))
            dw->close();
    });

    auto layoutEqually = fileMenu->addAction(QStringLiteral("Layout Equally"));
    connect(layoutEqually, &QAction::triggered, this, [this] { this->layoutEqually(); });

    auto quitAction = fileMenu->addAction(QStringLiteral("Quit"));
    connect(quitAction, &QAction::triggered, qApp, &QApplication::quit);

    QAction *toggleDropIndicatorSupport =
        miscMenu->addAction(QStringLiteral("Toggle Drop Indicator Support"));
    toggleDropIndicatorSupport->setCheckable(true);
    toggleDropIndicatorSupport->setChecked(true);
    connect(toggleDropIndicatorSupport, &QAction::toggled, this, [](bool checked) {
        KDDockWidgets::Config::self().setDropIndicatorsInhibited(!checked);
    });

    // for debug purposes only:
    QAction *dumpLayout =
        miscMenu->addAction(QStringLiteral("Dump layout to terminal"));
    connect(dumpLayout, &QAction::triggered, this, [this] {
        mainWindow()->layout()->dumpLayout();
    });

    setAffinities({ affinityName });
    createDockWidgets();

    if (options & KDDockWidgets::MainWindowOption_HasCentralWidget) {
        setPersistentCentralWidget(new MyWidget1());
    }

    if (m_exampleOptions & ExampleOption::CtrlKeyFiltersDropIndicators) {
        /// Drop indicators will only be visible when ctrl is pressed
        KDDockWidgets::Config::self().setDropIndicatorsInhibited(true);
        qGuiApp->installEventFilter(new CtrlKeyEventFilter(this));
    }
}

MyMainWindow::~MyMainWindow()
{
    qDeleteAll(m_dockwidgets);
}

void MyMainWindow::createDockWidgets()
{
    Q_ASSERT(m_dockwidgets.isEmpty());

    const int numDockWidgets = (m_exampleOptions & ExampleOption::NonDockableDockWidget9) ? 10 : 9;

    // Create 9 KDDockWidget::DockWidget and the respective widgets they're hosting (MyWidget
    // instances)
    for (int i = 0; i < numDockWidgets; i++)
        m_dockwidgets << newDockWidget();

    // MainWindow::addDockWidget() attaches a dock widget to the main window:
    addDockWidget(m_dockwidgets.at(0), KDDockWidgets::Location_OnTop);

    // Here, for finer granularity we specify right of dockwidgets[0]:
    addDockWidget(m_dockwidgets.at(1), KDDockWidgets::Location_OnRight, m_dockwidgets.at(0));

    addDockWidget(m_dockwidgets.at(2), KDDockWidgets::Location_OnLeft);
    addDockWidget(m_dockwidgets.at(3), KDDockWidgets::Location_OnBottom);
    addDockWidget(m_dockwidgets.at(4), KDDockWidgets::Location_OnBottom);

    // Tab two dock widgets together
    m_dockwidgets[3]->addDockWidgetAsTab(m_dockwidgets.at(5));

    // 6 is floating, as it wasn't added to the main window via MainWindow::addDockWidget().
    // and we tab 7 with it.
    m_dockwidgets[6]->addDockWidgetAsTab(m_dockwidgets.at(7));

    // Floating windows also support nesting, here we add 8 to the bottom of the group
    m_dockwidgets[6]->addDockWidgetToContainingWindow(m_dockwidgets.at(8),
                                                      KDDockWidgets::Location_OnBottom);

    auto floatingWindow = m_dockwidgets.at(6)->rootView();
    floatingWindow->move(100, 100);
}

KDDockWidgets::QtWidgets::DockWidget *MyMainWindow::newDockWidget()
{
    static int count = 0;

    // Passing options is optional, we just want to illustrate Option_NotClosable here
    KDDockWidgets::DockWidgetOptions options = KDDockWidgets::DockWidgetOption_None;
    KDDockWidgets::LayoutSaverOptions layoutSaverOptions = KDDockWidgets::LayoutSaverOption::None;

    if (count == 0 && (m_exampleOptions & ExampleOption::DockWidget0IsNonClosable))
        options |= KDDockWidgets::DockWidgetOption_NotClosable;

    if (count == 9 && (m_exampleOptions & ExampleOption::NonDockableDockWidget9))
        options |= KDDockWidgets::DockWidgetOption_NotDockable;

    if ((count == 6 || count == 7 || count == 8) && (m_exampleOptions & ExampleOption::DockWidgets678DontCloseBeforeRestore))
        layoutSaverOptions |= KDDockWidgets::LayoutSaverOption::Skip;

    auto dock = new KDDockWidgets::QtWidgets::DockWidget(
        QStringLiteral("DockWidget #%1").arg(count), options, layoutSaverOptions);
    dock->setAffinities(affinities()); // optional, just to show the feature. Pass -mi to the
                                       // example to see incompatible dock widgets

    if (count == 1)
        dock->setIcon(QIcon::fromTheme(QStringLiteral("mail-message")));

    auto myWidget = newMyWidget();
    if (count == 8) {
        if (m_exampleOptions & ExampleOption::MaxSizeForDockWidget8) {
            // Set a maximum size on dock #8
            myWidget->setMaximumSize(200, 200);
            auto button = new QPushButton("dump debug info", myWidget);
            connect(button, &QPushButton::clicked, this, [myWidget] {
                KDDockWidgets::Config::self().printDebug();

                qDebug() << "Widget: " << myWidget->geometry() << myWidget->minimumSize() << myWidget->minimumSizeHint() << myWidget->maximumSize() << myWidget->sizeHint() << myWidget->window();

                auto tlw = myWidget->window();
                qDebug() << "TLW   : " << tlw << tlw->geometry() << tlw->minimumSize() << tlw->minimumSizeHint() << tlw->maximumSize() << tlw->sizeHint();

                auto window = tlw->windowHandle();
                qDebug() << "Window   : " << window << window->frameGeometry() << window->geometry() << window->minimumSize() << window->maximumSize() << window->frameGeometry() << window->flags();
            });
        }
    }

    if (count == 5 && (m_exampleOptions & ExampleOption::ProgrammaticDragEvent)) {
        qDeleteAll(myWidget->children());

        auto button = new QPushButton("Start Drag (by tab)", myWidget);
        connect(button, &QPushButton::pressed, this, [dock] {
            dock->asDockWidgetController()->startDragging(true);
        });

        auto button2 = new QPushButton("Start Drag (by titlebar)", myWidget);
        connect(button2, &QPushButton::pressed, this, [dock] {
            dock->asDockWidgetController()->startDragging(false);
        });

        auto vbox = new QVBoxLayout(myWidget);
        vbox->addWidget(button);
        vbox->addWidget(button2);
        vbox->addStretch();
    }

    if (count == 0 && (m_exampleOptions & ExampleOption::Dock0BlocksCloseEvent))
        myWidget->blockCloseEvent();

    dock->setWidget(myWidget);

    if (dock->options() & KDDockWidgets::DockWidgetOption_NotDockable) {
        dock->setTitle(QStringLiteral("DockWidget #%1 (%2)").arg(count).arg("non dockable"));
    } else {
        dock->setTitle(QStringLiteral("DockWidget #%1").arg(count));
    }

    dock->resize(QSize(600, 600));
    m_toggleMenu->addAction(dock->toggleAction());
    dock->toggleAction()->setShortcut(QStringLiteral("ctrl+%1").arg(count));

    count++;
    return dock;
}

CtrlKeyEventFilter::~CtrlKeyEventFilter() = default;
