//
//  TimeListViewModel.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 18/02/2024.
//

import Foundation
import RxRelay
import RxSwift

class TimeListViewModel {
    let time = BehaviorRelay<[String]>(value: [])
    let bag = DisposeBag()
}
