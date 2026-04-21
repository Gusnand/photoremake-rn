import SwiftUI

struct CollectionView: View {
  let rows = [GridItem(.flexible(), spacing: 1)]
  let images = (10...20).map {"photo_\($0)"}
  
  var body: some View {
    NavigationStack{
      VStack (alignment: .leading, spacing: 14){
        ScrollView{
          
          DisclosureGroup("Memories") {
            ScrollView(.horizontal, showsIndicators: false) {
              HStack(spacing: 6){
                ForEach(images, id: \..self) {image in
                  Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(height:180)
                    .overlay(){
                      LinearGradient(
                        colors: [.clear, .black.opacity(0.6)],
                        startPoint: .center,
                        endPoint: .bottom,
                      )
                      
                      
                      //                      Text("Whatsapp").font(.caption).foregroundStyle(.white).fontWeight(.regular).padding(8)
                      //                        .frame(maxWidth: .infinity, alignment: .leading)
                      //                        .background(LinearGradient(
                      //
                      //                          colors: [.clear, .black.opacity(0.7)], startPoint: .top, endPoint: .bottom
                      //                        ))
                      //                        .clipShape(RoundedRectangle(cornerRadius: 48))
                    }
                    .overlay(alignment: .bottomLeading){
                      Text("WhatsApp").font(.subheadline).fontWeight(.semibold).foregroundStyle(.white).padding(12)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
              }
            }
          }.listStyle(.plain).foregroundStyle(.primary)
          
          DisclosureGroup("Pinned") {
            ScrollView(.horizontal, showsIndicators: false) {
              HStack(spacing: 5){
                ForEach(images, id: \..self) {image in
                  Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(height:120)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .overlay(alignment: .bottomLeading){
                      Text("Whatsapp").font(.caption).foregroundStyle(.white).fontWeight(.regular).padding(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(LinearGradient(
                          
                          colors: [.clear, .black.opacity(0.7)], startPoint: .top, endPoint: .bottom
                        ))
                    }
                }
              }
            }
          }.listStyle(.plain).foregroundStyle(.primary)
          
          DisclosureGroup("Albums") {
            ScrollView(.horizontal, showsIndicators: false) {
              HStack(spacing: 5){
                ForEach(images, id: \..self) {image in
                  Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(height:120)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .overlay(alignment: .bottomLeading){
                      Text("Whatsapp").font(.caption).foregroundStyle(.white).fontWeight(.regular).padding(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(LinearGradient(
                          
                          colors: [.clear, .black.opacity(0.7)], startPoint: .top, endPoint: .bottom
                        ))
                    }
                }
              }
            }
          }.listStyle(.plain).foregroundStyle(.primary)
          
          DisclosureGroup("People") {
            ScrollView(.horizontal, showsIndicators: false) {
              HStack(spacing: 5){
                ForEach(images, id: \..self) {image in
                  Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(height:120)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .overlay(alignment: .bottomLeading){
                      Text("Whatsapp").font(.caption).foregroundStyle(.white).fontWeight(.regular).padding(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(LinearGradient(
                          
                          colors: [.clear, .black.opacity(0.7)], startPoint: .top, endPoint: .bottom
                        ))
                    }
                }
              }
            }
          }.listStyle(.plain).foregroundStyle(.primary)
          
          DisclosureGroup("Featured Photos") {
            ScrollView(.horizontal, showsIndicators: false) {
              HStack(spacing: 5){
                ForEach(images, id: \..self) {image in
                  Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(height:120)
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .overlay(alignment: .bottomLeading){
                      Text("Whatsapp").font(.caption).foregroundStyle(.white).fontWeight(.regular).padding(8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(LinearGradient(
                          
                          colors: [.clear, .black.opacity(0.7)], startPoint: .top, endPoint: .bottom
                        ))
                    }
                }
              }
            }
          }.listStyle(.plain).foregroundStyle(.primary)
        }.scrollIndicators(.hidden)
        
          .navigationTitle("Collection")
          .toolbarTitleDisplayMode(.inlineLarge)
          .toolbar{
            ToolbarItem(placement: .topBarTrailing){
              Menu {
                ControlGroup {
                  Button {
                    // action
                  } label :{
                    Image(systemName: "rectangle.grid.3x1.fill")
                  }
                  Button {
                    // action
                  } label :{
                    Image(systemName: "rectangle.grid.3x3.fill")
                  }
                  Button {
                    // action
                  } label :{
                    Image(systemName: "rectangle.grid.2x2.fill")
                  }
                }
                
                Button("Show All", systemImage: "") {
                  // action
                }
                Button("Collapse All", systemImage: "") {
                  // action
                }
                Divider()
                Button ("Reorder", systemImage: "") {
                  // action
                }
              } label: {
                Image(systemName: "ellipsis")
              }
              
              
            }
            ToolbarSpacer(placement: .topBarTrailing)
            ToolbarItem(placement: .primaryAction){
              Button(action: {
                //action
              }) {
                Image(systemName: "person.fill")
              }.buttonStyle(.bordered)
            }
          }
        
      }.padding()
    }.preferredColorScheme(.dark)
    
  }
}

#Preview {
  CollectionView()
}
