//
//  AddressSection.swift
//  FirebaseInfiniteScroll
//
//  Created by Sandler Maciel on 01/06/25.
//

import SwiftUI

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
