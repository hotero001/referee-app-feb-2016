

import Foundation
import CoreData

class JournalEntry: NSManagedObject {

  @NSManaged var date: NSDate?
  @NSManaged var height: String?
  @NSManaged var period: String?
  @NSManaged var wind: String?
  @NSManaged var location: String?
  @NSManaged var rating: NSNumber?
  @NSManaged var homeScore: NSNumber?
  @NSManaged var awayScore: NSNumber?
  
  @NSManaged var homeYellowListing: String?
  @NSManaged var homeRedListing: String?
  
  @NSManaged var awayYellowListing: String?
  @NSManaged var awayRedListing: String?
  
  @NSManaged var homeTeam:String?
  @NSManaged var awayTeam:String?
  
  @NSManaged var homeTeamColor:String?
  @NSManaged var awayTeamColor:String?
  
  @NSManaged var division:String?
  
  @NSManaged var gameDate:String?
  
  func stringForDate() -> String {
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
    if let date = date {
      return dateFormatter.stringFromDate(date)
    } else {
      return ""
    }
  }
  
  func csv() -> String {
    
    let coalescedHeight = height ?? ""
    let coalescedPeriod = period ?? ""
    let coalescedWind = wind ?? ""
    let coalescedLocation = location ?? ""
    var coalescedRating:String
    if let rating = rating?.intValue {
      coalescedRating = String(rating)
    } else {
      coalescedRating = ""
    }
    
    return "\(stringForDate()),\(coalescedHeight)," +
      "\(coalescedPeriod),\(coalescedWind)," +
        "\(coalescedLocation),\(coalescedRating)\n"
  }
}
