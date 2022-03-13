//
//	WeatherData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct WeatherData : Codable {

//	let base : String?
//	let clouds : Cloud?
//	let cod : Int?
//	let coord : Coord?
//	let dt : Int?
//	let id : Int?
	let main : Main?
	let name : String?
//	let sys : Sy?
//	let timezone : Int?
	let weather : [Weather]?
	let wind : Wind?


}
