import SwiftUI
import FirebaseFirestore

struct ContactView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var nome: String = ""
    @State private var celular: String = ""
    @State private var email: String = ""
    @State private var cep: String = ""
    @State private var rua: String = ""
    @State private var bairro: String = ""
    @State private var cidade: String = ""
    @State private var estado: String = ""
    @State private var numero: String = ""
    @State private var complemento: String = ""
    
    @State private var isLoading: Bool = false
    
    var contact: Contact?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Form {
                    MainSection(nome: $nome, celular: $celular, email: $email)
                    
                    AddressSection(cep: $cep, rua: $rua, bairro: $bairro, cidade: $cidade, estado: $estado, numero: $numero, complemento: $complemento)
                }
                
                Spacer()
                
                Button {
                    Task {
                        await gravar()
                    }
                } label: {
                    if !isLoading {
                        Text("Gravar")
                            .frame(maxWidth: .infinity)
                    } else {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(nome.isEmpty && celular.isEmpty && email.isEmpty && cep.isEmpty)
            }
        }
        .navigationTitle("Novo Contato")
        .padding()
        .onAppear {
            if let validContact = self.contact {
                self.nome = validContact.nome
                self.celular = validContact.celular
                self.email = validContact.email
                self.cep = validContact.cep ?? ""
                self.rua = validContact.rua ?? ""
                self.bairro = validContact.bairro ?? ""
                self.cidade = validContact.cidade ?? ""
                self.estado = validContact.estado ?? ""
                self.numero = validContact.numero ?? ""
                self.complemento = validContact.complemento ?? ""
            }
        }
    }
    
    private func gravar() async {
        isLoading = true
        if contact == nil {
            createNewContact()
        } else {
            updateCurrentContact()
        }
        isLoading = false
    }
    
    private func createNewContact() {
        do {
            let newContact = Contact(nome: nome,
                                     celular: celular,
                                     email: email,
                                     cep: cep,
                                     rua: rua,
                                     bairro: bairro,
                                     cidade: cidade,
                                     estado:  estado,
                                     numero: numero,
                                     complemento: complemento)
            
            try Firestore.firestore()
                .collection(AppCollections.contacts)
                .document()
                .setData(from: newContact)
            
            DispatchQueue.main.async {
                dismiss()
            }
        } catch {
            print("==> ContactView -> gravar: Erro ao gerar item: \(error.localizedDescription)")
        }
    }
    
    private func updateCurrentContact() {
        guard let currentId = self.contact?.id,
              var currentContact = self.contact else {
            return
        }
        do {
            currentContact.nome = nome
            currentContact.email = email
            currentContact.celular = celular
            
            currentContact.cep = cep
            currentContact.rua = rua
            currentContact.bairro = bairro
            currentContact.cidade = cidade
            currentContact.estado = estado
            currentContact.numero = numero
            currentContact.complemento = complemento
            
            try Firestore.firestore()
                .collection(AppCollections.contacts)
                .document(currentId)
                .setData(from: currentContact)
            
            DispatchQueue.main.async {
                dismiss()
            }
        } catch {
            print("==> ContactView -> gravar: Erro ao gerar item: \(error.localizedDescription)")
        }
    }
}

struct MainSection: View {
    @Binding var nome: String
    @Binding var celular: String
    @Binding var email: String
    
    var body: some View {
        Section("Dads do Contato:") {
            TextField(text: $nome) {
                Text("Nome")
                    .font(.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
            }
            
            TextField(text: $celular) {
                Text("Celular")
                    .font(.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
            }
            
            TextField(text: $email) {
                Text("E-Mail")
                    .font(.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
            }
        }
    }
}

struct AddressSection: View {
    @Binding var cep: String
    @Binding var rua: String
    @Binding var bairro: String
    @Binding var cidade: String
    @Binding var estado: String
    @Binding var numero: String
    @Binding var complemento: String
    
    @State private var isLoading = false
    
    var body: some View {
        Section("Endereço:") {
            TextField(text: $cep) {
                Text("CEP")
                    .font(.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
            }
            .onChange(of: cep) {
                Task {
                    await checkPostalCode()
                }
            }
            .disabled(isLoading)
            
            TextField(text: $rua) {
                Text("Rua")
                    .font(.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
            }
            
            TextField(text: $bairro) {
                Text("Bairro")
                    .font(.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
            }
            
            TextField(text: $cidade) {
                Text("Cidade")
                    .font(.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
            }
            
            TextField(text: $estado) {
                Text("Estado")
                    .font(.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
            }
            
            TextField(text: $numero) {
                Text("Número")
                    .font(.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
            }
            
            TextField(text: $complemento) {
                Text("Complemento")
                    .font(.headline)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
            }
        }
    }
    
    private func checkPostalCode() async {
        let cleanCep = self.cep.replacingOccurrences(of: "-", with: "")
        guard cleanCep.count == 8,
              let url = URL(string: "https://viacep.com.br/ws/\(cleanCep)/json") else {
            
            rua = ""
            bairro = ""
            cidade = ""
            estado = ""
            
            return
        }
        
        isLoading = true
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let result = try JSONDecoder().decode(ViaCepResponse.self, from: data)
            fillData(result)
        } catch {
            print("==> AddressSection error -> checkPostalCode: \(error.localizedDescription)")
        }
        isLoading = false
    }
    
    private func fillData(_ viaCepData: ViaCepResponse) {
        cep = viaCepData.cep
        rua = viaCepData.logradouro ?? "N/A"
        bairro = viaCepData.bairro ?? "N/A"
        cidade = viaCepData.localidade ?? "N/A"
        estado = viaCepData.uf ?? "N/A"
    }
}

#Preview {
    ContactView(contact: nil)
}
