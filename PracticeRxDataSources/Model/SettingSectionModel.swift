//
//  SettingSectionModel.swift
//  PracticeRxDataSources
//
//  Created by hideto c. on 2021/06/05.
//

import UIKit
import RxDataSources

typealias SettingSectionModel = SectionModel<SettingsSection, SettingsItem>

enum SettingsSection {
    case account
    case common
    case other
    
    var headerHeight: CGFloat {
        return 40.0
    }
    
    var footerHeight: CGFloat {
        return 1.0
    }
}

enum SettingsItem {
    // account section
    case account
    case security
    case notification
    case contents
    // common section
    case sounds
    case dataUsing
    case accessibility
    // other section
    case credits
    case version
    case privacyPolicy
    
    // other
    case description(text: String)
    
    var title: String? {
        switch self {
        case .account:
            return "アカウント"
        case .security:
            return "セキュリティー"
        case .notification:
            return "通知"
        case .contents:
            return "コンテンツ設定"
        case .sounds:
            return "サウンド設定"
        case .dataUsing:
            return "データ利用時の設定"
        case .accessibility:
            return "アクセシビリティ"
        case .credits:
            return "クレジット"
        case .version:
            return "バージョン情報"
        case .privacyPolicy:
            return "プライバシポリシー"
        case .description:
            return nil
        }
    }
    
    var rowHeight: CGFloat {
        switch self {
        case .description:
            return 72.0
        default:
            return 48.0
        }
    }
    
    var accessoryType: UITableViewCell.AccessoryType {
        switch self {
        case .account, .security, .notification, .contents, .sounds, .dataUsing, .accessibility, .credits, .version, .privacyPolicy:
            return .disclosureIndicator
        case .description:
            return .none
        }
    }
}
