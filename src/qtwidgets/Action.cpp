/*
  This file is part of KDDockWidgets.

  SPDX-FileCopyrightText: 2020-2023 Klarälvdalens Datakonsult AB, a KDAB Group company <info@kdab.com>
  Author: Sérgio Martins <sergio.martins@kdab.com>

  SPDX-License-Identifier: GPL-2.0-only OR GPL-3.0-only

  Contact KDAB at <info@kdab.com> for commercial licensing options.
*/


#include "Action.h"
#include "core/Action_p.h"
#include "core/Logging_p.h"

using namespace KDDockWidgets::QtWidgets;

Action::Action(Core::DockWidget *dw, const char *debugName)
    : KDDockWidgets::Action(dw, debugName)
{
}

Action::~Action() = default;

void Action::setCheckable(bool is)
{
    QAction::setCheckable(is);
}

bool Action::isCheckable() const
{
    return QAction::isCheckable();
}

void Action::setIcon(const KDDockWidgets::Icon &icon)
{
    QAction::setIcon(icon);
}

KDDockWidgets::Icon Action::icon() const
{
    return QAction::icon();
}

void Action::setText(const QString &text)
{
    QAction::setText(text);
}

void Action::setToolTip(const QString &text)
{
    QAction::setToolTip(text);
}

QString Action::toolTip() const
{
    return QAction::toolTip();
}

void Action::setEnabled(bool enabled)
{
    return QAction::setEnabled(enabled);
}

bool Action::isEnabled() const
{
    return QAction::isEnabled();
}

bool Action::isChecked() const
{
    return QAction::isChecked();
}

void Action::setChecked(bool checked)
{
    const bool wasChecked = isChecked();
    QAction::setChecked(checked);
    if (wasChecked != checked) {
        KDDW_TRACE("({}) KDDockWidgets::Action::setChecked({}) ; dw={}", d->debugName, checked, ( void * )d->dockWidget);
        d->toggled.emit(checked);
    } else {
        KDDW_TRACE("({}) KDDockWidgets::Action::setChecked({}) ; ignored,  dw={}", d->debugName, checked, ( void * )d->dockWidget);
    }
}

bool Action::blockSignals(bool b)
{
    return QAction::blockSignals(b);
}

void Action::trigger()
{
    QAction::trigger();
    d->toggled.emit(isChecked());
}
