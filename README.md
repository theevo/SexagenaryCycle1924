# Chinese Sexagenary Cycle

[![Unit Tests](https://github.com/theevo/SexagenaryCycle1924/actions/workflows/unit_tests.yml/badge.svg)](https://github.com/theevo/SexagenaryCycle1924/actions/workflows/unit_tests.yml)

## Purpose

This is a Swift Package that will:

1. For Swift devs: Service requests specifying a date as a parameter, responding with the Chinese zodiac's Associated animal and Associated element
2. For non-Swift devs: Publish a programmer-friendly JSON file containing all the data mentioned below

## What? Sexa-wha?

A Sexagenary Cycle is a sixty-year cycle, historically used for recording time in China and the rest of the East Asian cultural sphere. The most popular use for this is to determine your [Chinese zodiac](https://en.wikipedia.org/wiki/Chinese_zodiac) sign according to your year of birth.

## Where is your data from?

Source: [Sexagenary cycle from Wikipedia](https://en.wikipedia.org/wiki/Chinese_zodiac#Years)

The source contains 2 consecutive Sexagenary Cycles - for a total of 120 years of zodiac data:

1. 1924 - 1983
2. 1984 - 2043

## Install the Package

Once you've created your project in Xcode, install the package.

In Xcode,

1. Click File Add Package Dependencies...
2. Paste this url into the Search field: `https://github.com/theevo/SexagenaryCycle1924`
3. Click Add Package.

### What's the executable for?

The executable is only there to help GitHub Actions build the JSON file (yay for automation!).

The Swift Package contains 1 executable and 1 library. Swift devs will just add the library. You do not need to add the executable to your project.

## Swift Usage

### Import statement

To make any of the given commands work, include the following import statement at the top of your swift file.

```swift
import SexagenaryCycle1924
```

### Get your animal sign

#### Pass your birthday as a String (format: MM-DD-YYYY) as a parameter to the `ZodiacQuery` initializer. 

```swift
let query = try! ZodiacQuery(birthday: "11-26-1978")
print(query.animal.name) // ".Horse"
```

#### Or query with a Swift `Date`

```swift
let formatter = DateFormatter()
formatter.dateFormat = "MM-dd-yyyy"
formatter.timeZone = TimeZone.current
let date = formatter.date(from: "10-31-1947")

let query = try! ZodiacQuery(date: date)
print(query.animal.name) // ".Ox"
```

### Get the matching date range

Why? The animal that is returned from your query contains an [_array_ of date ranges](#other-properties). Which range matched your particular query can be obtained with the `ZodiacQuery.prettyPrintRange()` method.

The fact that there are 2 date ranges is by design, and you can read the [full explanation](#explanation) below in the section labelled JSON file.

```swift
let query = try! ZodiacQuery(birthday: "02-09-2024")
print(query.prettyPrintRange()) // "Jan 22, 2023 - Feb 9, 2024"
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

## Why copy it to Github?

In its current form, the Wikipedia table is not friendly to programmers.

If you saw this table, determining if your birthdate fell within the date ranges below would not be easy. Also, note that the date range's data type is a *string*, not a *date*.

| Line | Year 1924–1983 | Year 1984–2043 | Associated element | Heavenly stem | Earthly branch | Associated animal |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
| 1 | Feb 05 1924–Jan 23 1925 | Feb 02 1984–Feb 19 1985 | Yang Wood | 甲 | 子 | Rat |
| 2 | Jan 24 1925–Feb 12 1926 | Feb 20 1985–Feb 08 1986 | Yin Wood | 乙 | 丑 | Ox |
| 3 | Feb 13 1926–Feb 01 1927 | Feb 09 1986–Jan 28 1987 | Yang Fire | 丙 | 寅 | Tiger |

## Transformation work

The mission here is to *disseminate the available sexagenary cycle data, making it programmer-friendly while maintaining data integrity*.

The HTML table was copied from [Wikipedia](https://en.wikipedia.org/wiki/Chinese_zodiac#Years) and saved as a TSV file. From the TSV file, a JSON file was created as a starting point for further refinement.

With full respect to the original source material, the TSV file will be kept as close as possible to its original form - undergoing edits only in the off-chance that the data values require correction.

Utilizing the JSON of the source, this package will have a method that can generate a new JSON file that contains actual *data* types (as opposed to strings in the original), making lookup of a date's zodiac animal easier.

## Contact

If you feel I'm not living up to the mission of this project or you have other queries, please [contact me](https://iosdev.space/@theevo).

Theo Vora: [Mastodon](https://iosdev.space/@theevo)




































## For the Time Lords

### What time zone do you use?

All times in the JSON file as well as the `ZodiacRecords.animals` are set to GMT+0 00:00.

As a natural consequence, it becomes necessary to perform time zone conversions before a query is executed and whenever presenting date ranges to the user.

### Why not use China time zone?

My original plan was to do exactly that. What better way to ensure ultimate accuracy?

Upon building this package, the simple answer is I do not see the value in it, so I abandonded that effort.

The specific value-add adding Chinese time zone would serve the `<1%` (my guess) of the population that happened to be born on the _eve of a lunar new year day_.

This would require 2 things to be answered before I would re-entertain the idea.

The first: users would have to provide their time of birth. I think most users don't care. Again, it doesn't come into play unless given the lunar new year eve scenario above. Prove me otherwise, and we'll talk.

The second: If it's Lunar New Year day in China, and a person was born on the _Eve_ of lunar new year, which animal are they assigned? If you know the answer, please get in touch.
