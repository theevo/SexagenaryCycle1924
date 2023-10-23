# Chinese Sexagenary Cycle

[![Unit Tests](https://github.com/theevo/SexagenaryCycle1924/actions/workflows/swift.yml/badge.svg)](https://github.com/theevo/SexagenaryCycle1924/actions/workflows/swift.yml)

## Purpose

This is a Swift Package that will:

1. Service requests specifying a date as a parameter, responding with the Chinese zodiac's Associated element and Associated animal
2. (for those who are not Swift devs) Publish a programmer-friendly JSON file containing all the data mentioned below

## Current status

*In progress*.

Tasks

- Build Swift Package
- Add Start and End Date fields in Date type based on the date ranges which are currently string types
- Once validated, remove the string date ranges


## What? Sexa-wha?

It is a sixty-year cycle, historically used for recording time in China and the rest of the East Asian cultural sphere. One way to use this JSON file is to determine your Chinese zodiac sign according to your year of birth. [Read more at Wikipedia](https://en.wikipedia.org/wiki/Chinese_zodiac)

## Where is your data from?

Source: [Sexagenary cycle from Wikipedia](https://en.wikipedia.org/wiki/Chinese_zodiac#Years)

The source contains 2 consecutive Sexagenary Cycles:

1. 1924 - 1983
2. 1984 - 2043

The HTML table was copied and saved as a TSV file. From the TSV file, we are able to create a JSON file as a starting point for further refinement.

## Why copy it to Github?

In its current form, the Wikipedia table is not friendly to programmers.

If you saw this table, determining if your birthdate fell within the date ranges below would not be easy. Also note that the date range is *string*, not a *date* type.

| Line | Year 1924–1983 | Year 1984–2043 | Associated element | Heavenly stem | Earthly branch | Associated animal |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| 1 | Feb 05 1924–Jan 23 1925 | Feb 02 1984–Feb 19 1985 | Yang Wood | 甲 | 子 | Rat |
| 2 | Jan 24 1925–Feb 12 1926 | Feb 20 1985–Feb 08 1986 | Yin Wood | 乙 | 丑 | Ox |
| 3 | Feb 13 1926–Feb 01 1927 | Feb 09 1986–Jan 28 1987 | Yang Fire | 丙 | 寅 | Tiger |

## Transformation work

My mission here is to *preserve, improve, and publish the improvements as copies*.

I'm most comfortable in the Swift language, so the transformation work will be done in a Swift Framework.
