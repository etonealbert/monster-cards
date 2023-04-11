import Foundation
import Kitura

@main
public struct MockApiServer {
    public static func main() {
        let router = Router()
        router.all(middleware: BodyParser())

        let services = BattleOfMonstersServices()

        router.get("/monsters") { _, response, next in
            services.getMonsters(forResource: "monsters"){ (result) in
                switch result {
                case .success(let data):
                    response.send(data: data)
                case .failure(let error):
                    response.status(.badRequest)
                    response.send(error.localizedDescription)

                }
            }
        }

        router.post("/battle") { request, response, next in
            guard let body = request.body else {
                response.status(.badRequest)
                response.send("Missing Request Body")
                return
            }

            let requestBody = body.asJSON as! [String : String?]

            services.postBattle(body: requestBody){ (result) in
                switch result {
                case .success(let data):
                    response.send(data: data)
                case .failure(let error):
                    response.status(.badRequest)
                    response.send(error.localizedDescription)

                }
            }
        }

        //route to handle GET requests to any other endpoint
        router.get("*") { request, response, next in
            response.status(.notFound)
            response.send("Not Found")
        }

        let port = ProcessInfo.processInfo.environment["PORT"] ?? "8090"
        Kitura.addHTTPServer(onPort: Int(port)!, with: router)
        Kitura.run()
    }
}
