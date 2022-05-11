//
//  TaskManagerHome.swift
//  HeeseonPlayground
//
//  Created by 강희선 on 2022/05/12.
//

import SwiftUI

struct TaskManagerHome: View {
    @StateObject var vm: TaskManagerViewModel
    @Namespace var animation
    
    init(_ vm: TaskManagerViewModel = .init()) {
        self._vm = .init(wrappedValue: vm)
    }
    var body: some View {
        NavigationView {
            content
                .navigationTitle("Task Manager")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var content: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Welcome Back")
                        .font(.callout)
                    Text("Here's update today")
                        .font(.title2.bold())
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)
                
                customSegmentedControl()
            }
            .padding()
        }
        .overlay(alignment: .bottom) {
            Button(
                action: {
                    vm.openEditTask = true
                },
                label: {
                    Label(
                        title: {
                            Text("Add Task")
                                .font(.callout)
                                .fontWeight(.semibold)
                        },
                        icon: {
                            Image(systemName: "plus.app.fill")
                        }
                    )
                    .foregroundColor(.white)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 12)
                    .background(.black, in: Capsule())
                }
            )
        }
        .fullScreenCover(
            isPresented: $vm.openEditTask,
            onDismiss: {
                vm.resetTask()
            },
            content: {
                AddNewTask()
                    .environmentObject(vm)
            })
    }
    
    // MARK: - custom Segmented Control
    func customSegmentedControl() -> some View {
        HStack(spacing: 10) {
            ForEach(TaskManagerViewModel.Tab.allCases, id: \.self) { tab in
                Text(tab.rawValue)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .scaleEffect(0.9)
                    .foregroundColor(vm.currentTab == tab ? .white : .black)
                    .padding(6)
                    .frame(maxWidth: .infinity)
                    .background {
                        if vm.currentTab == tab {
                            Capsule()
                                .fill(.black)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                    .contentShape(Capsule())
                    .onTapGesture {
                            vm.currentTab = tab
                    }
                    .animation(.easeOut, value: vm.currentTab)
            }
        }
    }
}

struct TaskManagerHome_Previews: PreviewProvider {
    static var previews: some View {
        TaskManagerHome()
    }
}
