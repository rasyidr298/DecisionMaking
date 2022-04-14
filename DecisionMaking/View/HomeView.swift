//
//  HomeView.swift
//  PuzzleKu
//
//  Created by Rasyid Ridla on 05/04/22.
//

import UIKit
import SwiftUI

struct HomeView: View {
    private var flexibleLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    @EnvironmentObject var viewModel: GoalsViewModel
    
    //search
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    
    @State private var isExtendGoals = true
    @State private var showAddView = false
    
    @FetchRequest(
      entity: Goals.entity(),
      sortDescriptors: [NSSortDescriptor(key: "lastUpdate", ascending: true)]
    ) var dataGoals: FetchedResults<Goals>
    
    @Environment(\.managedObjectContext) var context
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                VStack {
                    //search
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            
                            TextField("search", text: $searchText, onEditingChanged: {isEditing in
                                self.showCancelButton = true
                            }).foregroundColor(.primary)
                            
                            Button(action: {
                                self.searchText = ""
                            }, label: {
                                Image(systemName: "xmark.circle.fill")
                            })
                        }
                        .padding()
                        .foregroundColor(.secondary)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10.0)
                        
                        if showCancelButton {
                            Button("Cancel") {
                                UIApplication.shared.endEditing(true)
                                self.searchText = ""
                                self.showCancelButton = false
                            }
                            .foregroundColor(Color(UIColor.systemIndigo))
                        }
                    }
                    .padding([.top, .leading, .trailing])
                    .navigationBarHidden(showCancelButton)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        //desc pinned
                        HStack {
                            Text("Pinned")
                                .bold()
                                .font(.headline)
                            
                            Spacer()
                            
                            Button(action: {
                                withAnimation{
                                    self.isExtendGoals.toggle()
                                }

                            }, label: {
                                Image(systemName: isExtendGoals ? "chevron.down.circle.fill" : "chevron.right.circle.fill")
                                    .resizable()
                                    .foregroundColor(Color(UIColor.systemIndigo))
                                    .frame(width: 20, height: 20, alignment: .center)
                            })
                        }
                        .padding(EdgeInsets(top: 20, leading: 25, bottom: 0, trailing: 25))
                        
                        //list is Pin
                        if isExtendGoals == true && dataGoals.filter{$0.isPin}.count > 0{
                            VStack {
                                LazyVGrid(columns: flexibleLayout) {
                                    ForEach(
                                        searchText == "" ? dataGoals.filter{$0.isPin} :
                                            dataGoals.filter{($0.textGoals?.contains(searchText))! || searchText == ""}
                                    ) { data in
                                        GoalCard(dataGoal: data)
                                    }
                                }.padding()
                            }
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(20)
                            .padding(.horizontal, 20)
                        }
                        
                        //desc is not pinned
                        HStack {
                            Text("Goals")
                                .bold()
                                .font(.headline)
                                .padding(EdgeInsets(top: 20, leading: 25, bottom: 0, trailing: 25))
                            
                            Spacer()
                        }
                        
                        //list is not pin
                        VStack {
                            LazyVGrid(columns: flexibleLayout) {
                                ForEach(
                                    searchText == "" ? dataGoals.filter{!$0.isPin} :
                                        dataGoals.filter{$0.textGoals!.contains(searchText) || searchText == ""}
                                ) { data in
                                    GoalCard(dataGoal: data)
                                }
                            }.padding()
                        }
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(20)
                        .padding(.horizontal, 20)
                    }
                    .navigationTitle(Text("My Goals"))
                    .resignKeyboardOnDragGesture()
                }
                .padding(.bottom, 70.0)
                .sheet(isPresented: $showAddView, content: {
                    AddView(showAddView: $showAddView).environmentObject(viewModel)
                })
                
                Spacer()
                ZStack {
                    CustomShape(corner: .allCorners, radii: 0)
                        .background(Color(UIColor.systemGray6))
                        .foregroundColor(Color(UIColor.systemGray6))
                        .frame(width: UIScreen.screenWidth,height: 70, alignment: .center)
                    ZStack {
                        Text("\(dataGoals.count) Goals")
                            .font(.caption)
                            .foregroundColor(Color(UIColor.systemIndigo))
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                self.showAddView.toggle()
                            }, label: {
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .foregroundColor(Color(UIColor.systemIndigo))
                                    .frame(width: 20, height: 20)
                            })
                        }
                        .padding([.trailing], 30)
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .accentColor(Color(UIColor.systemIndigo))
        
    }
}


struct GoalCard: View {
    @State var dataGoal: Goals
    @Environment(\.managedObjectContext) var context
    @EnvironmentObject var viewModel: GoalsViewModel
    
    
    var body: some View {
        NavigationLink(destination: DetailView().environmentObject(dataGoal).environmentObject(viewModel)) {
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(dataGoal.lastUpdate ?? Date.now, style: .date)
                                .foregroundColor(Color(UIColor.systemIndigo))
                                .font(.caption2)
                                .lineLimit(1)
                                .padding([.top, .leading, .trailing], 10.0)
                            
                            Text(dataGoal.textGoals ?? "")
                                .foregroundColor(Color.primary)
                                .font(.footnote)
                                .lineLimit(3)
                                .padding(EdgeInsets(top: 1, leading: 10, bottom: 0, trailing: 10))
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
            .background(RoundedRectangle(cornerRadius: 20))
            .foregroundColor(Color(UIColor.systemGray5))
            .contextMenu{
                Button(action: {
                    self.viewModel.pinGoals(goal: dataGoal, context: context)
                }, label: {
                    Text(dataGoal.isPin ? "Unpin Note" : "Pin Note")
                    Image(systemName: dataGoal.isPin ? "pin.slash" : "pin")
                })
                
                Button(action: {
                    DecisionMaking.shareSheet(content: [dataGoal.textGoals!, String(dataGoal.countOption)])
                }, label: {
                    Text("Send a Copy")
                    Image(systemName: "square.and.arrow.up")
                })
                
                Divider()
                
                Button(role: .destructive, action: {
                    context.delete(dataGoal)
                    try! context.save()
                }, label: {
                    Text("Delete")
                    Image(systemName: "trash")
                })
            }
    }
}


struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView().environmentObject(GoalsViewModel())
            .preferredColorScheme(.dark)
    }
}
