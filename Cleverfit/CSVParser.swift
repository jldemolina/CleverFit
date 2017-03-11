import Foundation

// MARK: Parser
public class CSVParser {

    private let columnCount: Int
    public let headers: [String]
    public let keyedRows: [[String: String]]?
    public let rows: [[String]]

    public init(with string: String, separator: String = ",", headers: [String]? = nil) {
        var parsedLines = CSVParser.records(from: string.replacingOccurrences(of: "\r\n", with: "\n")).map { CSVParser.cells(forRow: $0, separator: separator) }
        self.headers = headers ?? parsedLines.removeFirst()
        rows = parsedLines
        columnCount = self.headers.count

        let tempHeaders = self.headers
        keyedRows = rows.map { field -> [String: String] in
            var row = [String: String]()
            for (index, value) in field.enumerated() where value.isNotEmptyOrWhitespace {
                if index < tempHeaders.count {
                    row[tempHeaders[index]] = value
                }
            }
            return row
        }
    }

    public convenience init(with string: String, headers: [String]?) {
        self.init(with: string, separator:",", headers:headers)
    }

    internal static func cells(forRow string: String, separator: String = ",") -> [String] {
        return CSVParser.split(separator, string: string).map { element in
            if let first = element.characters.first, let last = element.characters.last, first == "\"" && last == "\"" {
                let range = element.characters.index(after: element.startIndex) ..< element.characters.index(before: element.endIndex)
                return element[range]
            }
            return element
        }
    }

    internal static func records(from string: String) -> [String] {
        return CSVParser.split("\n", string: string).filter { $0.isNotEmptyOrWhitespace }
    }

    private static func split(_ separator: String, string: String) -> [String] {
        func oddNumberOfQuotes(_ string: String) -> Bool {
            return string.components(separatedBy: "\"").count % 2 == 0
        }

        let initial = string.components(separatedBy: separator)
        var merged = [String]()
        for newString in initial {
            guard let record = merged.last, oddNumberOfQuotes(record) == true else {
                merged.append(newString)
                continue
            }
            merged.removeLast()
            let lastElem = record + separator + newString
            merged.append(lastElem)
        }
        return merged
    }

}
