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

#ifndef APP_INFO_H
#define APP_INFO_H

//
// Application Information
//
static const char* APP_VERSION = "0.1 Alpha";
static const char* APP_DEVELOPER = "Alex Spataru";
static const char* APP_NAME = "Resistance Calculator";

//
// Ad Information
//
#if defined (ENABLE_ADS) && defined (MOBILE_RELEASE)
static const bool ADS_ENABLED = true;
static const char* ADS_BANNER_ID = "ca-app-pub-3940256099942544/6300978111";
#elif defined (ENABLE_ADS)
static const bool ADS_ENABLED = true;
static const char* ADS_BANNER_ID = "ca-app-pub-3940256099942544/6300978111";
#else
static const bool ADS_ENABLED = false;
static const char* ADS_BANNER_ID = "";
#endif

#endif
