//
//  UIImageView+Extensions.swift
//  SwiftNativeFramework
//
//  Created by   Валерий Мельников on 22.12.2020.
//

import UIKit

extension UIImageView {
    
    func downloaded(from link: String?, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let `link` = link, let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    
    private func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        
        contentMode = mode
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
}
