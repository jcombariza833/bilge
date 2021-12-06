//
//  FileListView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 11/20/21.
//

import SwiftUI
import Firebase

struct FileData: Identifiable {
    var id = UUID()
    
    var name: String
    var path: String
}

struct FileListView: View {
    @State var data : Data?
    let files = [ FileData(name:"exam_review.pdf", path:"Indoividual Assignment - WorkContext Diagram JuanCombariza.pdf") ,
                FileData(name: "midterm_review.pdf", path: "Indoividual Assignment - WorkContext Diagram JuanCombariza.pdf"),
                FileData(name: "paper.pdf", path: "Indoividual Assignment - WorkContext Diagram JuanCombariza.pdf")]
    
    
    var body: some View {
        if files.isEmpty {
            Text("No files attached for this course")
        } else {
            List {
                ForEach(files) { file in
                    NavigationLink {
                        PDFKitRepresentedView(data ?? Data())
                            .onAppear {
                                let storage = Storage.storage()
                                let gsRef = storage.reference(withPath: file.path)
                                gsRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                                    if let error = error {
                                        // Uh-oh, an error occurred!
                                        print(error)
                                      } else {
                                        // Data for "images/island.jpg" is returned
                                          self.data = data
                                      }
                                }
                            }
                    } label: {
                        Text(file.name)
                    }
                }
            }
        }
    }
}

struct FileListView_Previews: PreviewProvider {
    static var previews: some View {
        FileListView()
    }
}
