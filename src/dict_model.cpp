/*
  Copyright (C) 2015 Jolla Ltd.
  Contact: Jussi Pakkanen <jussi.pakkanen@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#include "dict_model.h"

DictModel::DictModel(QObject *parent) :
    QAbstractListModel(parent)
{
    d_msg = "";
    // Create dictionary.
    d_wordbook = dictcc::creator::create("DENL");
    // Initialise with shared pointer to empty lists, so it actually holds data.
    d_result = d_wordbook->get_translations();
}

int DictModel::rowCount(const QModelIndex &) const
{
    if(d_result == nullptr) {
        return 0;
    } else {
       return d_result->first.size();
    }
}

QHash<int, QByteArray> DictModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[Lang1Role] = "lang1";
    roles[Lang2Role] = "lang2";
    roles[Msg2Usr] = "msg2usr";
    return roles;
}


QVariant DictModel::data(const QModelIndex &index, int role) const {
    // TODO: Maybe have to check for if results is empty
    if(!index.isValid()) {
        return QVariant();
    }
    switch(role) {
     case Lang1Role:
        return QVariant(QString(d_result->first[index.row()].c_str()));
     case Lang2Role:
        return QVariant(QString(d_result->second[index.row()].c_str()));
    case Msg2Usr:
       return QVariant(d_msg);
    }
    return QVariant();
}

/*void DemoModel::activate(const int i) {
    if(i < 0 || i >= backing.size()) {
        return;
    }
    QString value = backing[i];

    // Remove the value from the old location.
    beginRemoveRows(QModelIndex(), i, i);
    backing.erase(backing.begin() + i);
    endRemoveRows();

    // Add it to the top.
    beginInsertRows(QModelIndex(), 0, 0);
    backing.insert(0, value);
    endInsertRows();
}*/

void DictModel::search(QString word)
{
    beginResetModel();
    // Perform search
    try {
        d_result = d_wordbook->search(word.toStdString());
        d_msg = nullptr;
    } catch (const dictcc::dict_exception& e) {
        d_result = d_wordbook->reset_search();
        d_msg = e.what();
    }
    endResetModel();
}

void DictModel::change_language(QString lang)
{
    d_wordbook.reset();
    d_wordbook = dictcc::creator::create(lang.toStdString());
}
