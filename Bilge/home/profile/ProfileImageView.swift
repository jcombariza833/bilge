//
//  ProfileImageView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/21/21.
//

import SwiftUI

struct ProfileImageView: View {
    @EnvironmentObject var store: AppStore
    @State var showImagePicker: Bool = false
    @State var image: UIImage?
    
    //TODO: work with image storage for the profile picture
    var body: some View {
        VStack {
            if image == nil {
                Image(systemName: "person.fill")
                    .resizable()
                    .padding(.all, 25)
                    .foregroundColor(.blue)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.blue, lineWidth: 1))
                    .shadow(radius: 10)
                    .frame(width: 150, height: 150, alignment: .center)
                    
            } else {
                Image(uiImage: image!)
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.blue, lineWidth: 1))
                    .shadow(radius: 10)
                    .foregroundColor(.blue)
                    .aspectRatio(contentMode: .fit)
            }
            Button {
                showImagePicker.toggle()
            } label: {
                Text("Edit").font(.subheadline)
            }.sheet(isPresented: $showImagePicker) {
                ImagePickerView(sourceType: .photoLibrary) { image in
                    self.image = image
                }
            }
        }
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView()
    }
}
