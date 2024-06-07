import FirebaseFirestore

struct Contact: Identifiable, Codable {
    @DocumentID var id: String?
    var createdAt: Date
    var nome: String
    var celular: String
    var email: String
    var cep: String?
    var rua: String?
    var bairro: String?
    var cidade: String?
    var estado: String?
    var numero: String?
    var complemento: String?
    
    init(createdAt: Date = .now, nome: String, celular: String, email: String, cep: String? = nil, rua: String? = nil, bairro: String? = nil, cidade: String? = nil, estado: String? = nil, numero: String? = nil, complemento: String? = nil) {
        self.id = UUID().uuidString
        self.createdAt = createdAt
        self.nome = nome
        self.celular = celular
        self.email = email
        self.cep = cep
        self.rua = rua
        self.bairro = bairro
        self.cidade = cidade
        self.estado = estado
        self.numero = numero
        self.complemento = complemento
    }
}
