import Foundation

struct AllDams: Codable {
    let dams: [Dam]
    var averageRates: Double

}

struct Dam: Codable {
    let activeFullnessAmount: Double
    let city: String
    let dam: String
    let date: Date
    let historicalData: [HistoricalDatum]?
}

struct HistoricalDatum: Codable {
    let activeFullnessAmount: Double
    let date: Date
}
struct Cities: Codable {
    let city: String?
}

