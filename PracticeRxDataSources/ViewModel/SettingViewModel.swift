//
//  SettingViewModel.swift
//  PracticeRxDataSources
//
//  Created by hideto c. on 2021/06/05.
//

import RxSwift
import RxCocoa
import RxDataSources


class SettingViewModel {
    
    let items = BehaviorRelay<[SettingSectionModel]>(value: [])
    
    var itemsObservable: Observable<[SettingSectionModel]> {
        return items.asObservable()
    }
    
    func setup() {
        updateItems()
    }
    
    func updateItems() {
        let sections: [SettingSectionModel] = [accountSection(),
                                               commonSection(),
                                               otherSection()]
        items.accept(sections)
    }
    
    func accountSection() -> SettingSectionModel {
        let items: [SettingsItem] = [.account,
                                     .security,
                                     .notification,
                                     .contents]
        return SettingSectionModel(model: .account, items: items)
    }
    
    func commonSection() -> SettingSectionModel {
        let items: [SettingsItem] = [.sounds,
                                     .dataUsing,
                                     .accessibility,
                                     .description(text: "基本設定はこの端末でログインしている全てのアカウントに適用されます。")]
        return SettingSectionModel(model: .common, items: items)
    }
    
    func otherSection() -> SettingSectionModel {
        let items: [SettingsItem] = [.credits,
                                     .version,
                                     .privacyPolicy]
        return SettingSectionModel(model: .other, items: items)
    }
}
