//
//  StorageUtil.swift
//  Africave
//
//  Created by Jubril   on 1/29/20.
//  Copyright © 2020 Jubril. All rights reserved.
//

import Foundation
final class StorageUtil: NSObject {

    override init() {
        super.init()
    }

    static let shared = StorageUtil()

    public func saveString(string: String!, key: String){
        delete(key: key);
        UserDefaults.standard.setValue(string, forKey: key);
        UserDefaults.standard.synchronize();
    }

    public func saveInt(value: Int!, key: String) {
        delete(key: key);
        UserDefaults.standard.set(value, forKey: key);
        UserDefaults.standard.synchronize();
    }


    public func saveBoolean(value: Bool, key: String) {
        delete(key: key);
        UserDefaults.standard.set(value, forKey: key);
        UserDefaults.standard.synchronize();
    }

    public func getString(key: String) -> String? {
        UserDefaults.standard.synchronize()
        return UserDefaults.standard.value(forKey: key) as? String;
    }

    public func getBoolean(key: String) -> Bool? {
        UserDefaults.standard.synchronize()
        return UserDefaults.standard.value(forKey: key) as? Bool;
    }

    public func contains(key: String) -> Bool{
        return UserDefaults.standard.object(forKey: key) != nil
    }

    public func getInt(key: String) -> Int {
        UserDefaults.standard.synchronize()
        return UserDefaults.standard.integer(forKey: key)
    }

    public func delete(key: String){
        UserDefaults.standard.removeObject(forKey: key);
        UserDefaults.standard.synchronize();
    }
}

