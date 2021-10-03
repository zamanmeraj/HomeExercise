//
//  Utility.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 29/09/21.
//

import Foundation
import UIKit
import CoreData

class Utility {
    
    static let shared = Utility()
    var carDetails = [CarDetails]()
    let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    /// Get all data from given JSON file
    /// - Returns: List of car details
    func fetchAndParseJSONFile<T: Decodable>(resource: String) -> [T] {
        
        let extensionName = Constants.Extensions.json
        guard let jsonUrl = Bundle.main.url(forResource: resource, withExtension: extensionName) else { return [] }
        do {
            let data = try Data(contentsOf: jsonUrl)
            let result = try JSONDecoder().decode([T].self, from: data)
            return result
        } catch let error {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    /// Get label height
    /// - Parameters:
    ///   - text: Text in the label
    ///   - font: Used font in the label
    ///   - width: Width of the label
    /// - Returns: Height of the label
    func getHeightFor(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        
        let height = text.height(withConstrainedWidth: width, font: font)
        return height
    }
    
    /// Get list of all makers
    /// - Returns: All makers
    func getAllMakers() -> [String] {
        
        self.carDetails = self.fetchAndParseJSONFile(resource: Constants.JSON.jsonFile)
        return self.carDetails.compactMap({ $0.make })
    }
    
    /// Get all models of the given maker
    /// - Parameter maker: Maker of the car
    /// - Returns: All the models of the given maker
    func getAllModels(maker: String?) -> [String] {
        
        if let maker = maker, !maker.isEmpty {
            // show model of given makers
            let filterCarDetail = self.carDetails.filter({ return $0.make.localizedCaseInsensitiveContains(maker) })
            return filterCarDetail.compactMap({ $0.model })
        }else {
            //show all makers
            return self.carDetails.compactMap({ $0.model })
        }
    }
    
    /// Get filtered array for maker and model
    /// - Parameters:
    ///   - maker: Maker of the car
    ///   - model: Model of the car
    func getFilteredArray(maker: String, model: String) {
        
        self.carDetails = self.carDetails.filter({ return $0.make.localizedCaseInsensitiveContains(maker) && $0.model.localizedCaseInsensitiveContains(model)})
    }
    
    /// Get filtered array for maker
    /// - Parameter maker: Maker of the car
    func getFilteredArray(maker: String?) {
        
        if let maker = maker, !maker.isEmpty {
            self.carDetails = self.carDetails.filter({ return $0.make.localizedCaseInsensitiveContains(maker) })
        }
    }
    
    /// Get filtered array for Maker
    /// - Parameter model: Model of the
    func getFilteredArray(model: String?) {
        
        if let model = model, !model.isEmpty {
            self.carDetails = self.carDetails.filter({ return $0.model.localizedCaseInsensitiveContains(model) })
        }
    }
    
    /// Save Car Detail in Database
    /// - Parameter detail: Model for car detail
    func saveDataInCoreData(detail: CarDetails) {
        
        let carMaker = CarMaker(context: context)
        carMaker.maker = detail.make
        carMaker.marketPrice = Int32(detail.marketPrice)
        carMaker.customerPrice = Int32(detail.customerPrice)
        
        var cons = NSSet()
        var pros = NSSet()
        
        detail.consList.forEach { consList in
            let consEntity = Cons(context: context)
            consEntity.consTitle = consList
            cons = cons.adding(consEntity) as NSSet
        }
        
        detail.prosList.forEach { prosList in
            let prosEntity = Pros(context: context)
            prosEntity.prosTitle = prosList
            pros = pros.adding(prosEntity) as NSSet
        }
        
        carMaker.cons = cons
        carMaker.pros = pros
        carMaker.carImage = UIImage(named: detail.carImage)?.pngData()
        carMaker.rating = Int16(detail.rating)
        carMaker.model = detail.model
        
        do {
            try context.save()
            UserDefaults.standard.set(true, forKey: Constants.Entity.isSynced)
        }catch let error {
            print(error.localizedDescription)
            UserDefaults.standard.set(false, forKey: Constants.Entity.isSynced)
        }
    }
    
    func changeModelToCarMaker(carLists: CarDetails) {
        
    }
    
}
