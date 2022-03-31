import Alamofire
final class ApiManager{
    static let instance = ApiManager()
    
    enum Constans {
        static let baseURl = "https://api.openweathermap.org/data/2.5"
    }
    enum EndPoint {
        static let weather = "/weather"
    }
    
    let key = "96b6753559dac87a376db9c4031dbd46"
        func getAllWeather(
            myLatitude: Double,
            myLongitude: Double,
            completion: @escaping ((Weather) -> Void)) {
                let key: String = "96b6753559dac87a376db9c4031dbd46"
                AF.request("\(Constans.baseURl+EndPoint.weather)?lat=\(myLatitude)&lon=\(myLongitude)&units=metric&appid=\(key)").responseDecodable(of: Weather.self) {
                response in
                switch response.result {
                case .success(let model):
                    completion(model)
                case.failure(let error):
                    print(error)
                }
            }
        }
//    func getAllWeather(myLatitude: Double,
//                       myLongitude: Double,
//                       completion: @escaping((Weather) -> Void)) {
//        let key:String = "96b6753559dac87a376db9c4031dbd46"
//
//        let header: HTTPHeaders = [ "lat" : "\(myLatitude)",
//                                    "lon" : "\(myLongitude)",
//                                    "units" : "metric",
//                                    "appid" : "\(key)"]
//
//        AF.request(
//            Constans.baseURl + EndPoint.weather,
//            method: .get,
//            parameters: [:],
//            headers: header
//        ).responseDecodable(of: Weather.self) { response in
//            switch response.result {
//            case .success(let data):
//                completion(data)
//            case .failure(let error): print(error)
//            }
//        }
//
//    }
    private init() { }
    
}
