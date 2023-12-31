# Chinese Sexagenary Cycle

[![Unit Tests](https://github.com/theevo/SexagenaryCycle1924/actions/workflows/unit_tests.yml/badge.svg)](https://github.com/theevo/SexagenaryCycle1924/actions/workflows/unit_tests.yml)

## Purpose

This is a Swift Package that will:

1. For Swift devs: Service requests specifying a date as a parameter, responding with the Chinese zodiac's Associated element and Associated animal
2. For non-Swift devs: Publish a programmer-friendly JSON file containing all the data mentioned below

## Current status

*Complete!*


## What? Sexa-wha?

A Sexagenary Cycle is a sixty-year cycle, historically used for recording time in China and the rest of the East Asian cultural sphere. The most popular use for this is to determine your [Chinese zodiac](https://en.wikipedia.org/wiki/Chinese_zodiac) sign according to your year of birth.


## Swift Usage

### Get your animal sign

Pass your birthday as a String (format: MM-DD-YYYY) as a paramter to the `ZodiacQuery` initializer. 

```swift

import SexagenaryCycle1924

let query = try! ZodiacQuery(birthday: "11-26-1978")
print(query.animal) // ".Horse"
```

### Other properties

In addition to your Chinese animal sign, there is additional information unique to your year of birth such as Element, Heavenly Stem, and Earthly Branch. Here's the struct:

```swift
public struct SexagenaryAnimal: Encodable {
    public var name: Name
    public var element: String
    public var heavenlyStem: String
    public var earthlyBranch: String
    public var dates: [DateRange]
    
    public struct DateRange: Encodable {
        public var start: Date
        public var end: Date
    }
}
```

### What's the executable for?

The Swift Package contains 1 executable and 1 library. Swift devs will just add the library. The executable is only there to help GitHub Actions build the JSON file.

## JSON file

### Get the file

[JSON file containing all 120 years of Chinese Zodiac dates, Animals, and Elements](https://github.com/theevo/SexagenaryCycle1924/blob/main/sexagenary1924to2043.json)

### Explanation

It is an array of 60 animal/element combinations.

#### Why 60? I thought you said this had 120 years

* 12 Animals
* 5 Elements


While individuals who are 12/24/36/48 years apart might share the same Chinese Zodiac animal (ex: Snake), they all differ because their *Elements* are different. Their Heavenly Stems will also be different.

```json
// Sample of all the Snake entries:
  {
    "heavenlyStem" : "己",
    "dates" : [
      {
        "start" : "1929-02-10T00:00:00Z",
        "end" : "1930-01-29T00:00:00Z"
      },
      {
        "start" : "1989-02-06T00:00:00Z",
        "end" : "1990-01-26T00:00:00Z"
      }
    ],
    "name" : "Snake",
    "element" : "Yin Earth",
    "earthlyBranch" : "巳"
  },
  {
    "heavenlyStem" : "辛",
    "dates" : [
      {
        "start" : "1941-01-27T00:00:00Z",
        "end" : "1942-02-14T00:00:00Z"
      },
      {
        "start" : "2001-01-24T00:00:00Z",
        "end" : "2002-02-11T00:00:00Z"
      }
    ],
    "name" : "Snake",
    "element" : "Yin Metal",
    "earthlyBranch" : "巳"
  },
  {
    "heavenlyStem" : "癸",
    "dates" : [
      {
        "start" : "1953-02-14T00:00:00Z",
        "end" : "1954-02-02T00:00:00Z"
      },
      {
        "start" : "2013-02-10T00:00:00Z",
        "end" : "2014-01-30T00:00:00Z"
      }
    ],
    "name" : "Snake",
    "element" : "Yin Water",
    "earthlyBranch" : "巳"
  },
  {
    "heavenlyStem" : "乙",
    "dates" : [
      {
        "start" : "1965-02-02T00:00:00Z",
        "end" : "1966-01-20T00:00:00Z"
      },
      {
        "start" : "2025-01-29T00:00:00Z",
        "end" : "2026-02-16T00:00:00Z"
      }
    ],
    "name" : "Snake",
    "element" : "Yin Wood",
    "earthlyBranch" : "巳"
  },
  {
    "heavenlyStem" : "丁",
    "dates" : [
      {
        "start" : "1977-02-18T00:00:00Z",
        "end" : "1978-02-06T00:00:00Z"
      },
      {
        "start" : "2037-02-15T00:00:00Z",
        "end" : "2038-02-03T00:00:00Z"
      }
    ],
    "name" : "Snake",
    "element" : "Yin Fire",
    "earthlyBranch" : "巳"
  },
```

#### Why not 120 elements instead of 60?

Individuals born *exactly* 60 years apart will share the same Animal *and* Element. They also share the same Heavenly Stem.

Rather than have an array of 120 elements (where we would be duplicating information), I decided to make `dates` an array containing the date ranges for that combination. In this file, you are guaranteed 2 date ranges for any given Animal/Element combination.


## Where is your data from?

Source: [Sexagenary cycle from Wikipedia](https://en.wikipedia.org/wiki/Chinese_zodiac#Years)

The source contains 2 consecutive Sexagenary Cycles:

1. 1924 - 1983
2. 1984 - 2043

The HTML table was copied and saved as a TSV file. From the TSV file, a JSON file was created as a starting point for further refinement.

## Why copy it to Github?

In its current form, the Wikipedia table is not friendly to programmers.

If you saw this table, determining if your birthdate fell within the date ranges below would not be easy. Also, note that the date range's data type is a *string*, not a *date*.

| Line | Year 1924–1983 | Year 1984–2043 | Associated element | Heavenly stem | Earthly branch | Associated animal |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| 1 | Feb 05 1924–Jan 23 1925 | Feb 02 1984–Feb 19 1985 | Yang Wood | 甲 | 子 | Rat |
| 2 | Jan 24 1925–Feb 12 1926 | Feb 20 1985–Feb 08 1986 | Yin Wood | 乙 | 丑 | Ox |
| 3 | Feb 13 1926–Feb 01 1927 | Feb 09 1986–Jan 28 1987 | Yang Fire | 丙 | 寅 | Tiger |

## Transformation work

The mission here is to *preserve, improve, and publish the improvements as copies*.

With full respect to the original source material, the TSV file will be kept as close as possible to its original form - undergoing edits only in the off-chance that the data values require correction.

Utilizing the JSON of the source, this package will have a method that can generate a new JSON file that contains actual *data* types (as opposed to strings in the original), making lookup of a date's zodiac animal easier.
