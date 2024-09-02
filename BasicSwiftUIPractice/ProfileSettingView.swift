//
//  ProfileSettingView.swift
//  BasicSwiftUIPractice
//
//  Created by Joy Kim on 9/2/24.
//

import SwiftUI

struct MBTIModel: Hashable, Identifiable {
    let id = UUID()
    let title: String
}

struct ProfileSettingView: View {
    
    @State private var username: String = ""
    @State private var selectedItems: Set<MBTIModel> = []
    @State private var isSheetPresented = false
    
    var isStartButtonEnabled: Bool {
        !username.isEmpty && selectedItems.count == 4
    }
    
    let mbtiModels: [MBTIModel] = [
        MBTIModel(title: "E"),
        MBTIModel(title: "S"),
        MBTIModel(title: "T"),
        MBTIModel(title: "J"),
        MBTIModel(title: "I"),
        MBTIModel(title: "N"),
        MBTIModel(title: "F"),
        MBTIModel(title: "P")
    ]
    
    var body: some View {
        VStack {
            NavigationLink {
                ProfileImageSettingView()
            } label: {
                Image("profile_11")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.blue, lineWidth: 5))
                    .overlay(
                        Circle()
                            .fill(.blue)
                            .frame(width: 25, height: 25)
                            .overlay(
                                Image(systemName: "camera.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.white)
                            )
                            .offset(x: 40, y: 30)
                    )
            }
            .padding(.top, 100)
            
            TextField("닉네임을 입력해주세요 :)", text: $username)
                .padding(.init(top: 40, leading: 40, bottom: -5, trailing: 40))
            
            Rectangle()
                .frame(height: 0.5)
                .padding(10)
                .foregroundColor(.gray.opacity(0.3))
            
            HStack {
                Text("MBTI")
                    .font(.headline)
                    .padding(30)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 10) {
                        ForEach(mbtiModels.prefix(4)) { model in
                            mbtiView(model)
                                .onTapGesture {
                                    self.handleSelection(model)
                                }
                        }
                    }
                    HStack(spacing: 10) {
                        ForEach(mbtiModels.suffix(4)) { model in
                            mbtiView(model)
                                .onTapGesture {
                                    self.handleSelection(model)
                                }
                        }
                    }
                }
                .padding(20)
                .offset(CGSize(width: 0.0, height: 50.0))
                
            }
            
            Spacer()
            
            Button("시작하기") {
                isSheetPresented = true
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 300, height: 40)
            .background(isStartButtonEnabled ? Color.blue : Color.gray)
            .cornerRadius(25)
            .disabled(!isStartButtonEnabled )
            .padding(.top, 100)
            .sheet(isPresented: $isSheetPresented) {
                LoadingCompleteView()
            }
            
        }
        .navigationTitle("Profile Setting")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func mbtiView(_ model: MBTIModel) -> some View {
        Circle()
            .stroke(.gray, lineWidth: 1)
            .fill(self.selectedItems.contains(model) ? Color.blue : Color.white)
            .frame(width: 50, height: 50)
            .overlay(
                Text(model.title)
                    .foregroundColor(self.selectedItems.contains(model) ? .white : .gray)
                    .font(.headline)
            )
    }
    
    private func handleSelection(_ model: MBTIModel) {
        
        if selectedItems.contains(model) {
            selectedItems.remove(model)
        } else {
            let nonCoexistableValue: [[String]] = [
                ["E", "I"],
                ["S", "N"],
                ["T", "F"],
                ["J", "P"]
            ]
            
            for values in nonCoexistableValue {
                if values.contains(model.title) {
                    if let otherTitle = values.first(where: { $0 != model.title }) {
                        if let otherModel = mbtiModels.first(where: { $0.title == otherTitle }) {
                            selectedItems.remove(otherModel)
                        }
                    }
                }
            }
            
            selectedItems.insert(model)
        }
    }
}

#Preview {
    ProfileSettingView()
}
