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

#include "ResistanceInfo.h"

/**
 * Used when the user inputs an invalid SMD code. 
 * This helps us to return "Unknown" resistance to the user instead
 * of showing 'Nan' or another cryptic message to the user
 */ 
static const int UNKNOWN_RESISTANCE = -1;

ResistanceInfo::ResistanceInfo (QObject *parent) : QObject (parent) {
    // Set default values
    setTempco (TempcoBrown);
    setDigit (0, DigitOrange);
    setDigit (1, DigitOrange);
    setDigit (2, DigitOrange);
    setSmdResistanceCode ("102");
    setTolerance (ToleranceGold);
    setMultiplier (MultiplierBrown);
    setResistorType (FourStripResistor);

    // Connect signals/slots for future events
    connect (this, SIGNAL (digitsChanged()),
             this,   SLOT (calculateResistance()));
    connect (this, SIGNAL (tempcoChanged()),
             this,   SLOT (calculateResistance()));
    connect (this, SIGNAL (multiplierChanged()),
             this,   SLOT (calculateResistance()));
    connect (this, SIGNAL (toleranceChanged()),
             this,   SLOT (calculateResistance()));
    connect (this, SIGNAL (resistorTypeChanged()),
             this,   SLOT (calculateResistance()));
    connect (this, SIGNAL (smdResistanceCodeChanged()),
             this,   SLOT (calculateSmdResistance()));

    // Calculate resistances (to force re-draw of UI items)
    calculateResistance();
    calculateSmdResistance();
}

/**
 * @returns A nicely formatted string with the current
 *          resistance and tolerance values
 */
QString ResistanceInfo::resistanceStr() const {
    QString str = getResistanceStr (resistance());

    if (resistance() != UNKNOWN_RESISTANCE) {
        str += " ± ";
        str += QString::number (getToleranceValue (tolerance()) * 100);
        str += "%";
    }

    return str;
}

/**
 * @returns A nicely formatted string with the current
 *          minimum resistance value
 */
QString ResistanceInfo::minResistanceStr() const {
    return getResistanceStr (minResistance());
}

/**
 * @returns A nicely formatted string with the current
 *          maximum resistance value
 */
QString ResistanceInfo::maxResistanceStr() const {
    return getResistanceStr (maxResistance());
}

/**
 * @returns A nicely formatted string with the current
 *          SMD resistance value
 */
QString ResistanceInfo::smdResistanceStr() const {
    QString smd = getResistanceStr (smdResistance());

    if (smdResistance() != UNKNOWN_RESISTANCE) {
        smd += " ± ";
        smd += QString::number (smdTolerance());
        smd += "%";
    }

    return smd;
}

/**
 * @returns The current SMD resistance code
 */
QString ResistanceInfo::smdResistanceCode() const {
    return m_smdResistanceCode;
}

/**
 * @returns An ordered list with the strip colors that match
 *          the current resistance value and characteristics
 */
QStringList ResistanceInfo::resistanceStripColors() const {
    QStringList list;

    // Add first two digits
    list.append (digitColors().at ((int) digits().at (0)));
    list.append (digitColors().at ((int) digits().at (1)));

    // Add third digit if resistance is 5-strip or 6-strip
    if (resistorType() != FourStripResistor)
        list.append (digitColors().at ((int) digits().at (2)));
    else
        list.append ("transparent");

    // Add multiplier and tolerance strips
    list.append (multiplierColors().at ((int) multiplier()));
    list.append (toleranceColors().at ((int) tolerance()));

    // Add tempco strip
    if (resistorType() == SixStripResistor)
        list.append (tempcoColors().at ((int) tempco()));
    else
        list.append ("transparent");

    return list;
}

/**
 * @returns An ordered list with the color names for each possible digit.
 *
 * @note The list has the same order as the enums of
 *       this class, so that the index number of each element
 *       in this list matches its corresponding enum value
 */
QStringList ResistanceInfo::digitNames() const {
    QStringList list = {
        tr ("Black"),
        tr ("Brown"),
        tr ("Red"),
        tr ("Orange"),
        tr ("Yellow"),
        tr ("Green"),
        tr ("Blue"),
        tr ("Violet"),
        tr ("Gray"),
        tr ("White")
    };

    return list;
}

/**
 * @returns An ordered list with the color names for each possible
 *          tempco value.
 *
 * @note The list has the same order as the enums of
 *       this class, so that the index number of each element
 *       in this list matches its corresponding enum value
 */
QStringList ResistanceInfo::tempcoNames() const {
    QStringList list = {
        tr ("Brown"),
        tr ("Red"),
        tr ("Orange"),
        tr ("Yellow"),
        tr ("Blue"),
        tr ("Violet")
    };

    return list;
}

/**
 * @returns An ordered list with the color names for each possible
 *          tolerance value.
 *
 * @note The list has the same order as the enums of
 *       this class, so that the index number of each element
 *       in this list matches its corresponding enum value
 */
QStringList ResistanceInfo::toleranceNames() const {
    QStringList list = {
        tr ("Brown"),
        tr ("Red"),
        tr ("Green"),
        tr ("Blue"),
        tr ("Violet"),
        tr ("Gray"),
        tr ("Gold"),
        tr ("Silver")
    };

    return list;
}

/**
 * @returns An ordered list with the color names for each possible
 *          multiplier value.
 *
 * @note The list has the same order as the enums of
 *       this class, so that the index number of each element
 *       in this list matches its corresponding enum value
 */
QStringList ResistanceInfo::multiplierNames() const {
    QStringList list = {
        tr ("Black"),
        tr ("Brown"),
        tr ("Red"),
        tr ("Orange"),
        tr ("Yellow"),
        tr ("Green"),
        tr ("Blue"),
        tr ("Violet"),
        tr ("Gray"),
        tr ("White"),
        tr ("Gold"),
        tr ("Silver")
    };

    return list;
}

/**
 * @returns An ordered list with HEX color values for each
 *          possible digit value.
 *
 * @note The list has the same order as the enums of
 *       this class, so that the index number of each element
 *       in this list matches its corresponding enum value
 */
QStringList ResistanceInfo::digitColors() const {
    QStringList list = {
        "#000000", // Black
        "#5d4037", // Brown
        "#d32f2f", // Red
        "#f57c00", // Orange
        "#fbc02d", // Yellow
        "#388e3c", // Green
        "#4169e1", // Blue
        "#512da8", // Violet
        "#888888", // Gray
        "#ffffff"  // White
    };

    return list;
}

/**
 * @returns An ordered list with HEX color values for each
 *          possible tempco value.
 *
 * @note The list has the same order as the enums of
 *       this class, so that the index number of each element
 *       in this list matches its corresponding enum value
 */
QStringList ResistanceInfo::tempcoColors() const {
    QStringList list = {
        "#5d4037", // Brown
        "#d32f2f", // Red
        "#f57c00", // Orange
        "#fbc02d", // Yellow
        "#4169e1", // Blue
        "#512da8", // Violet
    };

    return list;
}

/**
 * @returns An ordered list with HEX color values for each
 *          possible tolerance value.
 *
 * @note The list has the same order as the enums of
 *       this class, so that the index number of each element
 *       in this list matches its corresponding enum value
 */
QStringList ResistanceInfo::toleranceColors() const {
    QStringList list = {
        "#5d4037", // Brown
        "#d32f2f", // Red
        "#388e3c", // Green
        "#4169e1", // Blue
        "#512da8", // Violet
        "#888888", // Gray
        "#d4af37", // Gold
        "#c0c0c0"  // Silver
    };

    return list;
}

/**
 * @returns An ordered list with HEX color values for each
 *          possible multiplier value.
 *
 * @note The list has the same order as the enums of
 *       this class, so that the index number of each element
 *       in this list matches its corresponding enum value
 */
QStringList ResistanceInfo::multiplierColors() const {
    QStringList list = {
        "#000000", // Black
        "#5d4037", // Brown
        "#d32f2f", // Red
        "#f57c00", // Orange
        "#fbc02d", // Yellow
        "#388e3c", // Green
        "#4169e1", // Blue
        "#512da8", // Violet
        "#888888", // Gray
        "#ffffff", // White
        "#d4af37", // Gold
        "#c0c0c0"  // Silver
    };

    return list;
}

/**
 * @returns the SMD resistor tolerance
 */
int ResistanceInfo::smdTolerance() const {
    return m_smdTolerance;
}

/**
 * @returns The calculated resistance value as a number
 */
double ResistanceInfo::resistance() const {
    return m_resistance;
}

/**
 * @returns The calculated min. resistance value as a number
 */
double ResistanceInfo::minResistance() const {
    return m_minResistance;
}

/**
 * @returns The calculated max. resistance value as a number
 */
double ResistanceInfo::maxResistance() const {
    return m_maxResistance;
}

/**
 * @returns The calculated SMD resistance value as a number
 */
double ResistanceInfo::smdResistance() const {
    return m_smdResistance;
}

/**
 * @returns The numerical value of the given @a digit color
 */
int ResistanceInfo::getDigitValue (const Digit digit) {
    Q_ASSERT_X (digit >= DigitBlack && digit <= DigitWhite,
                __func__,
                "Invalid argument");

    return (int) digit;
}

/**
 * @returns The numerical value for the given @a tempco strip color
 */
int ResistanceInfo::getTempcoValue (const Tempco tempco) {
    Q_ASSERT_X (tempco >= TempcoBrown && tempco <= TempcoViolet,
                __func__,
                "Invalid argument");

    int value;

    switch (tempco) {
    case TempcoBrown:
        value = 100;
        break;
    case TempcoRed:
        value = 50;
        break;
    case TempcoOrange:
        value = 15;
        break;
    case TempcoYellow:
        value = 25;
        break;
    case TempcoBlue:
        value = 10;
        break;
    case TempcoViolet:
        value = 5;
        break;
    default:
        value = 0;
        break;
    }

    return value;
}

/**
 * @returns The numerical value for the given @a tolerance strip color
 */
double ResistanceInfo::getToleranceValue (const Tolerance tolerance) {
    Q_ASSERT_X (tolerance >= ToleranceBrown && tolerance <= ToleranceSilver,
                __func__,
                "Invalid argument");

    double value;

    switch (tolerance) {
    case ToleranceBrown:
        value = 1;
        break;
    case ToleranceRed:
        value = 2;
        break;
    case ToleranceGreen:
        value = 0.5;
        break;
    case ToleranceBlue:
        value = 0.25;
        break;
    case ToleranceViolet:
        value = 0.1;
        break;
    case ToleranceGray:
        value = 0.05;
        break;
    case ToleranceGold:
        value = 5;
        break;
    case ToleranceSilver:
        value = 10;
        break;
    default:
        value = 0;
        break;
    }

    return value / 100;
}

/**
 * @returns The numerical value for the given @a multiplier strip color
 */
double ResistanceInfo::getMultiplierValue (const Multiplier multiplier) {
    Q_ASSERT_X (multiplier >= MultiplierBlack && multiplier <= MultiplierSilver,
                __func__,
                "Invalid argument");

    double value;
    switch (multiplier) {
    case MultiplierBlack:
        value = pow (10, 0);
        break;
    case MultiplierBrown:
        value = pow (10, 1);
        break;
    case MultiplierRed:
        value = pow (10, 2);
        break;
    case MultiplierOrange:
        value = pow (10, 3);
        break;
    case MultiplierYellow:
        value = pow (10, 4);
        break;
    case MultiplierGreen:
        value = pow (10, 5);
        break;
    case MultiplierBlue:
        value = pow (10, 6);
        break;
    case MultiplierViolet:
        value = pow (10, 7);
        break;
    case MultiplierGray:
        value = pow (10, 8);
        break;
    case MultiplierWhite:
        value = pow (10, 9);
        break;
    case MultiplierGold:
        value = pow (10, -1);
        break;
    case MultiplierSilver:
        value = pow (10, -2);
        break;
    default:
        value = 0;
        break;
    }

    return value;
}

/**
 * @returns The current color of the tempco strip
 */
ResistanceInfo::Tempco ResistanceInfo::tempco() const {
    return m_tempco;
}

/**
 * @returns The current colors of the digit strips
 */
QList<ResistanceInfo::Digit> ResistanceInfo::digits() const {
    return m_digits;
}

/**
 * @returns The current color of the tolerance strip
 */
ResistanceInfo::Tolerance ResistanceInfo::tolerance() const {
    return m_tolerance;
}

/**
 * @returns The current color of the multiplier strip
 */
ResistanceInfo::Multiplier ResistanceInfo::multiplier() const {
    return m_multiplier;
}

/**
 * @returns The current type of resistor (4-strip, 5-strip, ...)
 */
ResistanceInfo::ResistorType ResistanceInfo::resistorType() const {
    return m_resistorType;
}

/**
 * Changes the first @a digit of the resistor (used for QML apps)
 */
void ResistanceInfo::setDigitA (const Digit digit) {
    setDigit (0, digit);
}

/**
 * Changes the second @a digit of the resistor (used for QML apps)
 */
void ResistanceInfo::setDigitB (const Digit digit) {
    setDigit (1, digit);
}

/**
 * Changes the third @a digit of the resistor (used for QML apps)
 */
void ResistanceInfo::setDigitC (const Digit digit) {
    setDigit (2, digit);
}

/**
 * Changes the @a tempco strip color of the current resistor
 */
void ResistanceInfo::setTempco (const Tempco tempco) {
    Q_ASSERT_X (tempco >= TempcoBrown && tempco <= TempcoViolet,
                __func__,
                "Invalid argument");

    m_tempco = tempco;
    emit tempcoChanged();
}

/**
 * Changes the @a tolerance strip color of the current resistor
 */
void ResistanceInfo::setTolerance (const Tolerance tolerance) {
    Q_ASSERT_X (tolerance >= ToleranceBrown && tolerance <= ToleranceSilver,
                __func__,
                "Invalid argument");

    m_tolerance = tolerance;
    emit toleranceChanged();
}

/**
 * Changes the SMD @a code of the current SMD resistor
 */
void ResistanceInfo::setSmdResistanceCode (const QString& code) {
    m_smdResistanceCode = code;
    emit smdResistanceCodeChanged();
}

/**
 * Changes the @a multiplier strip color of the current resistor
 */
void ResistanceInfo::setMultiplier (const Multiplier multiplier) {
    Q_ASSERT_X (multiplier >= MultiplierBlack && multiplier <= MultiplierSilver,
                __func__,
                "Invalid argument");

    m_multiplier = multiplier;
    emit multiplierChanged();
}

/**
 * Changes the resistor @a type, the value can be either:
 *     - FourStripResistor
 *     - FiveStripResistor
 *     - SixStripResistor
 */
void ResistanceInfo::setResistorType (const ResistorType type) {
    Q_ASSERT_X (type >= FourStripResistor && type <= SixStripResistor,
                __func__,
                "Invalid argument");

    m_resistorType = type;
    emit resistorTypeChanged();
}

/**
 * Changes the @a digit color of the given digit strip list @a number
 */
void ResistanceInfo::setDigit (const int number, const Digit digit) {
    Q_ASSERT_X (number >= 0 && number <= 2,
                __func__,
                "Invalid argument");
    Q_ASSERT_X (digit >= DigitBlack && digit <= DigitWhite,
                __func__,
                "Invalid argument");

    // Digit already exists in list
    if (m_digits.count() > number)
        m_digits.replace (number, digit);

    // Digit does not exist, register it to the list
    else
        m_digits.insert (number, digit);

    // Update UI
    emit digitsChanged();
}

/**
 * Calculates the resistance with the strip characteristics
 * that are currently set by the program.
 */
void ResistanceInfo::calculateResistance() {
    double base = 0;

    // Get 4-strip resistance digits
    if (resistorType() == FourStripResistor) {
        double digitA = getDigitValue (digits().at (0));
        double digitB = getDigitValue (digits().at (1));

        base = (10 * digitA) + digitB;
    }

    // Get 5-strip and 6-strip resistance digits
    else {
        double digitA = getDigitValue (digits().at (0));
        double digitB = getDigitValue (digits().at (1));
        double digitC = getDigitValue (digits().at (2));

        base = (100 * digitA) + (10 * digitB) + digitC;
    }

    // Calculate resistance
    setResistance (base * getMultiplierValue (multiplier()));
}

/**
 * Calculates the SMD resistance using the SMD resistor code
 * that is currently set by the user.
 */
void ResistanceInfo::calculateSmdResistance() {
    // Get length of the SMD code
    int len = smdResistanceCode().length();

    // Check 3-byte code
    if (len == 3) {
        // Convert each SMD digit to number
        bool okA, okB, okC;
        int digitA = QString (smdResistanceCode().at (0)).toInt (&okA);
        int digitB = QString (smdResistanceCode().at (1)).toInt (&okB);
        int digitC = QString (smdResistanceCode().at (2)).toInt (&okC);

        // Ensure that the first two digits are numbers
        if (!okA || !okB) {
            setSmdTolerance (0);
            setSmdResistance (UNKNOWN_RESISTANCE);
        }

        // Third digit is a character, use EIA-96 standard
        else if (!okC) {

        }

        // All digits are numbers, calculate resistance normally
        else {
            double multiplier = pow (10, digitC);
            double base = (10 * digitA) + digitB;

            setSmdTolerance (5);
            setSmdResistance (base * multiplier);
        }
    }

    // Check 4-byte code
    else if (len == 4) {
        // Convert each SMD digit to number
        bool okA, okB, okC, okD;
        int digitA = QString (smdResistanceCode().at (0)).toInt (&okA);
        int digitB = QString (smdResistanceCode().at (1)).toInt (&okB);
        int digitC = QString (smdResistanceCode().at (2)).toInt (&okC);
        int digitD = QString (smdResistanceCode().at (3)).toInt (&okD);

        // One or more of the digits is not a number
        if (!okA || !okB || !okC || !okD) {
            setSmdTolerance (0);
            setSmdResistance (UNKNOWN_RESISTANCE);
        }

        // Calculate SMD resistance
        else {
            double multiplier = pow (10, digitD);
            double base = (100 * digitA) + (10 * digitB) + digitC;

            setSmdTolerance (1);
            setSmdResistance (base * multiplier);
        }
    }

    // Length of code is invalid
    else {
        setSmdTolerance (5);
        setSmdResistance (UNKNOWN_RESISTANCE);
    }
}

/**
 * Returns the scientific prefix adequate for the given
 * scientific @a exponent.
 *
 * If no adequate prefix is found, the function shall return
 * "E^exponent".
 */
QString ResistanceInfo::prefixStr (const int exponent) const {
    QString str;

    switch (exponent) {
    case -9:
        str = "n";
        break;
    case -6:
        str = "µ";
        break;
    case -3:
        str = "m";
        break;
    case 0:
        str = "";
        break;
    case 3:
        str = "k";
        break;
    case 6:
        str = "M";
        break;
    case 9:
        str = "G";
        break;
    default:
        str = QString ("E%1").arg (exponent);
        break;
    }

    return str;
}

/**
 * Changes the @a tolerance value for the SMD resistor
 */
void ResistanceInfo::setSmdTolerance(const int tolerance) {
    Q_ASSERT_X (tolerance >= 0, __func__, "Invalid tolerance");

    m_smdTolerance = tolerance;
    emit smdToleranceChanged();
}

/**
 * Changes the @a resistance and updates the minimum and maximum resistance
 * values of the class.
 */ 
void ResistanceInfo::setResistance (const double resistance) {
    Q_ASSERT_X (resistance >= UNKNOWN_RESISTANCE,
                __func__,
                "Invalid resistance");

    m_resistance = resistance;
    m_minResistance = (1 - getToleranceValue (m_tolerance)) * resistance;
    m_maxResistance = (1 + getToleranceValue (m_tolerance)) * resistance;

    emit resistanceCalculated();
}

/**
 * Changes the SMD @a resistance of the class.
 */ 
void ResistanceInfo::setSmdResistance (const double resistance) {
    Q_ASSERT_X (resistance >= UNKNOWN_RESISTANCE,
                __func__,
                "Invalid SMD resistance");

    m_smdResistance = resistance;
    emit smdResistanceCalculated();
}

/**
 * Returns the most adequate scientific exponent for the given 
 * @a resistance value.
 */ 
int ResistanceInfo::scientificExp (const double resistance) const {
    int x = 9;
    int exp = -1;

    while (exp == -1) {
        if (resistance >= pow (10, x))
            exp = x;

        x -= 3;
    }

    return exp;
}

/**
 * Returns a nicely formatted string with the givn @a resistance value
 */ 
QString ResistanceInfo::getResistanceStr (const double resistance) const {
    Q_ASSERT_X (resistance >= UNKNOWN_RESISTANCE,
                __func__,
                "Invalid argument");

    // Resistance is unknown
    if (resistance == UNKNOWN_RESISTANCE)
        return tr ("Unknown");

    // Get scientific exponent for the resitance
    int power = scientificExp (resistance);

    // Get base number (e.g. 2.2 for 2.2 kΩ)
    QString number;
    double base = resistance / pow (10, power);
    if (base == (int) base)
        number = QString::number (int (base));
    else
        number = QString::number (base, 'f', 2);

    // Get formatted resistance expression string
    return QString ("%1 %2Ω").arg (number).arg (prefixStr (power));
}
