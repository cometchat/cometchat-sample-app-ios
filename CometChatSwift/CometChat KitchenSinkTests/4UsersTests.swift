//
//  CometChat3UsersTests.swift
//  CometChatProTests
//
//  Created by Inscripts11 on 19/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

import XCTest
import CometChatPro

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////  COMETCHATPRO: USERS TEST CASES   /////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////

class CometChat4UsersTests: XCTestCase {
    
////////////////////////////////////////////////////////////////////////////////////////////
    
////////////////////////////// COMETCHATPRO: GET LOGGED IN USER ////////////////////////////
    
//func test001GetLoggedInUserDetails() {
//
//    let expectation = self.expectation(description: "Getting Logged in user's details")
//
//        let user = CometChat.getLoggedInUser()
//        userIsValid(user: user!)
//        print("user is: \(String(describing: user?.stringValue()))")
//        if user != nil {
//            XCTAssertNotNil(user)
//            expectation.fulfill()
//    }
//    wait(for: [expectation], timeout: 10)
//}

////////////////////////////////////////////////////////////////////////////////////////////
    
///////////////////////////////// COMETCHATPRO: FETCH USERS ////////////////////////////////
    
    
    func test002GetUserListWithInvalidLimit() {
        
        let expectation = self.expectation(description: "Get list of users with invalid limit.")
        
        let _userListRequest = UsersRequest.UsersRequestBuilder(limit: 1000).build()
        
        _userListRequest.fetchNext(onSuccess: { (userList) in
            
            print("getUserListWithInvalidLimit onSuccess: \(userList)")

        }) { (error) in
            
            print("getUsersListWithInvalidLimit error : \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)

            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
    }
    

    
    func test003GetUserListWithValidLimit() {
        
        let expectation = self.expectation(description: "Get list of users with valid limit.")
        
        var _userList : [User]?
        
        let _userListRequest = UsersRequest.UsersRequestBuilder(limit: 30).build()
        
        _userListRequest.fetchNext(onSuccess: { (userList) in
            
            validateUserList(user: userList, isRole: false)
            _userList = userList
            
            print("user list with limit 30 fetch successfully: \(userList)")
            
            XCTAssertNotNil(_userList)

            expectation.fulfill()
            
        }) { (error) in
            
            print("getUsersListWithValidLimit error : \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test004GetUserListbySearchKeyword() {
        
        let expectation = self.expectation(description: "Get list of users with search keyword.")
        
        var _userList : [User]?
        
        let _userListRequest = UsersRequest.UsersRequestBuilder(limit: 30).set(searchKeyword: "superhero5").build()
        
        _userListRequest.fetchNext(onSuccess: { (userList) in
            validateUserList(user: userList, isRole: false)
            _userList = userList
            
            print("getUserListbySearchKeyword successful \(userList)")
            
            XCTAssertNotNil(_userList)
            
            expectation.fulfill()
            
        }) { (error) in
            
            print("getUserListbySearchKeyword error : \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test005GetUserListbySearchKeywordEmpty() {
        
        let expectation = self.expectation(description: "Get list of users with search keyword.")
        
        var _userList : [User]?
        
        let _userListRequest = UsersRequest.UsersRequestBuilder(limit: 30).set(searchKeyword: "").build()
        
        _userListRequest.fetchNext(onSuccess: { (userList) in
            
            _userList = userList
            
            print("getUserListbySearchKeywordEmpty successful \(userList)")
            
            XCTAssertNotNil(_userList)
            
            expectation.fulfill()
            
        }) { (error) in
            
            print("getUserListbySearchKeywordEmpty error : \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test006GetUserListbySearchKeywordInvalid() {
        
        let expectation = self.expectation(description: "Get list of users with search invalid keyword.")
        
        var _userList : [User]?
        
        let _userListRequest = UsersRequest.UsersRequestBuilder(limit: 30).set(searchKeyword: "Invalid").build()
        
        _userListRequest.fetchNext(onSuccess: { (userList) in
            
            _userList = userList
            
            print("GetUserListbySearchKeywordInvalid successful \(userList)")
            
            XCTAssertNotNil(_userList)
            
            expectation.fulfill()
            
        }) { (error) in
            
            print("GetUserListbySearchKeywordInvalid error : \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test007GetUserListWithLimitZero() {
        // FIXME: Test case is failing because showing the userlist event after limit of 0
        let expectation = self.expectation(description: "Get list of users with limit 0.")
        
        let _userListRequest = UsersRequest.UsersRequestBuilder(limit:0).build()
        
        _userListRequest.fetchNext(onSuccess: { (userList) in
            
            print("getUserListWithLimitZero successful \(userList)")
            
          
            
        }) { (error) in
            
            print("getUserListWithLimitZero error : \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test008GetUserListWithMinusLimit() {
        
        let expectation = self.expectation(description: "Get list of users with limit -1.")
        
        let _userListRequest = UsersRequest.UsersRequestBuilder(limit:-1).build()
        
        _userListRequest.fetchNext(onSuccess: { (userList) in
            
            print("getUserListWithMinusLimit successful \(userList)")

        }) { (error) in
            print("getUserListWithMinusLimit error : \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30)
    }
    
    
    func test009GetUserListFilteredByStatusOnline() {
        
        let expectation = self.expectation(description: "Get list of users by status  online.")
        
        var _userList : [User]?
        
        let _userListRequest = UsersRequest.UsersRequestBuilder(limit: 30).set(status: .online).build()
        
        _userListRequest.fetchNext(onSuccess: { (userList) in
            validateUserList(user: userList, isRole: false)
            _userList = userList
            
            print("getUserListFilteredByStatusOnline successful: \(userList)")
            
            XCTAssertNotNil(_userList)
            
            expectation.fulfill()
            
        }) { (error) in
            
            print("getUserListFilteredByStatusOnline error : \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 30)
    }
    

    
    func test010GetUserListFilteredByHideBlockedUsers() {
        
        let expectation = self.expectation(description: "Get list of users by status  online.")
        
        var _userList : [User]?
        
        let _userListRequest = UsersRequest.UsersRequestBuilder(limit: 30).hideBlockedUsers(true).build()
        
        _userListRequest.fetchNext(onSuccess: { (userList) in
            validateUserList(user: userList, isRole: false)
            _userList = userList
            
            print("getUserListFilteredByHideBlockedUsers successful: \(userList)")
            
            XCTAssertNotNil(_userList)
            
            expectation.fulfill()
            
        }) { (error) in
            
            print("getUserListFilteredByHideBlockedUsers error : \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    
    func test011GetUserListFilteredByHideBlockedUsersFalse() {
        
        let expectation = self.expectation(description: "test9_GetUserListFilteredByHideBlockedUsersFalse")
        var _userList : [User]?
        let _userListRequest = UsersRequest.UsersRequestBuilder(limit: 30).hideBlockedUsers(false).build()
        _userListRequest.fetchNext(onSuccess: { (userList) in
            validateUserList(user: userList, isRole: false)
            _userList = userList
            print("getUserListFilteredByHideBlockedUsers successful: \(userList)")
             XCTAssertNotNil(_userList)
            expectation.fulfill()
            
        }) { (error) in
            print("getUserListFilteredByHideBlockedUsers error : \(String(describing: error?.errorDescription))")
        }
       wait(for: [expectation], timeout: 30)
    }
    
    func test012GetUserListFilteredByHideBlockedUsersAndStatusOnline() {
        
        let expectation = self.expectation(description: "Get list of users by status  online.")
        
        var _userList : [User]?
        
        let _userListRequest = UsersRequest.UsersRequestBuilder(limit: 30).hideBlockedUsers(true).set(status: .online).build()
        
        _userListRequest.fetchNext(onSuccess: { (userList) in
            validateUserList(user: userList, isRole: false)
            _userList = userList
            
            print("getUserListFilteredByHideBlockedUsersAndStatusOnline successful: \(userList)")
            
            XCTAssertNotNil(_userList)
            
            expectation.fulfill()
            
        }) { (error) in
            
            print("getUserListFilteredByHideBlockedUsersAndStatusOnline error : \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    
    func test013GetUserListFilteredByHideBlockedUsersAndStatusOffline() {
        
        let expectation = self.expectation(description: "Get list of users by status  online.")
        
        var _userList : [User]?
        
        let _userListRequest = UsersRequest.UsersRequestBuilder(limit: 30).hideBlockedUsers(true).set(status: .offline).build()
        
        _userListRequest.fetchNext(onSuccess: { (userList) in
            validateUserList(user: userList, isRole: false)
            _userList = userList
            
            print("getUserListFilteredByHideBlockedUsersAndStatusOffline successful: \(userList)")
            
            XCTAssertNotNil(_userList)
            
            expectation.fulfill()
            
        }) { (error) in
            
            print("getUserListFilteredByHideBlockedUsersAndStatusOffline error : \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    
    func test014GetUserListFilteredByStatusOffline() {
        
        let expectation = self.expectation(description: "Get list of users by status offline")
        
        var _userList : [User]?
        
        let _userListRequest = UsersRequest.UsersRequestBuilder(limit: 30).set(status: .offline).build()
        
        _userListRequest.fetchNext(onSuccess: { (userList) in
            validateUserList(user: userList, isRole: false)
            _userList = userList
            
            print("getUserListFilteredByStatusOffline successful: \(userList)")
            
            XCTAssertNotNil(_userList)
            
            expectation.fulfill()
            
        }) { (error) in
            
            print("getUserListFilteredByStatusOffline error : \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test015GetUserListWithoutLimit() {
        
        let expectation = self.expectation(description: "Get list of users without limit.")
        
        var _userList : [User]?
        
        let _userListRequest = UsersRequest.UsersRequestBuilder().build()
        
        _userListRequest.fetchNext(onSuccess: { (userList) in
            validateUserList(user: userList, isRole: false)
            _userList = userList
            
            print("user list with no limit  fetch successfully: \(userList)")
            
            XCTAssertNotNil(_userList)
            
            expectation.fulfill()
            
        }) { (error) in
            
            print("getUsersListWithoutLimit error : \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 30)
    }

////////////////////////////////////////////////////////////////////////////////////////////
    
////////////////////////////// COMETCHATPRO: GET USERS INFO ////////////////////////////////
    
    
    func test016GetUserInfo() {
        
        let expectation = self.expectation(description: "Get User's Information")
        
        var _user : User?
        
        CometChat.getUser(UID: TestConstants.user2, onSuccess: { (user) in
            
            _user = user
            XCTAssertEqual(user?.uid, TestConstants.user2)
            print("getUserInfo  onSuccess: \(String(describing: user?.stringValue()))")
            
            XCTAssertNotNil(_user)
            
            expectation.fulfill()
            
        }) { (error) in
            
            print("getUserInfo error : \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test017GetUserInfoWithInvalidUID() {
        
        let expectation = self.expectation(description: "Get User's Information with invalid UID")
        
        CometChat.getUser(UID: "InvalidUID", onSuccess: { (user) in
            
            print("getUserInfoWithInvalidUID onSuccess: \(String(describing: user?.stringValue()))")
            
        }) { (error) in
            
            print("getUserInfoWithInvalidUID error : \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)

            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test018GetUserInfoWithEmptyUID() {
        
        let expectation = self.expectation(description: "Get User's Information with empty UID")
        
        CometChat.getUser(UID: "", onSuccess: { (user) in
            
            print("getUserInfoWithEmptyUID onSuccess: \(String(describing: user?.stringValue()))")
            
        }) { (error) in
            
            print("getUserInfoWithEmptyUID error: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)

            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
////////////////////////////////////////////////////////////////////////////////////////////
    
/////////////////////////// COMETCHATPRO:  BLOCK USERS /////////////////////////////////////
    
    func test019BlockUsersWithEmptyUsersArray(){
        
        let expectation = self.expectation(description: "test Block User With Empty Users Array")
        
        let blockUsers:[String] = [String]()
        
        CometChat.blockUsers(blockUsers, onSuccess: { (sucess) in
            
             print("blockUserWithEmptyUsersArray onSuccess: \(String(describing: sucess))")
            
        }) { (error) in
            
            print("blockUserWithEmptyUsersArray error: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30)
    }
    
    func test020BlockUsersWithValidUsersArray(){
        
        let expectation = self.expectation(description: "test Block User With Valid Users Array")
        
        let blockUsers:[String] = [TestConstants.user2]
        
        CometChat.blockUsers(blockUsers, onSuccess: { (sucess) in
            
            print("blockUsersWithValidUsersArray onSuccess: \(String(describing: sucess))")
           
            XCTAssertNotNil(sucess)
            
            expectation.fulfill()
            
        }) { (error) in
            
            print("blockUsersWithValidUsersArray error: \(String(describing: error?.errorDescription))")
 
        }
        wait(for: [expectation], timeout: 30)
    }
    
////////////////////////////////////////////////////////////////////////////////////////////
    
/////////////////////////// COMETCHATPRO:  UNBLOCK USERS ///////////////////////////////////
    
    func test021UnblockUsersWithEmptyUsersArray(){
        
        let expectation = self.expectation(description: "test Unblock User With Empty Users Array")
        
        let unblockUsers:[String] = [String]()
        
        CometChat.unblockUsers(unblockUsers, onSuccess: { (sucess) in
            
            print("unblockUsersWithEmptyUsersArray onSuccess: \(String(describing: sucess))")
            
        }) { (error) in
            
            print("unblockUsersWithEmptyUsersArray error: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30)
    }
    
    func test022UnblockUsersWithValidUsersArray(){
        
        let expectation = self.expectation(description: "test Unblock User With Empty Users Array")
        
        let unblockUsers:[String] = [TestConstants.user2]
        
        CometChat.unblockUsers(unblockUsers, onSuccess: { (sucess) in
            
            print("unblockUsersWithValidUsersArray onSuccess: \(String(describing: sucess))")
            
            XCTAssertNotNil(sucess)
            
            expectation.fulfill()
            
        }) { (error) in
            
            print("unblockUsersWithValidUsersArray error: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 30)
    }
    
 ////////////////////////////////////////////////////////////////////////////////////////////
    
 /////////////////////////// COMETCHATPRO: FETCH BLOCK USERS //////////////////////////////
    
    func test023GetBlockedUsersListWithValidLimit(){
        
        let expectation = self.expectation(description: "Get list of blockedUsers with valid limit.")
        var _userList : [User]?
        let blockedUsers = BlockedUserRequest.BlockedUserRequestBuilder(limit: 100).build()
      
        blockedUsers.fetchNext(onSuccess: { (blockedUsers) in
            _userList = blockedUsers
            validateUserList(user: blockedUsers!, isRole: false)
            print("getBlockedUsersListWithValidLimit successfull: \(String(describing: blockedUsers))")
            
            XCTAssertNotNil(_userList)
            expectation.fulfill()
            
        }) { (error) in
            
               print("getBlockedUsersListWithValidLimit error : \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 30)
    }
    
    
    func test024GetBlockedUsersListWithDirection(){
        
        let expectation = self.expectation(description: "Get list of blockedUsers with valid limit.")
        var _userList : [User]?
        let blockedUsers = BlockedUserRequest.BlockedUserRequestBuilder(limit: 100).set(direction: .byMe).build()
        
        blockedUsers.fetchNext(onSuccess: { (blockedUsers) in
            _userList = blockedUsers
            validateUserList(user: blockedUsers!, isRole: false)
            print("getBlockedUsersListWithValidLimit successfull: \(String(describing: blockedUsers))")
            
            XCTAssertNotNil(_userList)
            expectation.fulfill()
            
        }) { (error) in
            
            print("getBlockedUsersListWithValidLimit error : \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 30)
    }
    
    
    
    func test025GetBlockedUsersListWithLimitZero(){
        
        let expectation = self.expectation(description: "Get list of blockedUsers with limit zero.")
        var _userList : [User]?
        let blockedUsers = BlockedUserRequest.BlockedUserRequestBuilder(limit: 0).build()
        
        blockedUsers.fetchNext(onSuccess: { (blockedUsers) in
            _userList = blockedUsers
            
            print("getBlockedUsersListWithLimitZero successfull: \(String(describing: blockedUsers))")
            
          
        }) { (error) in
            
            print("getBlockedUsersListWithLimitZero error : \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 30)
    }
    
    func test026GetBlockedUsersListWithLimitMinus(){
        
        let expectation = self.expectation(description: "Get list of blockedUsers with limit minus.")
        let blockedUsers = BlockedUserRequest.BlockedUserRequestBuilder(limit: -1).build()

        blockedUsers.fetchNext(onSuccess: { (blockedUsers) in

            print("getBlockedUsersListWithLimitMinus successful: \(String(describing: blockedUsers))")

        }) { (error) in

            print("getBlockedUsersListWithLimitMinus error: \(String(describing: error?.errorDescription))")

            XCTAssertNotNil(error)
            expectation.fulfill()
        }
       wait(for: [expectation], timeout: 10)
    }
    
     
    func test027GetBlockedUsersListWithInValidLimit(){
        
        let expectation = self.expectation(description: "Get list of blockedUsers with Invalid limit.")

        let blockedUserRequest = BlockedUserRequest.BlockedUserRequestBuilder(limit: 500).build()

        blockedUserRequest.fetchNext(onSuccess: { (blockedUsers) in

            print("getBlockedUsersListWithInValidLimit successful: \(String(describing: blockedUsers))")

        }) { (error) in

            print("getBlockedUsersListWithInValidLimit error : \(String(describing: error?.errorDescription))")

            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30)
   }
    
    ///////////////////////////////////////////////////////////////////////////////////////////

     /////////////////////////// COMETCHATPRO: FETCH  USERS WITH ROLE //////////////////////////////


    func test001GetUserListWithValidRoleLimit() {
        
        let expectation = self.expectation(description: "Get list of users with valid role.")
        
        let _userListRequest = UsersRequest.UsersRequestBuilder(limit: 30).set(role: "default").build()
        
        _userListRequest.fetchNext(onSuccess: { (userList) in
            
            validateUserList(user: userList, isRole: true)
            
            print("test001GetUserListWithValidRoleLimit onSuccess: \(userList)")
            expectation.fulfill()
        }) { (error) in
            
            print("test001GetUserListWithValidRoleLimit error : \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)

            
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test002GetUserListWithEmptyRoleLimit() {
        
        let expectation = self.expectation(description: "Get list of users with empty role.")
        
        let _userListRequest = UsersRequest.UsersRequestBuilder(limit: 30).set(role: "").build()
        
        _userListRequest.fetchNext(onSuccess: { (userList) in
            
            validateUserList(user: userList, isRole: false)
            print("test002GetUserListWithEmptyRoleLimit onSuccess: \(userList)")
            
            expectation.fulfill()
        }) { (error) in
            
            print("test002GetUserListWithEmptyRoleLimit error : \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test003GetUserListWithInvalidRoleLimit() {
        
        let expectation = self.expectation(description: "Get list of users with Invalid role.")
        
        let _userListRequest = UsersRequest.UsersRequestBuilder(limit: 30).set(role: "INVALID").build()
        
        _userListRequest.fetchNext(onSuccess: { (userList) in
            
            print("test003GetUserListWithInvalidRoleLimit onSuccess: \(userList)")
            
            if userList.count > 0 {
                
                validateUserList(user: userList, isRole: true)
            }
            
            expectation.fulfill()
        }) { (error) in
            
            print("test003GetUserListWithInvalidRoleLimit error : \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test004GetUserListWithValidRoles() {
        
        let expectation = self.expectation(description: "Get list of users with Valid roles.")
        
        let _userListRequest = UsersRequest.UsersRequestBuilder(limit: 30).set(roles: ["Premium","Diamond"]).build()
        
        _userListRequest.fetchNext(onSuccess: { (userList) in
            
            print("test004GetUserListWithValidRoles onSuccess: \(userList)")
            
            if userList.count > 0 {
                
                validateUserList(user: userList, isRole: true)
            }
            
            expectation.fulfill()
        }) { (error) in
            
            print("test004GetUserListWithValidRoles error : \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 30)
    }
    
    func test005GetUserListWithEmptyRoles() {
        
        let expectation = self.expectation(description: "Get list of users with Empty roles.")
        
        let _userListRequest = UsersRequest.UsersRequestBuilder(limit: 30).set(roles: []).build()
        
        _userListRequest.fetchNext(onSuccess: { (userList) in
            
            print("test005GetUserListWithEmptyRoles onSuccess: \(userList)")
            
            if userList.count > 0 {
                
                validateUserList(user: userList, isRole: true)
            }
            
            expectation.fulfill()
        }) { (error) in
            
            print("test005GetUserListWithEmptyRoles error : \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
        }
        wait(for: [expectation], timeout: 30)
    }
    
    ///////////////////////////////////////////////////////////////////////////////////////////

    /////////////////////////// COMETCHATPRO: FETCH  USERS WITH ONLY FRIENDS //////////////////////////////
 
    func test001GetUserListWithOnlyFriendsAsTrue() {
        
        let expectation = self.expectation(description: "Get list of users with only friends as true")
        
        let _userListRequest = UsersRequest.UsersRequestBuilder(limit: 30).friendsOnly(true).build()
        
        _userListRequest.fetchNext(onSuccess: { (userList) in
            
            validateUserList(user: userList, isRole: true)
            
            print("test001GetUserListWithOnlyFriendsAsTrue onSuccess: \(userList)")
            expectation.fulfill()
        }) { (error) in
            
            print("test001GetUserListWithOnlyFriendsAsTrue error : \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)

            
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test002GetUserListWithOnlyFriendsAsFalse() {
        
        let expectation = self.expectation(description: "Get list of users with only friends as false.")
        
        let _userListRequest = UsersRequest.UsersRequestBuilder(limit: 30).friendsOnly(false).build()
        
        _userListRequest.fetchNext(onSuccess: { (userList) in
            
            validateUserList(user: userList, isRole: true)
            
            print("test002GetUserListWithOnlyFriendsAsFalse onSuccess: \(userList)")
            expectation.fulfill()
        }) { (error) in
            
            print("test002GetUserListWithOnlyFriendsAsFalse error : \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
}
   
