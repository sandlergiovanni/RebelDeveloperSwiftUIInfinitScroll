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
        VStack(alignment: .leading) {
            HStack {
                ZStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                        }
                        .foregroundColor(.white)
                        Spacer()
                    }
                    
                    Text(validateTitle())
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                }
            }
            .padding()
            
            Form {
                MainSection(nome: $nome,
                            celular: $celular,
                            email: $email)
                
                AddressSection(cep: $cep,
                               rua: $rua,
                               bairro: $bairro,
                               cidade: $cidade,
                               estado: $estado,
                               numero: $numero,
                               complemento: $complemento)
            }
            .scrollContentBackground(.hidden)
            
            Spacer()
            
            Button {
                Task {
                    await save()
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
            .frame(maxWidth: .infinity, maxHeight: 44.0)
            .disabled(nome.isEmpty && celular.isEmpty && email.isEmpty && cep.isEmpty)
            .foregroundColor(.white)
            .overlay {
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke(Color.white, lineWidth: 2.0)
            }
            .padding(.horizontal, 16.0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.blue.opacity(0.5))
        .foregroundColor(.gray)
        .navigationBarHidden(true)
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
    
    private func save() async {
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
    
    private func validateTitle() -> String {
        self.contact != nil ? "Alterar Contato" : "Novo Contato"
    }
}

#Preview {
    ContactView(contact: nil)
}
