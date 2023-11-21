#  Notes

## Design Decisions

### UTC time zone, not China time zone

Data integrity is key to me.

This is a Chinese system, so therefore we should be using the time zone of China, right?

Let's start with an example. How would my birthday look in the China time zone?

```swift
extension DateFormatter{
    public static func inChinaTimeZone(dateFormat: String = "yyyy-MM-dd") -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "UTC")!
        formatter.dateFormat = dateFormat
        
        return formatter
    }
}

let birthday = "11-26-1978"

let formatter = DateFormatter.inChinaTimeZone(dateFormat: "MM-dd-yyyy")
guard let date = formatter.date(from: date) else {
    fatalError()
}

print(date)

// ▿ 1978-11-25 16:00:00 +0000
//  - timeIntervalSinceReferenceDate : -697449600.0
```

I give it "11-26," and output is "11-25." While it doesn't change the outcome of which animal I fall under (Yang Earth Horse), it does leave a newcoming programmer who looks at this a bit puzzled. Hardcore date nerds would understand that they are indeed equivalent, but the incongruency does not sit well with me.

If we want to get really accurate we would need to ask an expert on the Chinese Zodiac the following questions:

1. Are the date ranges for any given animal in China time zone?
2. Do the start dates begin at 00:00:00 and end dates at 23:59:59 China time?
3. Is the Chinese Zodiac dates fixed and absolute for everyone in the world? Here's an example: if someone is born on Jan 24 1982 at 11:00 US Central Standard Time Zone (UTC-1), would they be a Rooster or a Dog? In China, that same time would Jan 25 1982 01:00.

```json
  {
    "Line": "58",
    "Year 1924–1983": "Feb 05 1981–Jan 24 1982",
    "Year 1984–2043": "Feb 01 2041–Jan 21 2042",
    "Associated element": "Yin Metal",
    "Heavenly stem": "辛",
    "Earthly branch": "酉",
    "Associated animal": "Rooster"
  },
  {
    "Line": "59",
    "Year 1924–1983": "Jan 25 1982–Feb 12 1983",
    "Year 1984–2043": "Jan 22 2042–Feb 09 2043",
    "Associated element": "Yang Water",
    "Heavenly stem": "壬",
    "Earthly branch": "戌",
    "Associated animal": "Dog"
  },
```

Even if those questions are answered, that creates the burdon of requiring the time zone on the user. My intent is for this to be a fun and casual framework, and after all, how seriously do you take the Chinese Zodiac?

Also, think about how you would reference your Chinese Zodiac sign from the the Sexagenary Cycle table from Wikipedia's website. You're not thinking about time zones. So using this API will be no different than if you were to read the dates off the table. 

My solution for now is to set everything explicitly to UTC. The birthday you input into `ZodiacQuery.birthday(date:)` will be formatted to UTC behind the scenes -- For people who are near the border between zodiac animals, it is trivial for them to query using a birthdate that is definitively in the preceding/succeeding year.


## Links

[How to parse a String to a Date in Swift 5.6 using Date.ParseStrategy? - Stack Overflow](https://stackoverflow.com/questions/71839420/how-to-parse-a-string-to-a-date-in-swift-5-6-using-date-parsestrategy)

[Time in China - Wikipedia](https://en.wikipedia.org/wiki/Time_in_China)

[iOS Locale Identifiers](https://gist.github.com/jacobbubu/1836273)

[Working with Time Zones in Swift](https://cocoacasts.com/swift-fundamentals-working-with-time-zones-in-swift#:~:text=Creating%20Time%20Zones%20in%20Swift,zone%27s%20abbreviation%20to%20the%20initializer.)

[GMT +8 Countries / UTC +8 Countries 2023](https://worldpopulationreview.com/country-rankings/gmt-8-countries)

[Swift DateFormatter Cheatsheet [+Formulas, Parsing Dates]](https://www.advancedswift.com/date-formatter-cheatsheet-formulas-swift/)

## Init that throws

[Try Catch Throw: Error Handling in Swift with Code Examples](https://www.avanderlee.com/swift/try-catch-throw-error-handling/#throwing-initializer-in-swift)

## XCTAssertThrowsError

[Testing error code paths in Swift | Swift by Sundell](https://www.swiftbysundell.com/articles/testing-error-code-paths-in-swift/)

## Unit Test enum with Associated Values

[How to Unit Test Enumerations in Swift | Quality Coding](https://qualitycoding.org/unit-test-enumerations-swift/)
