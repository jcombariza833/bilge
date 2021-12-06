//
//  Reducer.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 10/2/21.
//

import Foundation
import Firebase

func appReducer(state: inout AppState, action: AppAction) -> Void {
    switch action {
    case .registration(let signUpAction):
        signUpReducer(state: &state.session, action: signUpAction)
    case .login(let signInAction):
        signInReducer(state: &state.session, action: signInAction)
    case .session(let sessionAction):
        sessionReducer(state: &state.session, action: sessionAction)
    case .resetPassword(let forgotPasswordAction):
        forgotPasswordReducer(state: &state.forgotPassword, action: forgotPasswordAction)
    case .api(let apiAction):
        apiReducer(state: &state, action: apiAction)
    case .updatePassword(let action):
        updatePasswordReducer(state: &state, action: action)
    }
}

func sessionReducer(state: inout SessionState, action: SessionAction) -> Void {
    switch action {
    case .token(_):
        break
    case .tokenUpdated(let token):
        state.token = token
        UserDefaults.standard.set(token, forKey: "token")
    case .tokenError(_):
        state.token = ""
        state.uid = ""
    case .signOut:
        state.token = ""
        state.uid = ""
    case .signOutSuccess:
        state.token = ""
        state.uid = ""
    case .signOutError( _ ):
        break
    }
}

func updatePasswordReducer(state: inout AppState, action: UpdatePasswordAction) -> Void {
    switch action {
    case .fetch( _ ):
        state.forgotPassword.fetchInUpdateProgress = true
        state.forgotPassword.fetchUpdateError = nil
    case .fetchSuccess:
        state.forgotPassword.fetchInUpdateProgress = false
    case .fetchError(let errorMessage):
        state.forgotPassword.fetchInUpdateProgress = false
        state.forgotPassword.fetchUpdateError = errorMessage
    }
}

func apiReducer(state: inout AppState, action: ApiAction) -> Void {
    switch action {
    case .updateRole(let action):
        apiUpdateRoleReducer(state: &state, action: action)
    case .getInstructor(let action):
        apiInstructorReducer(state: &state.api, action: action)
    case .updateProfile(let action):
        apiUpdateProfileReducer(state: &state.api, action: action)
    case .getStudent(let action):
        apiStudentReducer(state: &state.api, action: action)
    case .createCourse(let action):
        apiCreateCourseReducer(state: &state.api, action: action)
    case .deleteCourse(let action):
        apiDeleteCourseReducer(state: &state.api, action: action)
    case .createSection(let action):
        apiCreateSectionReducer(state: &state.api, action: action)
    case .deleteSection(let action):
        apiDeleteSectionReducer(state: &state.api, action: action)
    case .getInstructors(let action):
        apiInstructorsReducer(state: &state.api, action: action)
    case .getInstructorByName(let action):
        apiInstructorByNameReducer(state: &state.api, action: action)
    case .enrollClass(let action):
        apiEnrollReducer(state: &state.api, action: action)
    case .unenrollClass(let action):
        apiUnenrollReducer(state: &state.api, action: action)
    }
}

func apiUpdateRoleReducer(state: inout AppState, action: UpdateRoleAction) -> Void {
    switch action {
    case .update(let role):
        state.session.role = role
    case .success(_):
        break
    case .error(_):
        break
    }
}

func apiInstructorReducer(state: inout APIState, action: InstructorAction) -> Void {
    switch action {
    case .get:
        break
    case .success(let instructor):
        state.instructor = instructor
    case .error(_):
        break
    }
}

func apiStudentReducer(state: inout APIState, action: StudentAction) -> Void {
    switch action {
    case .get:
        break
    case .success(let student):
        state.student = student
    case .error(_):
        break
    }
}

func apiUpdateProfileReducer(state: inout APIState, action: UpdateProfileAction) -> Void {
    switch action {
    case .update(_):
        state.updateProfile.fetchInProgress = true
        state.updateProfile.fetchError = nil
    case .success(_):
        state.updateProfile.fetchInProgress = false
    case .error(let error):
        state.updateProfile.fetchInProgress = false
        state.updateProfile.fetchError = error
    }
}

func apiCreateCourseReducer(state: inout APIState, action: CreateCourseAction) -> Void {
    switch action {
    case .create(_):
        state.createCourseInProgress = true
        state.createCourseError = nil
    case .success(_):
        state.createCourseInProgress = false
    case .error(let error):
        state.createCourseInProgress = false
        state.createCourseError = error
    }
}

func apiDeleteCourseReducer(state: inout APIState, action: DeleteCourseAction) -> Void {
    switch action {
    case .delete(_):
        break
    case .success(_):
        break
    case .error(_):
        break
    case .internalDelete(let offsets):
        state.instructor?.courses.remove(atOffsets: offsets)
    }
}

func apiCreateSectionReducer(state: inout APIState, action: CreateSectionAction) -> Void {
    switch action {
    case .create(_,_):
        state.createSectionInProgress = true
        state.createSectionError = nil
    case .success(_):
        state.createSectionInProgress = false
    case .error(let error):
        state.createSectionInProgress = false
        state.createSectionError = error
    }
}

func apiDeleteSectionReducer(state: inout APIState, action: DeleteSectionAction) -> Void {
    switch action {
    case .delete(_, _):
        break
    case .success(_):
        break
    case .error(_):
        break
    case .internalDelete(let offsets, let courseCode):
        let course = state.instructor?.courses.first { $0.code == courseCode } ?? CourseM()
        let index = state.instructor?.courses.firstIndex { $0.code == course.code} ?? 0
        state.instructor?.courses[index].sections.remove(atOffsets: offsets)
    }
}

func apiInstructorsReducer(state: inout APIState, action: InstructorsAction) -> Void {
    switch action {
    case .get:
        break
    case .success(let instructors):
        state.instructors = instructors
    case .error(_):
        break
    }
}

func apiInstructorByNameReducer(state: inout APIState, action: InstructorByNameAction) -> Void {
    switch action {
    case .get(_):
        break
    case .success(let instructor):
        state.selectedInstructor = instructor
    case .error(_):
        break
    }
}

func apiEnrollReducer(state: inout APIState, action: EnrollAction) -> Void {
    switch action {
    case .enroll(_, _, _):
        state.enrollError = nil
        state.enrrolInProgress = true
    case .success(_):
        state.enrrolInProgress = false
    case .error(let error):
        state.enrollError = error
        state.enrrolInProgress = false
    }
}

func apiUnenrollReducer(state: inout APIState, action: UnenrollAction) -> Void {
    switch action {
    case .unenroll(_):
        state.unenrollError = nil
        state.unenrrolInProgress = true
    case .success(_):
        state.unenrrolInProgress = false
    case .error(let error):
        state.unenrollError = error
        state.unenrrolInProgress = false
    }
}
