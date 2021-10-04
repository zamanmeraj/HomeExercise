//
//  HomeExerciseTests.swift
//  HomeExerciseTests
//
//  Created by Zaman Meraj on 04/10/21.
//

import XCTest
@testable import HomeExercise

class HomeExerciseTests: XCTestCase {

    
    func testFilterForCarModel() {
        
        let carDetails:[CarDetails] = Utility.shared.fetchAndParseJSONFile(resource: Constants.BlankSpace.space)
        XCTAssertEqual([], carDetails)
    }

    func testCarDetailArray() {
        
        let viewModel = CarListVCViewModel()
        viewModel.fetchJSONData()
        XCTAssertFalse(Utility.shared.carDetails.isEmpty)
        XCTAssertTrue(Utility.shared.carDetails.count > 0)
    }
    
    func testGetHeightFor() {
        
        let emptyStringHeight = Utility.shared.getHeightFor(text: "", font: UIFont.carNameFont, width: 100.0)
        XCTAssertEqual(23.0, emptyStringHeight)
        let textHeight = Utility.shared.getHeightFor(text: "Zaman", font: UIFont.carNameFont, width: 100.0)
        XCTAssertEqual(23.0, textHeight)
    }
    
    func testFilterCellHeight() {
        let cellHeight = CGFloat.filterCellHeight
        XCTAssertEqual(50.0, cellHeight)
    }
    
    func testHexColorColorCode() {
        let hexWhiteColor = UIColor(hexString: "#FFFFFF")
        let whiteColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let blackColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        XCTAssertEqual(hexWhiteColor, whiteColor)
        
        let hexWhiteColorThreeBit = UIColor(hexString: "#FFF")
        XCTAssertEqual(hexWhiteColorThreeBit, whiteColor)
        
        let hexWhiteColor8Bit = UIColor(hexString: "FFFFFFFF")
        XCTAssertEqual(hexWhiteColor8Bit, whiteColor)
        
        let invalidHexCode = UIColor(hexString: "")
        XCTAssertEqual(invalidHexCode, blackColor)
    }
    
    func testFilterView() {
        
        let filterView = FilterView()
        XCTAssertNotNil(filterView)
        filterView.filterCarList = ["hello"]
        filterView.createFilterView(frames: CGRect(x: 0, y: 0, width: 300, height: 300))
        XCTAssertTrue(filterView.transparentView.backgroundColor == UIColor.clear)
    }
    
    
    func testSetSelectedIndexValue() {
        
        let filterView = FilterView()
        filterView.selectedDropdown = .carMaker
        filterView.filterCarList = ["Test"]
        let indexPath = IndexPath(row: 0, section: 0)
        filterView.setSelectedIndexValue(indexPath)
        XCTAssertEqual(filterView.carMakeTF.text!, "Test")
        
        filterView.selectedDropdown = .carModel
        filterView.setSelectedIndexValue(indexPath)
        XCTAssertEqual(filterView.carModelTF.text!, "Test")
        filterView.carModelTF.text = ""
        filterView.selectedDropdown = .none
        filterView.setSelectedIndexValue(indexPath)
        XCTAssertEqual(filterView.carModelTF.text!, "")
    }
    
//    func testUtility() {
//        
//        let count = Utility.shared.carDetails.count
//        Utility.shared.getFilteredArray(maker: nil)
//        XCTAssertEqual(count, Utility.shared.carDetails.count)
//        Utility.shared.getFilteredArray(model: nil)
//        XCTAssertEqual(count, Utility.shared.carDetails.count)
//        
//        let getAllModel = Utility.shared.getAllModels(maker: nil)
//        XCTAssertTrue(getAllModel.count > 0)
//        
//        let getAllMaker = Utility.shared.getAllMakers()
//        XCTAssertTrue(getAllMaker.count > 0)
//        
//        Utility.shared.getFilteredArray(maker: "Rover")
//        XCTAssertTrue(Utility.shared.carDetails.count > 0)
//        
//        Utility.shared.getFilteredArray(maker: "Rover")
//        XCTAssertTrue(Utility.shared.carDetails.count > 0)
//    }
}
