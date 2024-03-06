//
//  TimeListViewModel.swift
//  TTimer
//
//  Created by Thịnh Nguyễn on 18/02/2024.
//

import Foundation
import RxRelay
import RxSwift
import Combine

class TimeListViewModel {
    var timeList: [TimeItem] = []
    var time = BehaviorRelay<[TimeItem]>(value: [])
    let bag = DisposeBag()
}
