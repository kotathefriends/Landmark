//
//  ModelData.swift
//  Landmarks
//
//  Created by KOTA TAKAHASHI on 2023/11/20.
//

import Foundation

// landmarks配列を定義し、"landmarkData.json"から読み込んだデータで初期化します。
var landmarks: [Landmark] = load("landmarkData.json")

// この関数は、JSONファイルからDecodable型のオブジェクトをロードするために使用されます。
func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    // アプリのメインバンドルから指定されたファイルのURLを取得しようと試みます。
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        // ファイルが見つからない場合、エラーを発生させて処理を停止します。
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    // 指定されたファイルからデータを読み込みます。
    do {
        data = try Data(contentsOf: file)
    } catch {
        // データの読み込みに失敗した場合、エラーを発生させて処理を停止します。
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    // JSONDecoderを使用してデータを指定された型にデコードします。
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        // デコードに失敗した場合、エラーを発生させて処理を停止します。
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
