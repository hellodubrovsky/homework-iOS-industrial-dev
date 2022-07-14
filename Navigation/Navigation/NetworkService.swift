//
//  NetworkService.swift
//  Navigation
//
//  Created by Илья on 06.07.2022.
//

import Foundation
import UIKit

struct NetworkService {
    static func launchingTheURLSessionDataTask(by urlString: String) {
        if let url = URL(string: urlString) {
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 60
            let session = URLSession(configuration: configuration)
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                if let data = data {
                    print("\n🥝 Data (URL: \(url)): \(data)")
                    print("🍐 Data encoding (URL: \(url)):\n\(String(data: data, encoding: .windowsCP1250)!)")
                }
                if let response = response as? HTTPURLResponse {
                    print("\n🫐 Response (statusCode): \(response.statusCode)")
                    print("🌽 Response (allHeaderFields): \(response.allHeaderFields)")
                }
                if let error = error {
                    print("\n🍉 Error (URL: \(url)):\n\(error.localizedDescription)")
                    
                    /*  При отсутствии интернета, появляется следующая ошибка:
                        🍉 Error (URL: https://swapi.dev/api/planets/5):
                        The Internet connection appears to be offline.
                    */
                }
            })
            task.resume()
        } else {
            print("🌶 URL incorrect.")
        }
    }
    
    /// Метод загрузки данных из сети, с помощью строки URL.
    static func loadData(stringURL: String, completion: @escaping (Data?) -> Void) -> Void {
        if let url = URL(string: stringURL) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let response = response as? HTTPURLResponse, error == nil {
                    print("🧿 Response URL (\(stringURL)): \(response.statusCode).")
                    completion(data)
                } else {
                    print("⚠️ Error load data: \(error?.localizedDescription ?? "unknown error")")
                }
            }
            task.resume()
        } else {
            print("⚠️ URL Error: \(stringURL)")
        }
    }
}
