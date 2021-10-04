//
//  Utility.swift
//  HomeExercise
//
//  Created by Zaman Meraj on 29/09/21.
//

import Foundation
import UIKit
import CoreData

//Utility class to acces Common functions
class Utility {
    
    static let shared = Utility()
    var carDetails = [CarMaker]()
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
        
        let allCarDetails:[CarDetails] = self.fetchAndParseJSONFile(resource: Constants.JSON.jsonFile)
        self.carDetails = self.changeModelToCarMaker(carLists: allCarDetails)
        return self.carDetails.compactMap({ $0.make })
    }
    
    /// Get all models of the given maker
    /// - Parameter maker: Maker of the car
    /// - Returns: All the models of the given maker
    func getAllModels(maker: String?) -> [String] {
        
        if let maker = maker, !maker.isEmpty {
            // show model of given makers
            let filterCarDetail = self.carDetails.filter({ return $0.make.unwrappedString.localizedCaseInsensitiveContains(maker) })
            return filterCarDetail.compactMap({ $0.model })
        } else {
            //show all makers
            return self.carDetails.compactMap({ $0.model })
        }
    }
    
    /// Get filtered array for maker and model
    /// - Parameters:
    ///   - maker: Maker of the car
    ///   - model: Model of the car
    func getFilteredArray(maker: String, model: String) {
        
        self.carDetails = self.carDetails.filter({ return $0.make.unwrappedString.localizedCaseInsensitiveContains(maker) || $0.model.unwrappedString.localizedCaseInsensitiveContains(model)})
    }
    
    /// Get filtered array for maker
    /// - Parameter maker: Maker of the car
    func getFilteredArray(maker: String?) {
        
        if let maker = maker, !maker.isEmpty {
            self.carDetails = self.carDetails.filter({ return $0.make.unwrappedString.localizedCaseInsensitiveContains(maker) })
        }
    }
    
    /// Get filtered array for Maker
    /// - Parameter model: Model of the
    func getFilteredArray(model: String?) {
        
        if let model = model, !model.isEmpty {
            self.carDetails = self.carDetails.filter({ return $0.model.unwrappedString.localizedCaseInsensitiveContains(model) })
        }
    }
    
    /// Save Car Detail in Database
    /// - Parameter detail: Model for car detail
    func saveDataInCoreData(detail: CarDetails) {
        
        let carMaker = CarMaker(context: context)
        carMaker.make = detail.make
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
        } catch let error {
            print(error.localizedDescription)
            UserDefaults.standard.set(false, forKey: Constants.Entity.isSynced)
        }
    }
    
    
    /// Convert CarList Modal to CarMaker
    /// - Parameter carLists: CarDetails Model
    /// - Returns: Core Data CarMaker array
    func changeModelToCarMaker(carLists: [CarDetails]) -> [CarMaker] {
        var carMakers = [CarMaker]()
        carLists.forEach { carDetail in
            let entity = NSEntityDescription.entity(forEntityName: Constants.Entity.carMaker, in: context)
            let carMaker = CarMaker(entity: entity!, insertInto: context)
            carMaker.carImage = UIImage(named: carDetail.carImage)?.jpegData(compressionQuality: 0.9)
            carMaker.make = carDetail.make
            carMaker.model = carDetail.model
            carMaker.customerPrice = Int32(carDetail.customerPrice)
            carMaker.marketPrice = Int32(carDetail.marketPrice)
            carMaker.rating = Int16(carDetail.rating)
            
            let pros = carDetail.prosList
            let prosArr = pros.map { prosText -> Pros in
                let entity = NSEntityDescription.entity(forEntityName: Constants.Entity.pros, in: context)
                let prosValue = Pros(entity: entity!, insertInto: context)
                prosValue.prosTitle = prosText
                return prosValue
            }
            carMaker.pros  = NSSet(array: prosArr)
            
            let cons = carDetail.consList
            let consArr = cons.map { consText -> Cons in
                let entity = NSEntityDescription.entity(forEntityName: Constants.Entity.cons, in: context)
                let consValue = Cons(entity: entity!, insertInto: context)
                consValue.consTitle = consText
                return consValue
            }
            carMaker.cons  = NSSet(array: consArr)
            carMakers.append(carMaker)
        }
        return carMakers
    }
    
}
