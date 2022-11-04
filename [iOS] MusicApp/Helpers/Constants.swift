//
//  Constants.swift
//  [iOS] MusicApp
//
//  Created by 유현이 on 2022/11/04.
//

import UIKit

public enum MusicApi {
    static let requestUrl
    static let mediaParam
}

public struct Cell {
    static let musicCellIdentifier
    static let musicCollectionViewCellIdentifier
    private init() {}
}

public struct CVCell {
    static let spacingWitdh: CGFloat
    static let cellColums: CGFloat
}
