//
//  ThumbnailGenerator.swift
//  MarketplaceApp
//
//  Created by Swati Seera on 2026-04-20.
//

import UIKit

struct ThumbnailGenerator {
    
    static func generate(from image: UIImage) -> UIImage {
        image.preparingThumbnail(of: CGSize(width: 200, height: 200)) ?? image
    }
}
