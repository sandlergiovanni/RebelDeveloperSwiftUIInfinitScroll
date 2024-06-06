
struct ViaCepResponse: Codable {
    var cep: String
    var logradouro: String?
    var complemento: String?
    var bairro: String?
    var localidade: String?
    var uf: String?
    var ddd: String?
}
