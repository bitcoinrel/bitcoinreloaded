// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef BITCOINRELOADED_QT_BITCOINRELOADEDADDRESSVALIDATOR_H
#define BITCOINRELOADED_QT_BITCOINRELOADEDADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class BitcoinReloadedAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BitcoinReloadedAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

/** BitcoinReloaded address widget validator, checks for a valid bitcoinreloaded address.
 */
class BitcoinReloadedAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BitcoinReloadedAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const override;
};

#endif // BITCOINRELOADED_QT_BITCOINRELOADEDADDRESSVALIDATOR_H
