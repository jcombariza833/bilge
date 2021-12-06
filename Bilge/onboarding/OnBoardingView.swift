//
//  OnBoardingView.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 9/15/21.
//

import SwiftUI

struct OnBoardingView: View {
    @EnvironmentObject var store: AppStore
    
    var body: some View {
        if store.state.session.singIn.fetchInProgress {
            ProgressView()
        } else {
            SignInView()
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
