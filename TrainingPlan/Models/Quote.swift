import Foundation

struct Quote: Identifiable, Codable {
    let id: UUID
    let text: String
    let author: String
    
    init(id: UUID = UUID(), text: String, author: String) {
        self.id = id
        self.text = text
        self.author = author
    }
}

// Список цитат для приложения
class QuoteService {
    static let quotes: [Quote] = [
        Quote(text: "The only way to do great work is to love what you do.", author: "Steve Jobs"),
        Quote(text: "Believe you can and you're halfway there.", author: "Theodore Roosevelt"),
        Quote(text: "It does not matter how slowly you go as long as you do not stop.", author: "Confucius"),
        Quote(text: "Success is not final, failure is not fatal: It is the courage to continue that counts.", author: "Winston Churchill"),
        Quote(text: "The future belongs to those who believe in the beauty of their dreams.", author: "Eleanor Roosevelt"),
        Quote(text: "Don't watch the clock; do what it does. Keep going.", author: "Sam Levenson"),
        Quote(text: "The secret of getting ahead is getting started.", author: "Mark Twain"),
        Quote(text: "Quality is not an act, it is a habit.", author: "Aristotle"),
        Quote(text: "The harder I work, the luckier I get.", author: "Samuel Goldwyn"),
        Quote(text: "The best way to predict the future is to create it.", author: "Peter Drucker"),
        Quote(text: "Your time is limited, don't waste it living someone else's life.", author: "Steve Jobs"),
        Quote(text: "The only limit to our realization of tomorrow will be our doubts of today.", author: "Franklin D. Roosevelt"),
        Quote(text: "The mind is everything. What you think you become.", author: "Buddha"),
        Quote(text: "Strive not to be a success, but rather to be of value.", author: "Albert Einstein"),
        Quote(text: "The way to get started is to quit talking and begin doing.", author: "Walt Disney")
    ]
    
    static func getRandomQuote() -> Quote {
        return quotes.randomElement() ?? quotes[0]
    }
} 