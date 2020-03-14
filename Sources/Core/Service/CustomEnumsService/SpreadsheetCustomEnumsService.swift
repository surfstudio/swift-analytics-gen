//
//  SpreadsheetCustomEnumsService.swift
//  
//
//  Created by Alexander Filimonov on 14/03/2020.
//

import NetworkService
import PathKit

public final class SpreadsheetCustomEnumsService: CustomEnumsAbstractService {

    // MARK: - Private Properties

    private let networkSpreadsheetService: GoogleSpreadsheetAbstractService
    private let spreadsheetConfig: SpreadsheetConfig?

    // MARK: - Initialization

    public init(creadentialFilePath: Path,
                spreadsheetConfig: SpreadsheetConfig?) throws {
        self.networkSpreadsheetService = try GoogleSpreadsheetService(creadentialFilePath: creadentialFilePath)
        self.spreadsheetConfig = spreadsheetConfig
    }

    // MARK: - CustomEnumsAbstractService

    public func getCustomEnums() throws -> [CustomEnum] {
        guard let spreadsheetConfig = spreadsheetConfig else {
            return []
        }
        let requestEntiry = SpreadsheetNetworkRequestEntity(id: spreadsheetConfig.id,
                                                     pageName: spreadsheetConfig.pageName,
                                                     range: spreadsheetConfig.range)
        let spreadsheetEntry = try networkSpreadsheetService.getGoogleSheetData(by: requestEntiry)
        return SpreadsheetCustomEnumParser(spreadsheet: .init(from: spreadsheetEntry)).getCustomEnums()
    }

}
