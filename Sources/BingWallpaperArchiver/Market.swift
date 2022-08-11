public enum Market: Int, CaseIterable {

    case us = 0
    case uk
    case de
    case ca
    case jp
    case cn
    case fr
    case bz
    case it
    case es
    case `in`
        
    var toString: String {
        switch self {
        case .us:
            return "en-US"
        case .uk:
            return "en-GB"
        case .de:
            return "de-DE"
        case .ca:
            return "en-CA"
        case .jp:
            return "ja-JP"
        case .cn:
            return "zh-CN"
        case .fr:
            return "fr-FR"
        case .bz:
            return "pt_BR"
        case .it:
            return "it-IT"
        case .es:
            return "es-ES"
        case .in:
            return "en-IN"
        }
    }
}
