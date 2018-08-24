/*
 * Copyright (c) 2018 Alex Spataru <https://github.com/alex-spataru>
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#ifndef RESISTANCE_INFO_H
#define RESISTANCE_INFO_H

#include <math.h>

#include <QtQml>
#include <QList>
#include <QObject>
#include <QStringList>

class ResistanceInfo : public QObject
{
    Q_OBJECT

#ifdef QT_QML_LIB
    Q_PROPERTY (Tempco tempco
                READ tempco
                WRITE setTempco
                NOTIFY tempcoChanged)
    Q_PROPERTY (QString tempcoStr
                READ tempcoStr
                NOTIFY tempcoChanged)
    Q_PROPERTY (Tolerance tolerance
                READ tolerance
                WRITE setTolerance
                NOTIFY toleranceChanged)
    Q_PROPERTY (Multiplier multiplier
                READ multiplier
                WRITE setMultiplier
                NOTIFY multiplierChanged)
    Q_PROPERTY (ResistorType resistorType
                READ resistorType
                WRITE setResistorType
                NOTIFY resistorTypeChanged)
    Q_PROPERTY (Digit digitA
                READ digitA
                WRITE setDigitA
                NOTIFY digitsChanged)
    Q_PROPERTY (Digit digitB
                READ digitB
                WRITE setDigitB
                NOTIFY digitsChanged)
    Q_PROPERTY (Digit digitC
                READ digitC
                WRITE setDigitC
                NOTIFY digitsChanged)
    Q_PROPERTY (QString smdResistanceCode
                READ smdResistanceCode
                WRITE setSmdResistanceCode
                NOTIFY smdResistanceCodeChanged)
    Q_PROPERTY (QString resistance
                READ resistanceStr
                NOTIFY resistanceCalculated)
    Q_PROPERTY (QString minimumResistance
                READ minResistanceStr
                NOTIFY resistanceCalculated)
    Q_PROPERTY (QString maximumResistance
                READ maxResistanceStr
                NOTIFY resistanceCalculated)
    Q_PROPERTY (QString smdResistance
                READ smdResistanceStr
                NOTIFY smdResistanceCalculated)
    Q_PROPERTY (int smdTolerance
                READ smdTolerance
                NOTIFY smdToleranceChanged)
    Q_PROPERTY (QStringList resistanceStripColors
                READ resistanceStripColors
                NOTIFY resistanceCalculated)
    Q_PROPERTY (QStringList digitNames
                READ digitNames
                CONSTANT)
    Q_PROPERTY (QStringList firstDigitNames
                READ firstDigitNames
                CONSTANT)
    Q_PROPERTY (QStringList tempcoNames
                READ tempcoNames
                CONSTANT)
    Q_PROPERTY (QStringList toleranceNames
                READ toleranceNames
                CONSTANT)
    Q_PROPERTY (QStringList multiplierNames
                READ multiplierNames
                CONSTANT)
    Q_PROPERTY (QStringList digitColors
                READ digitColors
                CONSTANT)
    Q_PROPERTY (QStringList tempcoColors
                READ tempcoColors
                CONSTANT)
    Q_PROPERTY (QStringList toleranceColors
                READ toleranceColors
                CONSTANT)
    Q_PROPERTY (QStringList multiplierColors
                READ multiplierColors
                CONSTANT)
#endif

signals:
    void tempcoChanged();
    void digitsChanged();
    void toleranceChanged();
    void multiplierChanged();
    void smdToleranceChanged();
    void resistanceCalculated();
    void resistorTypeChanged();
    void smdResistanceCalculated();
    void smdResistanceCodeChanged();

public:
    enum ResistorType {
        FourStripResistor = 0,
        FiveStripResistor = 1,
        SixStripResistor  = 2
    };
    Q_ENUMS (ResistorType)

    enum Digit {
        DigitBlack  = 0,
        DigitBrown  = 1,
        DigitRed    = 2,
        DigitOrange = 3,
        DigitYellow = 4,
        DigitGreen  = 5,
        DigitBlue   = 6,
        DigitViolet = 7,
        DigitGray   = 8,
        DigitWhite  = 9
    };
    Q_ENUMS (Digit)

    enum Tempco {
        TempcoBrown  = 0,
        TempcoRed    = 1,
        TempcoOrange = 2,
        TempcoYellow = 3,
        TempcoBlue   = 4,
        TempcoViolet = 5
    };
    Q_ENUMS (Tempco)

    enum Multiplier {
        MultiplierBlack  = 0,
        MultiplierBrown  = 1,
        MultiplierRed    = 2,
        MultiplierOrange = 3,
        MultiplierYellow = 4,
        MultiplierGreen  = 5,
        MultiplierBlue   = 6,
        MultiplierViolet = 7,
        MultiplierGray   = 8,
        MultiplierWhite  = 9,
        MultiplierGold   = 10,
        MultiplierSilver = 11
    };
    Q_ENUMS (Multiplier)

    enum Tolerance {
        ToleranceBrown  = 0,
        ToleranceRed    = 1,
        ToleranceGreen  = 2,
        ToleranceBlue   = 3,
        ToleranceViolet = 4,
        ToleranceGray   = 5,
        ToleranceGold   = 6,
        ToleranceSilver = 7
    };
    Q_ENUMS (Tolerance)

public:
    ResistanceInfo (QObject* parent = 0);
    
    static void DeclareQml()
    {
#ifdef QT_QML_LIB
        qmlRegisterType<ResistanceInfo> ("ResistanceInfo", 1, 0, "RI");
#endif
    }

    QString resistanceStr() const;
    QString minResistanceStr() const;
    QString maxResistanceStr() const;
    QString smdResistanceStr() const;

    QString smdResistanceCode() const;
    QStringList resistanceStripColors() const;

    QStringList digitNames() const;
    QStringList tempcoNames() const;
    QStringList toleranceNames() const;
    QStringList multiplierNames() const;

    QStringList digitColors() const;
    QStringList tempcoColors() const;
    QStringList toleranceColors() const;
    QStringList multiplierColors() const;

    int smdTolerance() const;
    double resistance() const;
    double minResistance() const;
    double maxResistance() const;
    double smdResistance() const;

    static int getDigitValue (const Digit digit);
    static int getTempcoValue (const Tempco tempco);
    static double getToleranceValue (const Tolerance tolerance);
    static double getMultiplierValue (const Multiplier multiplier);

    inline QStringList firstDigitNames() const {
        QStringList list = digitNames();
        list.removeFirst();
        return list;
    }

    inline QString tempcoStr() const {
        return QString ("%1 PPM/°C").arg (getTempcoValue (tempco()));
    }

    inline Digit digitA() const {
        return digits().at (0);
    }

    inline Digit digitB() const {
        return digits().at (1);
    }

    inline Digit digitC() const {
        return digits().at (2);
    }

    Tempco tempco() const;
    QList<Digit> digits() const;
    Tolerance tolerance() const;
    Multiplier multiplier() const;
    ResistorType resistorType() const;

public slots:
    void setDigitA (const Digit digit);
    void setDigitB (const Digit digit);
    void setDigitC (const Digit digit);
    void setTempco (const Tempco tempco);
    void setTolerance (const Tolerance tolerance);
    void setSmdResistanceCode (const QString& code);
    void setMultiplier (const Multiplier multiplier);
    void setResistorType (const ResistorType type);
    void setDigit (const int number, const Digit digit);

private slots:
    void calculateResistance();
    void calculateSmdResistance();

private:
    QString prefixStr (const int exponent) const;
    void setSmdTolerance (const int tolerance);
    void setResistance (const double resistance);
    void setSmdResistance (const double resistance);
    int scientificExp (const double resistance) const;
    QString getResistanceStr (const double resistance) const;

private:
    double m_resistance;
    double m_minResistance;
    double m_maxResistance;
    double m_smdResistance;

    int m_smdTolerance;

    Tempco m_tempco;
    QList<Digit> m_digits;
    Tolerance m_tolerance;
    Multiplier m_multiplier;
    ResistorType m_resistorType;

    QString m_smdResistanceCode;
};

#endif
