/*
 * Copyright (C) 2017 Chupligin Sergey <neochapay@gmail.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public License
 * along with this library; see the file COPYING.LIB.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */
#ifndef SETTINGSPROXYMODEL_H
#define SETTINGSPROXYMODEL_H

#include <QObject>
#include <QSortFilterProxyModel>

#include "settingsmodel.h"

class SettingsProxyModel : public QSortFilterProxyModel
{
    Q_OBJECT
    Q_PROPERTY(QObject* model READ model WRITE setModel NOTIFY modelChanged)
public:
    explicit SettingsProxyModel(QObject *parent = 0);
    QObject* model();
    void setModel(QObject* model);

signals:
    void modelChanged();

private:

protected:
    bool lessThan(const QModelIndex &left, const QModelIndex &right) const;
};

#endif // SETTINGSPROXYMODEL_H
