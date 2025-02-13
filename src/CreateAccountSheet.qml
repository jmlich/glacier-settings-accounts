/*
 * Copyright (C) 2013 Robin Burchell <robin+mer@viroteck.net>
 * Copyright (C) 2022 Chupligin Sergey (NeoChapay) <neochapay@gmail.com>
 *
 * You may use this file under the terms of the BSD license as follows:
 *
 * "Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *   * Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *   * Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in
 *     the documentation and/or other materials provided with the
 *     distribution.
 *   * Neither the name of Nemo Mobile nor the names of its contributors
 *     may be used to endorse or promote products derived from this
 *     software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
 */

import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Nemo 1.0
import QtQuick.Controls.Styles.Nemo 1.0

import org.nemomobile.accounts 1.0

import "accounts.js" as ACC

Page {
    id: sheet

    headerTools: HeaderToolsLayout {
        title: qsTr("Accounts")
        showBackButton: true
    }

    property AccountModel accountModel
    property variant provider: accountModel.provider(selectedProvider)
    property string selectedProvider

    // Stage one: pick a provider
    ListView {
        anchors.fill: parent
        anchors.margins: Theme.itemSpacingMedium
        model: AccountProviderModel { }
        delegate: ListViewItemWithActions {
            icon : ACC.formatIcon(model.providerIcon)
            label: model.providerDisplayName
            onClicked: {
                sheet.selectedProvider = model.providerName
                var componentFileName = "file:///usr/share/glacier-settings/plugins/accounts/providers/" + provider.name + "/"  + provider.name + ".qml"

                pageStack.push(Qt.resolvedUrl(componentFileName),
                               { accountModel: accountModel, provider: provider })

            }
        }
    }


}
