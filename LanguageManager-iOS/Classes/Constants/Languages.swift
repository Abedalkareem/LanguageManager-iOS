//
//  Languages.swift
//  LanguageManager-iOS
//
//  Created by abedalkareem omreyh on 10/11/2020.
//
import Foundation
@objc public enum Languages: Int, RawRepresentable {
    case ar,en,nl,ja,ko,vi,ru,sv,fr,es,pt,it,de,da,fi,nb,tr,el,id,
    ms,th,hi,hu,pl,cs,sk,uk,hr,ca,ro,he,ur,fa,ku,arc,sl,ml,am
    case deviceLanguage

    public typealias RawValue = String
    public var rawValue: RawValue {
        switch self {
            case .ar:
            return "ar"
            case .en:
            return "en"
            case .nl:
            return "nl"
            case .ja:
            return "ja"
            case .ko:
            return "ko"
            case .vi:
            return "vi"
            case .ru:
            return "ru"
            case .sv:
            return "sv"
            case .fr:
            return "fr"
            case .es:
            return "es"
            case .pt:
            return "pt"
            case .it:
            return "it"
            case .de:
            return "de"
            case .da:
            return "da"
            case .fi:
            return "fi"
            case .nb:
            return "nb"
            case .tr:
            return "tr"
            case .el:
            return "el"
            case .id:
            return "id"
            case .ms:
            return "ms"
            case .th:
            return "th"
            case .hi:
            return "hi"
            case .hu:
            return "hu"
            case .pl:
            return "pl"
            case .cs:
            return "cs"
            case .sk:
            return "sk"
            case .uk:
            return "uk"
            case .hr:
            return "hr"
            case .ca:
            return "ca"
            case .ro:
            return "ro"
            case .he:
            return "he"
            case .ur:
            return "ur"
            case .fa:
            return "fa"
            case .ku:
            return "ku"
            case .arc:
            return "arc"
            case .sl:
            return "sl"
            case .ml:
            return "ml"
            case .am:
            return "am"
            case .deviceLanguage:
            return "deviceLanguage"
        }
    }

    public init?(rawValue: RawValue) {
        switch rawValue {
            case "ar":
            self = .ar
            case "en":
            self = .en
            case "nl":
            self = .nl
            case "ja":
            self = .ja
            case "ko":
            self = .ko
            case "vi":
            self = .vi
            case "ru":
            self = .ru
            case "sv":
            self = .sv
            case "fr":
            self = .fr
            case "es":
            self = .es
            case "pt":
            self = .pt
            case "it":
            self = .it
            case "de":
            self = .de
            case "da":
            self = .da
            case "fi":
            self = .fi
            case "nb":
            self = .nb
            case "tr":
            self = .tr
            case "el":
            self = .el
            case "id":
            self = .id
            case "ms":
            self = .ms
            case "th":
            self = .th
            case "hi":
            self = .hi
            case "hu":
            self = .hu
            case "pl":
            self = .pl
            case "cs":
            self = .cs
            case "sk":
            self = .sk
            case "uk":
            self = .uk
            case "hr":
            self = .hr
            case "ca":
            self = .ca
            case "ro":
            self = .ro
            case "he":
            self = .he
            case "ur":
            self = .ur
            case "fa":
            self = .fa
            case "ku":
            self = .ku
            case "arc":
            self = .arc
            case "sl":
            self = .sl
            case "ml":
            self = .ml
            case "am":
            self = .am
            case "deviceLanguage":
            self = .deviceLanguage
            default:
            return nil
        }
    }

}
