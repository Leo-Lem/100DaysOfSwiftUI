//
//  DataLoadingFromURL.swift
//  Friendface
//
//  Created by Leopold Lemmermann on 21.11.21.
//

import CoreData

func loadData<T: Decodable>(from string: String, to type: T, context: NSManagedObjectContext) async -> T? {
    await DataLoadingFromURL().loadDataHandled(from: string, to: type, context: context)
}

class DataLoadingFromURL {
    private enum DataLoadingError: Error {
        case invalidURL, fetching(_ description: String?), decoding(_ description: String?)
    }
    
    //MARK: getting the URL
    private func getURL(from string: String) throws -> URL {
        if let url = URL(string: string) {
            return url
        } else {
            throw DataLoadingError.invalidURL
        }
    }
    
    //MARK: fetching the data
    private func fetchData(from url: URL) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw DataLoadingError.fetching(error.localizedDescription)
        }
    }
    
    //MARK: decoding the data (additional CoreData Object Support)
    private func decodeData<T: Decodable>(_ data: Data, to type: T) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw DataLoadingError.decoding(error.localizedDescription)
        }
    }
    
    private func decodeData<T: Decodable>(_ data: Data, to type: T, context: NSManagedObjectContext) throws -> T {
        do {
            return try JSONDecoder(context: context, dateFormat: "yyyy-MM-dd'T'HH:mm:ssZZZZZ").decode(T.self, from: data)
        } catch {
            throw DataLoadingError.decoding(error.localizedDescription)
        }
    }
    
    //MARK: loading the data from a URL-String or a URL
    public func loadData<T: Decodable>(from urlString: String, to type: T) async throws -> T {
        let url = try getURL(from: urlString)
        let data = try await fetchData(from: url)
        return try decodeData(data, to: type)
    }
    
    public func loadData<T: Decodable>(from urlString: String, to type: T, context: NSManagedObjectContext) async throws -> T {
        let url = try getURL(from: urlString)
        let data = try await fetchData(from: url)
        return try decodeData(data, to: type, context: context)
    }
    
    public func loadData<T: Decodable>(from url: URL, to type: T) async throws -> T {
        let data = try await fetchData(from: url)
        return try decodeData(data, to: type)
    }
    
    public func loadData<T: Decodable>(from url: URL, to type: T, context: NSManagedObjectContext) async throws -> T {
        let data = try await fetchData(from: url)
        return try decodeData(data, to: type, context: context)
    }
    
    //MARK: handling the errors
    public func loadDataHandled<T: Decodable>(from string: String, to type: T, context: NSManagedObjectContext) async -> T? {
        do {
            return try await loadData(from: string, to: type, context: context)
        } catch DataLoadingError.invalidURL {
            print("Invalid URL")
        } catch DataLoadingError.fetching(let description) {
            print("Fetching Error: \(description ?? "Unknown")")
        } catch DataLoadingError.decoding(let description) {
            print("Decoding Error: \(description ?? "Unknown")")
        } catch {
            print("Unknown Error")
        }
        return nil
    }
}
