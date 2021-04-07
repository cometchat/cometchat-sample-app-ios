//
//  CometChat5GroupsTests.swift
//  CometChatProTests
//
//  Created by Inscripts11 on 21/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

import XCTest
 import CometChatPro

////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////  COMETCHATPRO: GROUPS TEST CASES  //////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////

class CometChat5GroupsTests: XCTestCase {
    
    var newGroupGUID: String?
    
////////////////////////////////////////////////////////////////////////////////////////////
    
//////////////////////////////// COMETCHATPRO: FETCH GROUPS ////////////////////////////////
    
    
    func test001FetchGroupListWithValidLimit() {
        
        let expectation = self.expectation(description: "Get Group List with valid Limit")
        let groupListRequest = GroupsRequest.GroupsRequestBuilder(limit: 30).build()
        groupListRequest.fetchNext(onSuccess: { (groups) in
            print("testGetGroupListWithValidLimitgroup onSuccess: \(groups)")
            
            validateGroups(groups: groups, hasJoinedOnlyGroups: false)
            
            XCTAssertNotNil(groups)
            expectation.fulfill()
            
        }) { (error) in
            print("testGetGroupListWithValidLimitgroup error : \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 30)
    }
    
    
    func test002FetchGroupListWithInvalidLimit() {
        let expectation = self.expectation(description: "Get Group List with Invalid Limit")
        let groupListRequest = GroupsRequest.GroupsRequestBuilder(limit: 500).build()
        groupListRequest.fetchNext(onSuccess: { (groups) in
            print("testGetGroupListWithInvalidLimit successful: \(groups)")
        }) { (error) in
            print("testGetGroupListWithInvalidLimit error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30)
    }
    
    func test003FetchGroupListWithZeroLimit() {
        let expectation = self.expectation(description: "Get Group List with zero Limit")
        let groupListRequest = GroupsRequest.GroupsRequestBuilder(limit: 0).build()
        groupListRequest.fetchNext(onSuccess: { (groups) in
            print("testGetGroupListWithZeroLimit successful: \(groups)")
            
        }) { (error) in
            print("testGetGroupListWithZeroLimit error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
           
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test004FetchGroupListWithMinusLimit() {
        let expectation = self.expectation(description: "Get Group List with minus Limit")
        let groupListRequest = GroupsRequest.GroupsRequestBuilder(limit: -1).build()
        groupListRequest.fetchNext(onSuccess: { (groups) in
            print("testGetGroupListWithMinusLimit successful: \(groups)")
        }) { (error) in
            print("testGetGroupListWithMinusLimit error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test005FetchGroupListWithValidLimitFilterBySearchKeyword() {
        
        let expectation = self.expectation(description: "Get Group List with valid Limit")
        let groupListRequest = GroupsRequest.GroupsRequestBuilder(limit: 30).set(searchKeyword: "abc").build()
        groupListRequest.fetchNext(onSuccess: { (groups) in
            print("testGetGroupListWithValidLimitgroup onSuccess: \(groups)")
            validateGroups(groups: groups, hasJoinedOnlyGroups: false)
            XCTAssertNotNil(groups)
            expectation.fulfill()
            
        }) { (error) in
            print("testGetGroupListWithValidLimitgroup error : \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test006FetchGroupListWithValidLimitFilterByInvalidSearchKeyword() {
        let expectation = self.expectation(description: "Get Group List with zero Limit")
        let groupListRequest = GroupsRequest.GroupsRequestBuilder(limit: 30).set(searchKeyword: "INVALID GROUP").build()
        groupListRequest.fetchNext(onSuccess: { (groups) in
            print("testGetGroupListWithZeroLimit successful: \(groups)")
            XCTAssertNotNil(groups)
            validateGroups(groups: groups, hasJoinedOnlyGroups: false)
            expectation.fulfill()
        }) { (error) in
            print("testGetGroupListWithZeroLimit error: \(String(describing: error?.errorDescription))")
           
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test007FetchGroupListWithHasJoined() {
        let expectation = self.expectation(description: "Get Group List with only joined groups")
        let groupListRequest = GroupsRequest.GroupsRequestBuilder(limit: 30).set(joinedOnly: true).build()
        groupListRequest.fetchNext(onSuccess: { (groups) in
            print("testGetGroupList successful: \(groups)")
            XCTAssertNotNil(groups)
            validateGroups(groups: groups, hasJoinedOnlyGroups: true)
            expectation.fulfill()
        }) { (error) in
            print("testGetGroupListWithZeroLimit error: \(String(describing: error?.errorDescription))")
           
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test008FetchGroupListWithHasJoinedWithSearchKeyword() {
        let expectation = self.expectation(description: "Get Group List with only joined groups along with search keyword")
        let groupListRequest = GroupsRequest.GroupsRequestBuilder(limit: 30).set(joinedOnly: true).set(searchKeyword: "abc").build()
        groupListRequest.fetchNext(onSuccess: { (groups) in
            print("testGetGroupLis successful: \(groups)")
            XCTAssertNotNil(groups)
            validateGroups(groups: groups, hasJoinedOnlyGroups: true)
            expectation.fulfill()
        }) { (error) in
            print("testGetGroupListWithZeroLimit error: \(String(describing: error?.errorDescription))")
           
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test008FetchGroupListWithHasJoinedWithEmptySearchKeyword() {
        let expectation = self.expectation(description: "Get Group List with only joined groups along with Empty search keyword")
        let groupListRequest = GroupsRequest.GroupsRequestBuilder(limit: 30).set(joinedOnly: true).set(searchKeyword: "").build()
        groupListRequest.fetchNext(onSuccess: { (groups) in
            print("testGetGroupList successful: \(groups)")
            XCTAssertNotNil(groups)
            validateGroups(groups: groups, hasJoinedOnlyGroups: true)
            expectation.fulfill()
        }) { (error) in
            print("testGetGroupListWithZeroLimit error: \(String(describing: error?.errorDescription))")
           
        }
        wait(for: [expectation], timeout: 10)
    }
    
////////////////////////////////////////////////////////////////////////////////////////////
    
/////////////////////////////// COMETCHATPRO: CREATE GROUP ////////////////////////////////
    
    
   func test007CreatePublicGroupWithEmptyGUID() {
        let expectation = self.expectation(description: "Create a public group with empty GUID")
        let newGroup = Group(guid: "", name: "test group created", groupType: .public, password: nil)
         CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            print("createPublicGroupWithEmptyGUID onSuccess: \(group.stringValue())")
            print("createPublicGroupWithEmptyGUID hasJoined: \(newGroup.hasJoined)")
         }) { (error) in
            //FIXME: createPublicGroupWithEmptyGUID: Error message is incorrect
            print("createPublicGroupWithEmptyGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test008CreatePublicGroupWithEmptyGroupName() {
        let expectation = self.expectation(description: "Create a public group with empty group name")
        let newGroup = Group(guid: TestConstants.grpPublic1, name: "", groupType: .public, password: nil)
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            print("createPublicGroupWithEmptyGroupName onSuccess: \(group.stringValue())")
            print("createPublicGroupWithEmptyGUID hasJoined: \(newGroup.hasJoined)")
        }) { (error) in
            //FIXME: createPublicGroupWithEmptyGroupName: Error message is incorrect
            print("createPublicGroupWithEmptyGroupName error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test009CreatePublicGroupWithEmptyGUIDAndEmptyGroupName() {
        let expectation = self.expectation(description: "Create a public group with empty GUID and empty group name")
        let newGroup = Group(guid: "", name: "", groupType: .public, password: nil)
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            print("createPublicGroupWithEmptyGUIDEmptyGroupName onSuccess: \(group.stringValue())")
            print("createPublicGroupWithEmptyGUIDEmptyGroupName hasJoined: \(newGroup.hasJoined)")
        }) { (error) in
            //FIXME: createPublicGroupWithEmptyGUIDEmptyGroupName: Error message is incorrect
            print("createPublicGroupWithEmptyGUIDEmptyGroupName error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test010CreatePublicGroupWithPassword() {
        
        // In this case password has to be ignored.
        let expectation = self.expectation(description: "Create a public group with password")
        
        let newGroup = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))", name: "test group created", groupType: .public, password: "123")
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in

            validateCreatedGroup(group: group, ismetaData: false, isIcon: false, isDescription: false)
            
            print("createPublicGroupWithPassword onSuccess: \(group.stringValue())")
            //FIXME: createPublicGroupWithPassword: newGroup.hasJoined parameter is not correct
            print("createPublicGroupWithPassword hasJoined: \(group.hasJoined)")
            
            XCTAssertNotNil(group)
            expectation.fulfill()
            
            CometChat.deleteGroup(GUID: newGroup.guid, onSuccess: { (success) in
                print("group \(newGroup.guid) deleted successfully.")
             }, onError: { (error) in
                print("error in deleting the group \(newGroup.guid) : \(String(describing: error?.errorDescription))")
            })
        }) { (error) in
            print("createPublicGroup error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test011CreatePublicGroup() {
        
        let expectation = self.expectation(description: "Create a public group")
        
        let newGroup = Group(guid: TestConstants.grpPublic2, name: "test group created", groupType: .public, password: nil)
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
           
            print("createPublicGroup onSuccess: \(group.stringValue())")
            validateCreatedGroup(group: group, ismetaData: false, isIcon: false, isDescription: false)
             //FIXME: createPublicGroup: newGroup.hasJoined parameter is not correct
            print("createPublicGroup hasJoined: \(newGroup.hasJoined)")
            
           XCTAssertNotNil(group)
            
             expectation.fulfill()
        }) { (error) in
            
            print("createPublicGroup error: \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 10)
    }
    

   func test012CreatePrivateGroupEmptyGUID() {
        
        let expectation = self.expectation(description: "Create a private group with empty guid")
        
        let newGroup = Group(guid: "", name: "test group created", groupType: .private, password: nil)
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            
            print("createPrivateGroupEmptyGUID successful: \(group.stringValue())")
            print("createPrivateGroupEmptyGUID hasJoined: \(group.hasJoined)")

            CometChat.deleteGroup(GUID: newGroup.guid, onSuccess: { (success) in
                
                print("group \(newGroup.guid) deleted successfully.")
                
            }, onError: { (error) in
                
                print("error in deleting the group \(newGroup.guid) : \(String(describing: error?.errorDescription))")
            })

        }) { (error) in
            //FIXME: createPrivateGroupEmptyGUID : Error message is not correct
            print("createPrivateGroupEmptyGUID error: \(String(describing: error?.errorDescription))")
              XCTAssertNotNil(error)
             expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
  
    
    func test013CreatePrivateGroupWithPassword() {
        
        let expectation = self.expectation(description: "Create a private group with password")
        
        let newGroup = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))", name: "test group created", groupType: .private, password: "123")
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            
            print("createPrivateGroupWithPassword successful: \(group.stringValue())")
            
              //FIXME: createPrivateGroup : group.hasJoined param is not correct
            print("createPrivateGroupWithPassword hasJoined: \(group.hasJoined)")
            
            XCTAssertNotNil(group)
            
            CometChat.deleteGroup(GUID: newGroup.guid, onSuccess: { (success) in
                
                print("group \(newGroup.guid) deleted successfully.")
                
            }, onError: { (error) in
                
                print("error in deleting the group \(newGroup.guid) : \(String(describing: error?.errorDescription))")
            })
            
            expectation.fulfill()
        }) { (error) in
           
            print("createPrivateGroup error: \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test014CreatePrivateGroup() {
        
        let expectation = self.expectation(description: "Create a private group")
        
        let newGroup = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))", name: "test group created", groupType: .private, password: nil)
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            validateCreatedGroup(group: group, ismetaData: false, isIcon: false, isDescription: false)
            print("createPrivateGroup successful: \(group.stringValue())")
            
             //FIXME: createPrivateGroup : group.hasJoined param is not correct
            print("createPrivateGroup hasJoined: \(group.hasJoined)")
            
            XCTAssertNotNil(group)
            
            CometChat.deleteGroup(GUID: newGroup.guid, onSuccess: { (success) in
                
                print("group \(newGroup.guid) deleted successfully.")
                
            }, onError: { (error) in
                
                print("error in deleting the group \(newGroup.guid) : \(String(describing: error?.errorDescription))")
            })
            
            expectation.fulfill()
        }) { (error) in
            
            print("createPrivateGroup error: \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test015CreatePasswordProtectedGroupWithEmptyGUID() {
        
        let expectation = self.expectation(description: "Create a password group with empty guid")
        
        let newGroup = Group(guid: "", name: "newGroup", groupType: .password, password: "123")
        
        CometChat.createGroup(group: newGroup, onSuccess: { (newGroup) in
            
            print("createPasswordProtectedGroupWithEmptyGUID onSuccess: \(newGroup.stringValue())")
            print("createPasswordProtectedGroupWithEmptyGUID hasJoined: \(newGroup.hasJoined)")
            
            
        }) { (error) in
            
            //FIXME: createPrivateGroup : Error message is not correct
            print("createPasswordProtectedGroupWithEmptyGUID error : \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(newGroup)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test016CreatePasswordProtectedGroupWithEmptyPassword() {
        
        let expectation = self.expectation(description: "Create a password group")
        
        let guidTimeStamp = Int(Date().timeIntervalSince1970 * 100)
        
        let newGroup = Group(guid: "group_\(guidTimeStamp)", name: "test group created", groupType: .password, password: "")
        
        CometChat.createGroup(group: newGroup, onSuccess: { (newGroup) in
            
            print("createPasswordProtectedGroupWithEmptyPassword onSuccess: \(newGroup.stringValue())")
            
             //FIXME: createPasswordProtectedGroupWithEmptyPassword : newGroup.hasJoined param is not correct
            print("createPasswordProtectedGroupWithEmptyPassword hasJoined: \(newGroup.hasJoined)")

        }) { (error) in
            
            print("createPasswordProtectedGroupWithEmptyPassword error : \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test017CreatePasswordProtectedGroup() {
        
        let expectation = self.expectation(description: "Create a password group")
        
        let guidTimeStamp = Int(Date().timeIntervalSince1970 * 100)
        
        let newGroup = Group(guid: "group_\(guidTimeStamp)", name: "test group created", groupType: .password, password: "pwd123")
        
        CometChat.createGroup(group: newGroup, onSuccess: { (newGroup) in
            validateCreatedGroup(group: newGroup, ismetaData: false, isIcon: false, isDescription: false)
            print("createPasswordProtectedGroup onSuccess: \(newGroup.stringValue())")
              //FIXME: createPasswordProtectedGroup : newGroup.hasJoined param is not correct
            print("createPasswordProtectedGroup hasJoined: \(newGroup.hasJoined)")
            
            XCTAssertNotNil(newGroup)
            
            CometChat.deleteGroup(GUID: newGroup.guid, onSuccess: { (isSuccess) in
                
                print("group deleted successfully ..")
                
            }, onError: { (error) in
                
                print("error in deleting group : \(String(describing: error?.errorDescription))")
            })
            
            expectation.fulfill()
        }) { (error) in
            
            print("createPasswordProtectedGroup error : \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
   
    
    func test018CreatePublicGroupWithMetaData() {
        
        let expectation = self.expectation(description: "Create a public group")
        
        let newGroup = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))", name: "test group created", groupType: .public, password: nil)
        newGroup.metadata = ["key":"value"]
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            validateCreatedGroup(group: group, ismetaData: true, isIcon: false, isDescription: false)
            print("createPublicGroupWithMetaData onSuccess: \(group.stringValue())")
            
            //FIXME: createPublicGroupWithMetaData : newGroup.hasJoined param is not correct
            print("createPublicGroupWithMetaData hasJoined: \(newGroup.hasJoined)")
            
            XCTAssertNotNil(group)
            
            CometChat.deleteGroup(GUID: newGroup.guid, onSuccess: { (success) in
                
                print("group \(newGroup.guid) deleted successfully.")
                
            }, onError: { (error) in
                
                print("error in deleting the group \(newGroup.guid) : \(String(describing: error?.errorDescription))")
            })
            
            expectation.fulfill()
        }) { (error) in
            
            print("createPublicGroup error: \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    
    
    
    func test019CreatePrivateGroupWithMetaData() {
        
        let expectation = self.expectation(description: "Create a private group")
        
        let newGroup = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))", name: "test group created", groupType: .private, password: nil)
         newGroup.metadata = ["key":"value"]
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            validateCreatedGroup(group: group, ismetaData: true, isIcon: false, isDescription: false)
            print("createPrivateGroupWithMetaData successful: \(group.stringValue())")
            
              //FIXME: createPrivateGroupWithMetaData : newGroup.hasJoined param is not correct
            print("createPrivateGroupWithMetaData hasJoined: \(newGroup.hasJoined)")
            
            XCTAssertNotNil(group)
            
            CometChat.deleteGroup(GUID: newGroup.guid, onSuccess: { (success) in
                
                print("group \(newGroup.guid) deleted successfully.")
                
            }, onError: { (error) in
                
                print("error in deleting the group \(newGroup.guid) : \(String(describing: error?.errorDescription))")
            })
            
            expectation.fulfill()
        }) { (error) in
            
            print("createPrivateGroup error: \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test020CreatePasswordProtectedGroupWithMetaData() {
        
        let expectation = self.expectation(description: "Create a password group")
        
        let guidTimeStamp = Int(Date().timeIntervalSince1970 * 100)
        
        let newGroup = Group(guid: "group_\(guidTimeStamp)", name: "test group created", groupType: .password, password: "pwd123")
         newGroup.metadata = ["key":"value"]
        CometChat.createGroup(group: newGroup, onSuccess: { (newGroup) in
            validateCreatedGroup(group: newGroup, ismetaData: true, isIcon: false, isDescription: false)
            print("createPasswordProtectedGroupWithMetaData onSuccess: \(newGroup.stringValue())")
            
            //FIXME: createPasswordProtectedGroupWithMetaData : newGroup.hasJoined param is not correct
            print("createPasswordProtectedGroupWithMetaData hasJoined: \(newGroup.hasJoined)")
            XCTAssertNotNil(newGroup)
            
            CometChat.deleteGroup(GUID: newGroup.guid, onSuccess: { (isSuccess) in
                
                print("group deleted successfully ..")
                
            }, onError: { (error) in
                
                print("error in deleting group : \(String(describing: error?.errorDescription))")
            })
            
            expectation.fulfill()
        }) { (error) in
            
            print("createPasswordGroup error : \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    
    
    func test021CreatePublicGroupAlreadyExist() {
        
        let expectation = self.expectation(description: "Create a public group already exist")
        
        let newGroup = Group(guid: TestConstants.grpPublic1, name: "test group created", groupType: .public, password: nil)
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            
            print("createPublicGroupAlreadyExist onSuccess: \(group.stringValue())")
            
        }) { (error) in
            
            print("createPublicGroupAlreadyExist error: \(String(describing: error?.errorDescription))")
              //FIXME: createPublicGroupAlreadyExist : Error Message is not correct
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test022CreatePrivateGroupAlreadyExist() {
        
        let expectation = self.expectation(description: "Create a private group already exist")
        
        let newGroup = Group(guid: TestConstants.grpPrivate3, name: "test group created", groupType: .public, password: nil)
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            
            print("createPrivateGroupAlreadyExist onSuccess: \(group.stringValue())")
            
        }) { (error) in
             //FIXME: createPrivateGroupAlreadyExist : Error Message is not correct
            print("createPrivateGroupAlreadyExist error: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    //Check
    func test023CreatePasswordGroupAlreadyExist() {
        
        let expectation = self.expectation(description: "Create a password group already exist")
        
        let newGroup = Group(guid: TestConstants.testGroup6, name: "test group created", groupType: .password, password: "123")
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            
            print("createPasswordGroupAlreadyExist onSuccess: \(group.stringValue())")
        }) { (error) in
           
            print("createPasswordGroupAlreadyExist error: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 40)
    }
    
    
    func test024CreatePublicGroupWithIconAndDescription(){
        
        let expectation = self.expectation(description: "Create a public group with empty GUID")
        
        let newGroup = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "new group with description", groupType: .public, password: nil, icon: "https://randomuser.me/api/portraits/women/14.jpg", description: "Hola!")
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            validateCreatedGroup(group: group, ismetaData: false, isIcon: true, isDescription: true)
            print("createPublicGroupWithIconAndDescription onSuccess: \(group.stringValue())")
            print("createPublicGroupWithIconAndDescription hasJoined: \(newGroup.hasJoined)")
            
            CometChat.deleteGroup(GUID: newGroup.guid, onSuccess: { (group) in
                print("group \(newGroup.guid) deleted successfully.")
            }, onError: { (error) in
                print("error in deleting the group \(newGroup.guid) : \(String(describing: error?.errorDescription))")
            })
            
            XCTAssertNotNil(group)
            
            expectation.fulfill()
            
        }) { (error) in
            print("createPublicGroupWithIconAndDescription error: \(String(describing: error?.errorDescription))")
            
        }
        
        wait(for: [expectation], timeout: 40)
        
    }
    
    
    func test025CreatePublicGroupWithInvalidIconAndDescription(){
        
        let expectation = self.expectation(description: "Create a public group with empty GUID")
        
        let newGroup = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "new group with description", groupType: .public, password: nil, icon: "Invalid Icon", description: "Hola!")
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            
            print("createPublicGroupWithInvalidIconAndDescription onSuccess: \(group.stringValue())")
            print("createPublicGroupWithInvalidIconAndDescription hasJoined: \(newGroup.hasJoined)")
            
        }) { (error) in
            //FIXME: createPublicGroupWithEmptyGUID: Error message is incorrect
            print("test025CreatePublicGroupWithInvalidIconAndDescription error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
        
    }
    
    func test026CreatePublicGroupWithInvalidIconAndEmptyDescription(){
        
        let expectation = self.expectation(description: "Create a public group with empty GUID")
        
        let newGroup = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "new group with description", groupType: .public, password: nil, icon: "Invalid Icon", description: "")
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            
            print("createPublicGroupWithInvalidIconAndDescription onSuccess: \(group.stringValue())")
            print("createPublicGroupWithInvalidIconAndDescription hasJoined: \(newGroup.hasJoined)")
            
        }) { (error) in
            //FIXME: createPublicGroupWithEmptyGUID: Error message is incorrect
            print("createPublicGroupWithEmptyGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
        
    }
    
    func test27CreatePublicGroupWithValidIconAndEmptyDescription(){
        
        let expectation = self.expectation(description: "Create a public group with empty GUID")
        
        let newGroup = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "new group with description", groupType: .public, password: nil, icon: "https://randomuser.me/api/portraits/women/14.jpg", description: "")
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            
            print("createPublicGroupWithInvalidIconAndDescription onSuccess: \(group.stringValue())")
            print("createPublicGroupWithInvalidIconAndDescription hasJoined: \(newGroup.hasJoined)")
            
        }) { (error) in
            //FIXME: createPublicGroupWithEmptyGUID: Error message is incorrect
            print("createPublicGroupWithInvalidIconAndDescription error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
        
    }
    
    
    func test028CreatePasswordGroupWithIconAndDescription(){
        
        let expectation = self.expectation(description: "Create a public group with empty GUID")
        
        let newGroup = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "new group with description", groupType: .password, password: "1234", icon: "https://randomuser.me/api/portraits/women/14.jpg", description: "Hola!")
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            validateCreatedGroup(group: group, ismetaData: false, isIcon: true, isDescription: true)
            print("createPasswordGroupWithIconAndDescription onSuccess: \(group.stringValue())")
            print("createPasswordGroupWithIconAndDescription hasJoined: \(newGroup.hasJoined)")
            
            CometChat.deleteGroup(GUID: newGroup.guid, onSuccess: { (group) in
                print("group \(newGroup.guid) deleted successfully.")
            }, onError: { (error) in
                print("error in deleting the group \(newGroup.guid) : \(String(describing: error?.errorDescription))")
            })
            
            XCTAssertNotNil(group)
            
            expectation.fulfill()
            
        }) { (error) in
            print("createPasswordGroupWithIconAndDescription error: \(String(describing: error?.errorDescription))")
            
        }
        
        wait(for: [expectation], timeout: 10)
        
    }
    
    
    func test029CreatePasswordGroupWithInvalidIconAndDescription(){
        
        let expectation = self.expectation(description: "Create a public group with empty GUID")
        
        let newGroup = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "new group with description", groupType: .password, password: "1234", icon: "Invalid Icon", description: "Hola!")
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            
            print("createPasswordGroupWithInvalidIconAndDescription onSuccess: \(group.stringValue())")
            print("createPasswordGroupWithInvalidIconAndDescription hasJoined: \(newGroup.hasJoined)")
            
        }) { (error) in
            //FIXME: createPublicGroupWithEmptyGUID: Error message is incorrect
            print("createPasswordGroupWithInvalidIconAndDescription error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
        
    }
    
    func test030CreatePasswordGroupWithInvalidIconAndEmptyPasswordAndDescription(){
        
        let expectation = self.expectation(description: "Create a public group with empty GUID")
        
        let newGroup = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "new group with description", groupType: .password, password: "", icon: "Invalid Icon", description: "")
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            
            print("createPasswordGroupWithInvalidIconAndEmptyPasswordAndDescription onSuccess: \(group.stringValue())")
            print("createPasswordGroupWithInvalidIconAndEmptyPasswordAndDescription hasJoined: \(newGroup.hasJoined)")
            
        }) { (error) in
            //FIXME: createPublicGroupWithEmptyGUID: Error message is incorrect
            print("createPasswordGroupWithInvalidIconAndEmptyPasswordAndDescription error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
        
    }
    
    func test031CreatePasswordGroupWithValidIconAndEmptyDescription(){
        
        let expectation = self.expectation(description: "Create a public group with empty GUID")
        
        let newGroup = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "new group with description", groupType: .password , password: "1234", icon: "https://randomuser.me/api/portraits/women/14.jpg", description: "")
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            
            print("createPasswordGroupWithValidIconAndEmptyDescription onSuccess: \(group.stringValue())")
            print("createPasswordGroupWithValidIconAndEmptyDescription hasJoined: \(newGroup.hasJoined)")
            
        }) { (error) in
            //FIXME: createPublicGroupWithEmptyGUID: Error message is incorrect
            print("createPasswordGroupWithValidIconAndEmptyDescription error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
        
    }
    
    
    func test032CreatePrivateGroupWithIconAndDescription(){
        
        let expectation = self.expectation(description: "Create a public group with empty GUID")
        
        let newGroup = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "new group with description", groupType: .private, password: nil, icon: "https://randomuser.me/api/portraits/women/14.jpg", description: "Hola!")
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            validateCreatedGroup(group: group, ismetaData: false, isIcon: true, isDescription: true)
            print("createPrivateGroupWithIconAndDescription onSuccess: \(group.stringValue())")
            print("createPrivateGroupWithIconAndDescription hasJoined: \(newGroup.hasJoined)")
            
            CometChat.deleteGroup(GUID: newGroup.guid, onSuccess: { (group) in
                print("group \(newGroup.guid) deleted successfully.")
            }, onError: { (error) in
                print("error in deleting the group \(newGroup.guid) : \(String(describing: error?.errorDescription))")
            })
            
            XCTAssertNotNil(group)
            
            expectation.fulfill()
            
        }) { (error) in
            print("createPrivateGroupWithIconAndDescription error: \(String(describing: error?.errorDescription))")
            
        }
        
        wait(for: [expectation], timeout: 10)
        
    }
    
    
    func test033CreatePrivateGroupWithInvalidIconAndDescription(){
        
        let expectation = self.expectation(description: "Create a public group with empty GUID")
        
        let newGroup = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "new group with description", groupType: .private, password: nil, icon: "Invalid Icon", description: "Hola!")
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            
            print("createPrivateGroupWithInvalidIconAndDescription onSuccess: \(group.stringValue())")
            print("createPrivateGroupWithInvalidIconAndDescription hasJoined: \(newGroup.hasJoined)")
            
        }) { (error) in
            //FIXME: createPublicGroupWithEmptyGUID: Error message is incorrect
            print("createPrivateGroupWithInvalidIconAndDescription error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
        
    }
    
    func test034CreatePrivateGroupWithInvalidIconAndEmptyDescription(){
        
        let expectation = self.expectation(description: "Create a public group with empty GUID")
        
        let newGroup = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "new group with description", groupType: .private, password: nil, icon: "Invalid Icon", description: "")
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            
            print("createPrivateGroupWithInvalidIconAndEmptyDescription onSuccess: \(group.stringValue())")
            print("createPrivateGroupWithInvalidIconAndEmptyDescription hasJoined: \(newGroup.hasJoined)")
            
        }) { (error) in
            //FIXME: createPublicGroupWithEmptyGUID: Error message is incorrect
            print("createPrivateGroupWithInvalidIconAndEmptyDescription error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
        
    }
    
    func test035CreatePrivateGroupWithValidIconAndEmptyDescription(){
        
        let expectation = self.expectation(description: "Create a public group with empty GUID")
        
        let newGroup = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "new group with description", groupType: .private, password: nil, icon: "https://randomuser.me/api/portraits/women/14.jpg", description: "")
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            
            print("createPrivateGroupWithValidIconAndEmptyDescription onSuccess: \(group.stringValue())")
            print("createPrivateGroupWithValidIconAndEmptyDescription hasJoined: \(newGroup.hasJoined)")
            
        }) { (error) in
            //FIXME: createPublicGroupWithEmptyGUID: Error message is incorrect
            print("createPrivateGroupWithValidIconAndEmptyDescription error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
        
    }
    
    
    func test036CreatePublicGroupWithIconAndDescriptionAndMetadata(){
        
        let expectation = self.expectation(description: "Create a public group with empty GUID")
        
        let newGroup = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "new group with description", groupType: .public, password: nil, icon: "https://randomuser.me/api/portraits/women/14.jpg", description: "Hola!")
        newGroup.metadata = ["key":"value"]
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            validateCreatedGroup(group: group, ismetaData: true, isIcon: true, isDescription: true)
            print("testCreatePublicGroupWithIconAndDescriptionAndMetadata onSuccess: \(group.stringValue())")
            print("testCreatePublicGroupWithIconAndDescriptionAndMetadata hasJoined: \(newGroup.hasJoined)")
            
            CometChat.deleteGroup(GUID: newGroup.guid, onSuccess: { (group) in
                print("group \(newGroup.guid) deleted successfully.")
            }, onError: { (error) in
                print("error in deleting the group \(newGroup.guid) : \(String(describing: error?.errorDescription))")
            })
            
            XCTAssertNotNil(group)
            
            expectation.fulfill()
            
        }) { (error) in
            print("createPublicGroupWithIconAndDescription error: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test037CreatePublicGroupWithIconAndDescriptionAndEmptyMetadata(){
        
        let expectation = self.expectation(description: "Create a public group with empty GUID")
        
        let newGroup = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "new group with description", groupType: .public, password: nil, icon: "https://randomuser.me/api/portraits/women/14.jpg", description: "Hola!")
        newGroup.metadata = ["":""]
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            validateCreatedGroup(group: group, ismetaData: true, isIcon: true, isDescription: true)
            print("testCreatePublicGroupWithIconAndDescriptionAndEmptyMetadata onSuccess: \(group.stringValue())")
            print("testCreatePublicGroupWithIconAndDescriptionAndEmptyMetadata hasJoined: \(group.hasJoined)")
            
            CometChat.deleteGroup(GUID: newGroup.guid, onSuccess: { (group) in
                print("group \(newGroup.guid) deleted successfully.")
            }, onError: { (error) in
                print("error in deleting the group \(newGroup.guid) : \(String(describing: error?.errorDescription))")
            })
            
            XCTAssertNotNil(group)
            
            expectation.fulfill()
            
        }) { (error) in
            print("createPublicGroupWithIconAndDescription error: \(String(describing: error?.errorDescription))")
            
        }
        wait(for: [expectation], timeout: 60)
    }
    
    
////////////////////////////////////////////////////////////////////////////////////////////
    
/////////////////////////// COMETCHATPRO: JOIN/LEAVE/GET GROUP /////////////////////////////
    
    
    func test038GetJoinedPublicGroupInfo() {
        
        let expectation = self.expectation(description: "Get Joined Public Group Info")
        
        CometChat.getGroup(GUID: TestConstants.grpPublic1, onSuccess: { (group) in
            validateGroups(groups: [group], hasJoinedOnlyGroups: true)
            print("testGetJoinedPublicGroupInfo onSuccess: \(String(describing: group.stringValue()))")
            XCTAssertNotNil(group)
            
            expectation.fulfill()
            
        }) { (error) in
            
            print("testGetJoinedPublicGroupInfo error : \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test039GetJoinedPublicGroupInfoWithInvalidGUID() {
        
        let expectation = self.expectation(description: "Get Joined Public Group Info With Invalid GUID")
        
        CometChat.getGroup(GUID: "INVALID", onSuccess: { (group) in
            
            print("testGetJoinedPublicGroupInfoWithInvalidGUID onSuccess: \(String(describing: group.stringValue()))")
            
         }) { (error) in
            
            print("testGetJoinedPublicGroupInfoWithInvalidGUID error : \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test040GetJoinedPublicGroupInfoWithEmptyGUID() {
        
        let expectation = self.expectation(description: "Get Joined Public Group Info With Empty GUID")
        
        CometChat.getGroup(GUID: "", onSuccess: { (group) in
            
            print("testGetJoinedPublicGroupInfoWithEmptyGUID onSuccess: \(String(describing: group.stringValue()))")
            
        }) { (error) in
            
            print("testGetJoinedPublicGroupInfoWithEmptyGUID error : \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test041LeaveJoinedPublicGroup(){
        
        let expectation = self.expectation(description: "Leave Joined Public Group")
        
        let group : Group = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))", name: "Created Group for leaving", groupType: .public, password: nil)
        CometChat.createGroup(group: group, onSuccess: { (myGroup) in
        
            CometChat.leaveGroup(GUID: myGroup.guid, onSuccess: { (isSuccess) in
                
                print("testLeaveJoinedPublicGroup onSuccess: \(String(describing: isSuccess))")
                
                XCTAssertEqual(isSuccess, "Group left successfully.")
                
                expectation.fulfill()
                
            }) { (error) in
                 print("testLeaveJoinedPublicGroup error : \(String(describing: error?.errorDescription))")
            }
            
        }) { (error) in
            
            print("testLeaveJoinedPublicGroup error : \(String(describing: error?.errorDescription))")
            
        }
      wait(for: [expectation], timeout: 30)
    }
    
    func test042LeaveJoinedPublicGroupWithInvalidGUID(){
        
        let expectation = self.expectation(description: "Leave Joined Public Group")
        
        CometChat.leaveGroup(GUID: "INVALID", onSuccess: { (isSuccess) in
            
            print("testLeaveJoinedPublicGroupWithInvalidGUID onSuccess: \(String(describing: isSuccess))")
            
            CometChat.joinGroup(GUID: TestConstants.grpPublic1, groupType: .public, password: nil
                , onSuccess: { (sucess) in
                    print("group joined")
            }, onError: { (error) in
                print("group joined onError")
            })
        }) { (error) in
            print("testLeaveJoinedPublicGroupWithInvalidGUID error : \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test043LeaveJoinedPublicGroupWithEmptyGUID(){
        
        let expectation = self.expectation(description: "Leave Joined Public Group")
        
        CometChat.leaveGroup(GUID: "", onSuccess: { (isSuccess) in
            
            print("testLeaveJoinedPublicGroupWithEmptyGUID onSuccess: \(String(describing: isSuccess))")
            
            CometChat.joinGroup(GUID: TestConstants.grpPublic1, groupType: .public, password: nil
                , onSuccess: { (sucess) in
                    print("group joined")
            }, onError: { (error) in
                print("group joined onError")
            })
        }) { (error) in
            print("testLeaveJoinedPublicGroupWithEmptyGUID error : \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test044GetUnjoinedPublicGroupInfo() {
        
        let expectation = self.expectation(description: "Get Unjoined Public Group Info")
        
        // PERFORM LEAVE GROUP FIRST BY UNCOMMENTING THIS FOR THIS TEST CASE
        
//                CometChat.leaveGroup(GUID: TestConstants.grpPublic1, onSuccess: { (SUCESS) in
//
//                }) { (ERROR) in
//
//                }
        
        
        CometChat.getGroup(GUID: TestConstants.testGroup11, onSuccess: { (group) in
            validateGroups(groups: [group], hasJoinedOnlyGroups: false)
            print("testGetUnjoinedPublicGroupInfo onSuccess: \(String(describing: group.stringValue()))")
        
            expectation.fulfill()
            
        }) { (error) in
            
            print("testGetUnjoinedPublicGroupInfo error : \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test045GetUnjoinedPublicGroupInfoWithInvalidGuid() {
        
        let expectation = self.expectation(description: "Get Unjoined Public Group Info")
        
        // PERFORM LEAVE GROUP FIRST BY UNCOMMENTING THIS FOR THIS TEST CASE
        
        //                CometChat.leaveGroup(GUID: TestConstants.grpPublic1, onSuccess: { (SUCESS) in
        //
        //                }) { (ERROR) in
        //
        //                }
        //
        
        CometChat.getGroup(GUID: "INVALID", onSuccess: { (group) in
            
            print("testGetUnjoinedPublicGroupInfoWithInvalidGuid onSuccess: \(String(describing: group.stringValue()))")
            
        }) { (error) in
            
            print("testGetUnjoinedPublicGroupInfoWithInvalidGuid error : \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test047GetUnjoinedPublicGroupInfoWithEmptyGuid() {
        
        let expectation = self.expectation(description: "Get Unjoined Public Group Info")
        
        // PERFORM LEAVE GROUP FIRST BY UNCOMMENTING THIS FOR THIS TEST CASE
        
        //                CometChat.leaveGroup(GUID: TestConstants.grpPublic1, onSuccess: { (SUCESS) in
        //
        //                }) { (ERROR) in
        //
        //                }
        //
        
        CometChat.getGroup(GUID: "", onSuccess: { (group) in
            
            print("testGetUnjoinedPublicGroupInfoWithEmptyGuid onSuccess: \(String(describing: group.stringValue()))")
            
        }) { (error) in
            
            print("testGetUnjoinedPublicGroupInfoWithEmptyGuid error : \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test048JoinPublicGroup(){
        
        let expectation = self.expectation(description: " Joined Public Group")
        
        CometChat.joinGroup(GUID: TestConstants.testGroup13, groupType: .public, password: nil
            , onSuccess: { (group) in
                validateGroups(groups: [group], hasJoinedOnlyGroups: true)
                print("testJoinGroup onSuccess: \(String(describing: group.stringValue()))")
                
                XCTAssertNotNil(group)
                XCTAssertEqual(group.hasJoined, true)
               expectation.fulfill()
                
        }) { (error) in
              print("testJoinGroup error : \(String(describing: error?.errorDescription))")
            //XCTAssertEqual(error?.errorDescription, "The user with uid \(String(describing: CometChat.getLoggedInUser()!.uid!)) has already joined the group with \(TestConstants.testGroup13).")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test049JoinPublicGroupWithInvalidGUID(){
        
        let expectation = self.expectation(description: " Joined Public Group")
        
        CometChat.joinGroup(GUID: "INVALID", groupType: .public, password: nil
            , onSuccess: { (group) in
                
                print("testJoinGroup onSuccess: \(String(describing: group.stringValue()))")
                
        }) { (error) in
            print("testJoinGroup error : \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
   
    
    func test050JoinPublicGroupWithEmptyGUID(){
        
        let expectation = self.expectation(description: " Joined Public Group")
        
        CometChat.joinGroup(GUID:"", groupType: .public, password: nil
            , onSuccess: { (group) in
                
                print("testJoinGroup onSuccess: \(String(describing: group.stringValue()))")
                
        }) { (error) in
            print("testJoinGroup error : \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
   
    
    func test051GetJoinedPasswordGroupInfo() {
        
        let expectation = self.expectation(description: "Get Joined Password Group Info")
        
        CometChat.getGroup(GUID: TestConstants.testGroup8, onSuccess: { (group) in
            validateGroups(groups: [group], hasJoinedOnlyGroups: false)
            print("testGetJoinedPasswordGroupInfo onSuccess : \(String(describing: group.stringValue()))")
            
            XCTAssertNotNil(group)
            
            expectation.fulfill()
            
        }) { (error) in
            
            XCTAssertEqual(error?.errorDescription, "The user with \(TestConstants.testuser1) is not a member of the group with guid \(TestConstants.testGroup8). Please join the group to access it.")
            expectation.fulfill()
            print("testGetJoinedPasswordGroupInfo error : \(String(describing: error?.errorDescription))")
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test052GetJoinedPasswordGroupInfoWithInvalidGUID() {
        
        let expectation = self.expectation(description: "Get Joined Password Group Info")
        
        CometChat.getGroup(GUID: "INVALID", onSuccess: { (group) in
            
            print("testGetJoinedPasswordGroupInfoWithInvalidGUID onSuccess : \(String(describing: group.stringValue()))")
            
            XCTAssertNotNil(group)
            
            expectation.fulfill()
            
        }) { (error) in
            
         print("testGetJoinedPasswordGroupInfoWithInvalidGUID error : \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test053GetJoinedPasswordGroupInfoWithEmptyGUID() {
        
        let expectation = self.expectation(description: "Get Joined Password Group Info")
        
        CometChat.getGroup(GUID: "", onSuccess: { (group) in
            
            print("testGetJoinedPasswordGroupInfoWithEmptyGUID onSuccess : \(String(describing: group.stringValue()))")
            
            XCTAssertNotNil(group)
            
            expectation.fulfill()
            
        }) { (error) in
            
            print("testGetJoinedPasswordGroupInfoWithEmptyGUID error : \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    
    
    func test054LeaveJoinedPasswordGroup(){
        
        let expectation = self.expectation(description: "Leave joined password protected group")
        
        let newGroup = Group(guid:  "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "Leave Password Group Create for Leaving", groupType: .password, password: "123")
        
        CometChat.createGroup(group: newGroup , onSuccess: { (group) in
            
            CometChat.leaveGroup(GUID: group.guid, onSuccess: { (onSuccess) in
                print("testLeaveJoinedPasswordGroup onSuccess : \(String(describing: onSuccess))")
                
                XCTAssertNotNil(onSuccess)
                
                expectation.fulfill()
                
            }) { (error) in
                
                 print("testLeaveJoinedPasswordGroup error : \(String(describing: error?.errorDescription))")
//                XCTAssertEqual(error?.errorDescription, "The group with guid \(TestConstants.testGroup8) does not exist. Please use correct guid or use create group API")
                 expectation.fulfill()
                
            }
            
        }) { (error) in
            
            
            print("testLeaveJoinedPasswordGroup error : \(String(describing: error?.errorDescription))")
        }
        
        
        
          wait(for: [expectation], timeout: 10)
        
    }
    
    func test055LeaveJoinedPasswordGroupWithInvalidGUID(){
        
        let expectation = self.expectation(description: "Leave joined password protected group")
        
        CometChat.leaveGroup(GUID: "INVALID", onSuccess: { (onSuccess) in
            print("testLeaveJoinedPasswordGroupWithInvalidGUID onSuccess : \(String(describing: onSuccess))")
            
            XCTAssertNotNil(onSuccess)
            
            expectation.fulfill()
            
        }) { (error) in
            
            print("testLeaveJoinedPasswordGroupWithInvalidGUID error : \(String(describing: error?.errorDescription))")
           XCTAssertNotNil(error)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 10)
        
    }
    
    
    func test056LeaveJoinedPasswordGroupWithEmptyGUID(){
        
        let expectation = self.expectation(description: "Leave joined password protected group")
        
        CometChat.leaveGroup(GUID: "", onSuccess: { (onSuccess) in
            print("testLeaveJoinedPasswordGroupWithEmptyGUID onSuccess : \(String(describing: onSuccess))")
            
            XCTAssertNotNil(onSuccess)
            
            expectation.fulfill()
            
        }) { (error) in
            
            print("testLeaveJoinedPasswordGroupWithEmptyGUID error : \(String(describing: error?.errorDescription))")
           XCTAssertNotNil(error)
            expectation.fulfill()
            
        }
        wait(for: [expectation], timeout: 10)
        
    }
    

    
    func test057GetUnjoinedPasswordGroupInfo() {
        
        let expectation = self.expectation(description: "Get Unjoined Password Group Info")
       
        // PERFORM LEAVE GROUP FIRST BY UNCOMMENTING THIS FOR THIS TEST CASE
        
//        CometChat.leaveGroup(GUID: TestConstants.testGroup7, onSuccess: { (SUCESS) in
//
//        }) { (ERROR) in
//
//        }
        
        CometChat.getGroup(GUID: TestConstants.testGroup14, onSuccess: { (group) in
            validateGroups(groups: [group], hasJoinedOnlyGroups: false)
            print("testGetUnjoinedPasswordGroupInfo onSuccess : \(String(describing: group.stringValue()))")
            expectation.fulfill()
        }) { (error) in

            print("testGetUnjoinedPasswordGroupInfo error: \(String(describing: error?.errorDescription))")

            XCTAssertNotNil(error)
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test058GetUnjoinedPasswordGroupInfoWithEmptyGUID() {
        
        let expectation = self.expectation(description: "Get Unjoined Password Group Info")
        
        // PERFORM LEAVE GROUP FIRST BY UNCOMMENTING THIS FOR THIS TEST CASE
        
        //        CometChat.leaveGroup(GUID: TestConstants.grpPwd5, onSuccess: { (SUCESS) in
        //
        //        }) { (ERROR) in
        //
        //        }
        
        CometChat.getGroup(GUID: "", onSuccess: { (group) in
            
            print("testGetUnjoinedPasswordGroupInfo onSuccess : \(String(describing: group.stringValue()))")
            
        }) { (error) in
            
            print("testGetUnjoinedPasswordGroupInfo error: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test059GetUnjoinedPasswordGroupInfoWithInvalidGUID() {
        
        let expectation = self.expectation(description: "Get Unjoined Password Group Info")
        
        // PERFORM LEAVE GROUP FIRST BY UNCOMMENTING THIS FOR THIS TEST CASE
        
        //        CometChat.leaveGroup(GUID: TestConstants.grpPwd5, onSuccess: { (SUCESS) in
        //
        //        }) { (ERROR) in
        //
        //        }
        
        CometChat.getGroup(GUID: "INVALID", onSuccess: { (group) in
            
            print("testGetUnjoinedPasswordGroupInfoWithInvalidGUID onSuccess : \(String(describing: group.stringValue()))")
            
        }) { (error) in
            
            print("testGetUnjoinedPasswordGroupInfoWithInvalidGUID error: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test060GetJoinedPrivateGroupInfo() {
        
        let expectation = self.expectation(description: "Get Joined Private Group Info")
        CometChat.createGroup(group: Group(guid: "CheckJoinedPrivateGroup", name: "Test For Joined Private group", groupType: .private, password: nil), onSuccess: { (group) in
            
            CometChat.getGroup(GUID: group.guid, onSuccess: { (group) in
                validateGroups(groups: [group], hasJoinedOnlyGroups: true)
                print("testGetJoinedPrivateGroupInfo  onSuccess: \(String(describing: group.stringValue()))")
                
                XCTAssertNotNil(group)
                expectation.fulfill()
                
            }) { (error) in
                
                print("testGetJoinedPrivateGroupInfo error: \(String(describing: error?.errorDescription))")
                
                
            }
            
        }) { (error) in
            
                print("testGetJoinedPrivateGroupInfo error: \(String(describing: error?.errorDescription))")
                
        }
        
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test061GetJoinedPrivateGroupInfoWithEmptyGUID() {
        
        let expectation = self.expectation(description: "Get Joined Private Group Info")
        
        CometChat.getGroup(GUID: "", onSuccess: { (group) in
            
            print("testGetJoinedPrivateGroupInfoWithEmptyGUID  onSuccess: \(String(describing: group.stringValue()))")
            
         
            
        }) { (error) in
            
            print("testGetJoinedPrivateGroupInfoWithEmptyGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test062GetJoinedPrivateGroupInfoWithInvalidGUID() {
        
        let expectation = self.expectation(description: "Get Joined Private Group Info")
        
        CometChat.getGroup(GUID: "INVALID", onSuccess: { (group) in
            
            print("testGetJoinedPrivateGroupInfo  onSuccess: \(String(describing: group.stringValue()))")
            
           
        }) { (error) in
            
            print("testGetJoinedPrivateGroupInfo error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
            
            
        }
        
        wait(for: [expectation], timeout: 10)
    }

    
    func test063JoinGroupAlreadyJoined() {
        let expectation = self.expectation(description: "Join the public Group")
        CometChat.joinGroup(GUID: TestConstants.grpPublic1, groupType: .public, password: nil, onSuccess: { (group) in
            print("testJoinGroupAlreadyJoined onSuccess: \(group.stringValue())")
        }) { (error) in
            print("testJoinGroupAlreadyJoined error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30)
    }
    
    
    
    func test064JoinPasswordGroupWithValidInput() {
        
        let expectation = self.expectation(description: "Join the password group with valid password")
        
        CometChat.joinGroup(GUID: TestConstants.testGroup14, groupType: .password, password: "123", onSuccess: { (group) in
            validateGroups(groups: [group], hasJoinedOnlyGroups: true)
            print("testJoinPasswordGroupWithValidPassword onSuccess: \(group.stringValue())")
            
            XCTAssertNotNil(group)
            
            expectation.fulfill()
            
            CometChat.leaveGroup(GUID: TestConstants.grpPwd6, onSuccess: { (isSuccess) in
                
            }, onError: { (error) in
                
                print("error in leaving the group : \(String(describing: error?.errorDescription))")
            })
            
        }, onError: { (error) in
            
            print("testJoinPasswordGroupWithValidPassword error: \(String(describing: error?.errorDescription))")
        })
        
        wait(for: [expectation], timeout: 10)
    }
    
    
    
    func test065JoinPasswordGroupWithInvalidPassword() {
        
        let expectation = self.expectation(description: "Join the password group with Invalid password")
        
        CometChat.joinGroup(GUID: TestConstants.grpPwd6, groupType: .password, password: "INVALID", onSuccess: { (group) in
            
            print("testJoinPasswordGroupWithInvalidPassword onSuccess: \(group.stringValue())")
            
        }, onError: { (error) in
            
            print("testJoinPasswordGroupWithInvalidPassword error: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test066JoinPasswordGroupWithInvalidPasswordInvalidGUID() {
        
        let expectation = self.expectation(description: "Join the password group with Invalid password")
        
        CometChat.joinGroup(GUID: "INVALID", groupType: .password, password: "INVALID", onSuccess: { (group) in
            
            print("testJoinPasswordGroupWithInvalidPasswordInvalidGUID onSuccess: \(group.stringValue())")
            
        }, onError: { (error) in
            
            print("testJoinPasswordGroupWithInvalidPasswordInvalidGUID error: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10)
    }

    
    
    func test067JoinPasswordGroupWithInvalidPasswordEmptyGUID() {
        
        let expectation = self.expectation(description: "Join the password group with Invalid password")
        
        CometChat.joinGroup(GUID: "", groupType: .password, password: "INVALID", onSuccess: { (group) in
            
            print("testJoinPasswordGroupWithInvalidPasswordEmptyGUID onSuccess: \(group.stringValue())")
            
        }, onError: { (error) in
            
            print("testJoinPasswordGroupWithInvalidPasswordEmptyGUID error: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test068JoinPasswordGroupWithInvalidPasswordInvalidGUIDInvalidGroupType() {
        
        let expectation = self.expectation(description: "Join the password group with Invalid password")
        
        CometChat.joinGroup(GUID: TestConstants.grpPublic1, groupType: .private, password: "INVALID", onSuccess: { (group) in
            
            print("testJoinPasswordGroupWithInvalidPasswordInvalidGUIDInvalidGroupType onSuccess: \(group.stringValue())")
            
        }, onError: { (error) in
            
            print("testJoinPasswordGroupWithInvalidPasswordInvalidGUIDInvalidGroupType error: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test069JoinPasswordGroupWithAllInvalidInputs() {
        
        let expectation = self.expectation(description: "Join the password group with Invalid password")
        
        CometChat.joinGroup(GUID: "INVALID", groupType: .private, password: "INVALID", onSuccess: { (group) in
            
            print("testJoinPasswordGroupWithAllInvalidInputs onSuccess: \(group.stringValue())")
            
        }, onError: { (error) in
            
            print("testJoinPasswordGroupWithAllInvalidInputs error: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test070JoinGroupWithAlreadyJoinedWithValidPassword() {
        
        let expectation = self.expectation(description: "Join the group with already joined group with valid password")
        
        CometChat.joinGroup(GUID: TestConstants.grpPwd5, groupType: .password, password: "pwd123", onSuccess: { (group) in
            
            print("testJoinGroupWithAlreadyJoinedWithValidPassword onSuccess: \(group.stringValue())")
            
        }, onError: { (error) in
            
            print("testJoinGroupWithAlreadyJoinedWithValidPassword error: \(String(describing: error?.errorDescription))")
            
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 10)
    }

////////////////////////////////////////////////////////////////////////////////////////////
    
////////////////////////////// COMETCHATPRO: UPDATE GROUP  /////////////////////////////////
   
    func test071UpdateExistingGroup() {
        
        let expectation = self.expectation(description: "Update existing group with valid user scope")

        let newGroup = Group(guid: "TestCreatedPasswordGroup1", name: "test group created for update", groupType: .password, password: "123")
        
        CometChat.createGroup(group: newGroup, onSuccess: { (group) in
            
            let updateGroup = Group(guid: group.guid, name: "test group created", groupType: .public, password: nil)
            
            CometChat.updateGroup(group: updateGroup, onSuccess: { (group) in
                validateGroups(groups: [group], hasJoinedOnlyGroups: false)
                print("testUpdateExistingGroupWithvalidUserScope onSuccess: \(group.stringValue())")
               
                XCTAssertNotNil(group)
                
                expectation.fulfill()
            }) { (error) in
                
                print("testUpdateExistingGroupWithInvalidUserScope error : \(String(describing: error?.errorDescription))")
               
            }
            
        }) { (error) in
            
            print("testUpdateExistingGroupWithInvalidUserScope error : \(String(describing: error?.errorDescription))")
            
        }
        
        wait(for: [expectation], timeout: 30)
    }
    
    func test072UpdateExistingGroupWithInvalidGUID() {
        
        let expectation = self.expectation(description: "Update existing group with valid user scope")
        
        let newGroup = Group(guid: "INVALID", name: "test group created", groupType: .public, password: nil)
        
        // PERFORM LEAVE GROUP FIRST BY UNCOMMENTING THIS FOR THIS TEST CASE
        
        //
        //        CometChat.joinGroup(GUID: TestConstants.grpPublic2, groupType: .public, password: nil, onSuccess: { (group) in
        //
        //        }) { (error) in
        //
        //        }
        
        
        CometChat.updateGroup(group: newGroup, onSuccess: { (group) in
            
            print("testUpdateExistingGroupWithInvalidGUID onSuccess: \(group.stringValue())")
            
           
        }) { (error) in
            
            print("testUpdateExistingGroupWithInvalidGUID error : \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test073UpdateExistingGroupWithInvalidGroupType() {
        
        let expectation = self.expectation(description: "Update existing group with valid user scope")
        
        let newGroup = Group(guid: "INVALID", name: "test group created", groupType: .private, password: nil)
        
        // PERFORM LEAVE GROUP FIRST BY UNCOMMENTING THIS FOR THIS TEST CASE
        
        //
        //        CometChat.joinGroup(GUID: TestConstants.grpPublic2, groupType: .public, password: nil, onSuccess: { (group) in
        //
        //        }) { (error) in
        //
        //        }
        
        
        CometChat.updateGroup(group: newGroup, onSuccess: { (group) in
            
            print("testUpdateExistingGroupWithInvalidGroupType onSuccess: \(group.stringValue())")
            
          
        }) { (error) in
            
            print("testUpdateExistingGroupWithInvalidGroupType error : \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            
            expectation.fulfill()
            
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    func test074UpdateExistingGroupWithInvalidPassword() {
        
        let expectation = self.expectation(description: "Update existing group with valid user scope")
        
        let newGroup = Group(guid: "INVALID", name: "test group created", groupType: .private, password: "123456")
        
        // PERFORM LEAVE GROUP FIRST BY UNCOMMENTING THIS FOR THIS TEST CASE
        
        //
        //        CometChat.joinGroup(GUID: TestConstants.grpPublic2, groupType: .public, password: nil, onSuccess: { (group) in
        //
        //        }) { (error) in
        //
        //        }
        
        
        CometChat.updateGroup(group: newGroup, onSuccess: { (group) in
            
            print("testUpdateExistingGroupWithInvalidPassword onSuccess: \(group.stringValue())")
            
            
        }) { (error) in
            
            print("testUpdateExistingGroupWithInvalidPassword error : \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //ConvertPublicGroupToPasswordProtectedGroup
    func test075UpdatePublicGroupToPasswordGroup(){
        
        let expectation = self.expectation(description: "ConvertPublicGroupToPawsswordProtectedGroup")
        let newGroup = Group(guid:  "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "public group", groupType: .public, password: nil)
        
        CometChat.createGroup(group: newGroup, onSuccess: { (publicGroup) in
         let newGroup = Group(guid:  publicGroup.guid , name: "public to password group", groupType: .password, password: "12345")
            print("create group onSuccess : \(String(describing: publicGroup.stringValue()))")
            CometChat.updateGroup(group: newGroup, onSuccess: { (newPasswordGroup) in
                validateChangeGroupType(group : newPasswordGroup, type : .password)
                print("testUpdatePublicGroupToPasswordGroup onSuccess: \(newPasswordGroup.stringValue())")
                XCTAssertNotNil(newPasswordGroup)
                expectation.fulfill()
            }) { (error) in
                print("testUpdatePublicGroupToPasswordGroup error : \(String(describing: error?.errorDescription))")
            }
        }) { (error) in
            print("create group error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //ConvertPublicGroupToPasswordProtectedGroup
    func test076UpdatePasswordGroupToPublicGroup() {
        
        let expectation = self.expectation(description: "testUpdatePasswordGroupToPublicGroup")
        let newGroup = Group(guid:  "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "password group", groupType: .password, password: "12345")
        
        CometChat.createGroup(group: newGroup, onSuccess: { (passwordGroup) in
            let newGroup = Group(guid:  passwordGroup.guid , name: "password to public group", groupType: .public, password: nil)
            print("create group onSuccess : \(String(describing: passwordGroup.stringValue()))")
            CometChat.updateGroup(group: newGroup, onSuccess: { (newPublicGroup) in
                print("testUpdatePasswordGroupToPublicGroup onSuccess: \(newPublicGroup.stringValue())")
                validateChangeGroupType(group : newPublicGroup, type : .public)
                XCTAssertNotNil(newPublicGroup)
                expectation.fulfill()
            }) { (error) in
                print("testUpdatePasswordGroupToPublicGroup error : \(String(describing: error?.errorDescription))")
            }
        }) { (error) in
            print("create group error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //ConvertPublicGroupToPrivateGroup
    func test077UpdatePublicGroupToPrivateGroup(){
        
        let expectation = self.expectation(description: "ConvertPublicGroupToPrivateGroup")
        let newGroup = Group(guid:  "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "public group", groupType: .public, password: nil)
        
        CometChat.createGroup(group: newGroup, onSuccess: { (publicGroup) in
            let newGroup = Group(guid:  publicGroup.guid , name: "public to private group", groupType: .private, password: nil)
            print("create group onSuccess : \(String(describing: publicGroup.stringValue()))")
            CometChat.updateGroup(group: newGroup, onSuccess: { (newPrivateGroup) in
                validateChangeGroupType(group : newPrivateGroup, type : .private)
                print("testUpdatePublicGroupToPrivateGroup onSuccess: \(newPrivateGroup.stringValue())")
                XCTAssertNotNil(newPrivateGroup)
                expectation.fulfill()
            }) { (error) in
                print("testUpdatePublicGroupToPrivateGroup error : \(String(describing: error?.errorDescription))")
            }
        }) { (error) in
            print("create group error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //ConvertPublicGroupToPasswordProtectedGroup
    func test078UpdatePrivateGroupToPublicGroup() {
        
        let expectation = self.expectation(description: "testUpdatePasswordGroupToPublicGroup")
        let newGroup = Group(guid:  "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "password group", groupType: .private, password: nil)
        
        CometChat.createGroup(group: newGroup, onSuccess: { (privateGroup) in
            let newGroup = Group(guid:  privateGroup.guid , name: "private to public group", groupType: .public, password: nil)
            print("create group onSuccess : \(String(describing: privateGroup.stringValue()))")
            CometChat.updateGroup(group: newGroup, onSuccess: { (newPublicGroup) in
                validateChangeGroupType(group : newPublicGroup, type : .public)
                print("testUpdatePrivateGroupToPublicGroup onSuccess: \(newPublicGroup.stringValue())")
                XCTAssertNotNil(newPublicGroup)
                expectation.fulfill()
            }) { (error) in
                print("testUpdatePrivateGroupToPublicGroup error : \(String(describing: error?.errorDescription))")
            }
        }) { (error) in
            print("create group error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 40)
    }
    
    
    
    func test079UpdatePasswordGroupToPrivateGroup(){
        
        let expectation = self.expectation(description: "testUpdatePasswordGroupToPrivateGroup")
        let newGroup = Group(guid:  "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "public group", groupType: .password, password: "12345")
        
        CometChat.createGroup(group: newGroup, onSuccess: { (passwordGroup) in
          
            print("create group onSuccess : \(String(describing: passwordGroup.stringValue()))")
            
              let newGroup = Group(guid:  passwordGroup.guid , name: "password to private group", groupType: .private, password: nil)
            CometChat.updateGroup(group: newGroup, onSuccess: { (newPrivateGroup) in
                validateChangeGroupType(group : newPrivateGroup, type : .private)
                print("testUpdatePasswordGroupToPrivateGroup onSuccess: \(newPrivateGroup.stringValue())")
                XCTAssertNotNil(newPrivateGroup)
                expectation.fulfill()
            }) { (error) in
                print("testUpdatePasswordGroupToPrivateGroup error : \(String(describing: error?.errorDescription))")
            }
        }) { (error) in
            print("create group error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    //test080UpdatePrivateGroupToPublic
    func test080UpdatePrivateGroupToPublic() {
        
        let expectation = self.expectation(description: "testUpdatePrivateGroupToPasswordProtectedGroup")
        let newGroup = Group(guid:  "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "private group", groupType: .private, password: nil)
        
        CometChat.createGroup(group: newGroup, onSuccess: { (privateGroup) in
          
            print("create group onSuccess : \(String(describing: privateGroup.stringValue()))")
            
              let newGroup = Group(guid:  privateGroup.guid , name: "private to public group", groupType: .public, password: nil)
            CometChat.updateGroup(group: newGroup, onSuccess: { (newPasswordGroup) in
                validateChangeGroupType(group : newPasswordGroup, type : .public)
                print("testUpdatePrivateGroupToPasswordProtectedGroup onSuccess: \(newPasswordGroup.stringValue())")
                XCTAssertNotNil(newPasswordGroup)
                expectation.fulfill()
            }) { (error) in
                print("testUpdatePrivateGroupToPasswordProtectedGroup error : \(String(describing: error?.errorDescription))")
            }
        }) { (error) in
            print("create group error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //ConvertPrivateGroupToPasswordProtectedGroup
    func test080UpdatePrivateGroupToPasswordProtectedGroup() {
        
        let expectation = self.expectation(description: "testUpdatePrivateGroupToPasswordProtectedGroup")
        let newGroup = Group(guid:  "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "private group", groupType: .private, password: nil)
        
        CometChat.createGroup(group: newGroup, onSuccess: { (privateGroup) in
          
            print("create group onSuccess : \(String(describing: privateGroup.stringValue()))")
            
              let newGroup = Group(guid:  privateGroup.guid , name: "private to public group", groupType: .password, password: "121")
            CometChat.updateGroup(group: newGroup, onSuccess: { (newPasswordGroup) in
                validateChangeGroupType(group : newPasswordGroup, type : .password)
                print("testUpdatePrivateGroupToPasswordProtectedGroup onSuccess: \(newPasswordGroup.stringValue())")
                XCTAssertNotNil(newPasswordGroup)
                expectation.fulfill()
            }) { (error) in
                print("testUpdatePrivateGroupToPasswordProtectedGroup error : \(String(describing: error?.errorDescription))")
            }
        }) { (error) in
            print("create group error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
////////////////////////////////////////////////////////////////////////////////////////////
    
////////////////////////////// COMETCHATPRO: ADD MEMBERS TO GROUP  /////////////////////////
    
    func test081AddMembersToPublicGroup(){
        let expectation = self.expectation(description: "testAddMembersToPublicGroup")
        let group = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "AddMembersToPublic", groupType: .public, password: nil)
        
        CometChat.createGroup(group: group, onSuccess: { (Group) in
            print("createGroup onSuccess: \(Group)")
            self.newGroupGUID = Group.guid
            let grpmem1 = GroupMember(UID: "superhero2", groupMemberScope: .participant)
            let grpmem2 = GroupMember(UID: "superhero3", groupMemberScope: .moderator)
            let grpmem3 = GroupMember(UID: "superhero4", groupMemberScope: .participant)
            let grpmem4 = GroupMember(UID: "superhero5", groupMemberScope: .admin)
            
            CometChat.addMembersToGroup(guid: Group.guid, groupMembers: [grpmem1,grpmem2,grpmem3,grpmem4], onSuccess: { (success) in
                print("testAddMembersToPublicGroup onSuccess: \(success)")
                
                XCTAssertNotNil(success)
                expectation.fulfill()
                
            }, onError: { (error) in
                
                print("testAddMembersToPublicGroup onSuccess: \(String(describing: error?.errorDescription))")
            })
  
        }) { (error) in
            print("createGroup error: \(String(describing: error?.errorDescription))")
        }
         wait(for: [expectation], timeout: 10)
    }
    
    
    func test082AddMembersToPasswordProtectedGroup(){
        let expectation = self.expectation(description: "testAddMembersToPasswordProtectedGroup")
        let group = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "AddMembersToPassword", groupType: .password, password: "12345")
        
        CometChat.createGroup(group: group, onSuccess: { (Group) in
            print("createGroup onSuccess: \(Group)")
            
            let grpmem1 = GroupMember(UID: "superhero2", groupMemberScope: .participant)
            let grpmem2 = GroupMember(UID: "superhero3", groupMemberScope: .moderator)
            let grpmem3 = GroupMember(UID: "superhero4", groupMemberScope: .participant)
            let grpmem4 = GroupMember(UID: "superhero5", groupMemberScope: .admin)
            
            CometChat.addMembersToGroup(guid: Group.guid, groupMembers: [grpmem1,grpmem2,grpmem3,grpmem4], onSuccess: { (success) in
                print("testAddMembersToPasswordProtectedGroup onSuccess: \(success)")
                XCTAssertNotNil(success)
                expectation.fulfill()
                
            }, onError: { (error) in
                
                print("testAddMembersToPasswordProtectedGroup onError: \(String(describing: error?.errorDescription))")
            })
            
        }) { (error) in
            print("createGroup error: \(String(describing: error?.errorDescription))")
        }
         wait(for: [expectation], timeout: 10)
    }
    
    
    func test083AddMembersToPrivateGroup(){
        let expectation = self.expectation(description: "testAddMembersToPrivateGroup")
        let group = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "AddMembersToPrivate", groupType: .private, password: nil)
        
        CometChat.createGroup(group: group, onSuccess: { (Group) in
            print("createGroup onSuccess: \(Group)")
            
            let grpmem1 = GroupMember(UID: "superhero2", groupMemberScope: .participant)
            let grpmem2 = GroupMember(UID: "superhero3", groupMemberScope: .moderator)
            let grpmem3 = GroupMember(UID: "superhero4", groupMemberScope: .participant)
            let grpmem4 = GroupMember(UID: "superhero5", groupMemberScope: .admin)
            
            CometChat.addMembersToGroup(guid: Group.guid, groupMembers: [grpmem1,grpmem2,grpmem3,grpmem4], onSuccess: { (success) in
                print("testAddMembersToPrivateGroup onSuccess: \(success)")
                XCTAssertNotNil(success)
                expectation.fulfill()
                
            }, onError: { (error) in
                
                print("testAddMembersToPrivateGroup onError: \(String(describing: error?.errorDescription))")
            })
            
        }) { (error) in
            print("createGroup error: \(String(describing: error?.errorDescription))")
        }
         wait(for: [expectation], timeout: 10)
    }
    
    
    func test084AddMembersToPublicGroupWithEmptyArray(){
        let expectation = self.expectation(description: "testAddMembersToPublicGroupWithEmptyArray")
        let group = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "AddMembersToPublic", groupType: .public, password: nil)
        
        CometChat.createGroup(group: group, onSuccess: { (Group) in
            print("createGroup onSuccess: \(Group)")
            
            CometChat.addMembersToGroup(guid: Group.guid, groupMembers: [], onSuccess: { (success) in
                print("testAddMembersToPublicGroupWithEmptyArray onSuccess: \(success)")
                
            }, onError: { (error) in
                
                print("testAddMembersToPublicGroupWithEmptyArray onError: \(String(describing: error?.errorDescription))")
                XCTAssertNotNil(error)
                expectation.fulfill()
                
            })
            
        }) { (error) in
            print("createGroup error: \(String(describing: error?.errorDescription))")
        }
         wait(for: [expectation], timeout: 10)
    }
    
    
    func test085AddMembersToPasswordProtectedGroupWithEmptyArray(){
        let expectation = self.expectation(description: "testAddMembersToPasswordProtectedGroupWithEmptyArray")
        let group = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "AddMembersToPassword", groupType: .password, password: "12345")
        
        CometChat.createGroup(group: group, onSuccess: { (Group) in
            print("createGroup onSuccess: \(Group)")
   
            CometChat.addMembersToGroup(guid: Group.guid, groupMembers: [], onSuccess: { (success) in
                print("testAddMembersToPasswordProtectedGroupWithEmptyArray onSuccess: \(success)")
               
                
            }, onError: { (error) in
                
                print("testAddMembersToPasswordProtectedGroupWithEmptyArray onError: \(String(describing: error?.errorDescription))")
                XCTAssertNotNil(error)
                expectation.fulfill()
            })
            
        }) { (error) in
            print("createGroup error: \(String(describing: error?.errorDescription))")
        }
         wait(for: [expectation], timeout: 10)
    }
    
    
    func test086AddMembersToPrivateGroupWithEmptyArray(){
        let expectation = self.expectation(description: "testAddMembersToPrivateGroupWithEmptyArray")
        let group = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "AddMembersToPrivate", groupType: .private, password: nil)
        
        CometChat.createGroup(group: group, onSuccess: { (Group) in
            print("createGroup onSuccess: \(Group)")
        
            CometChat.addMembersToGroup(guid: Group.guid, groupMembers: [], onSuccess: { (success) in
                print("testAddMembersToPrivateGroupWithEmptyArray onSuccess: \(success)")
               
                
            }, onError: { (error) in
                
                print("testAddMembersToPrivateGroupWithEmptyArray onError: \(String(describing: error?.errorDescription))")
                XCTAssertNotNil(error)
                expectation.fulfill()
            })
            
        }) { (error) in
            print("createGroup error: \(String(describing: error?.errorDescription))")
        }
         wait(for: [expectation], timeout: 10)
    }
        
        
        func test087AddMembersToPublicGroupWithInvalidUIDs(){
            let expectation = self.expectation(description: "testAddMembersToPublicGroupWithInvalidUIDs")
            let group = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "AddMembersToPublic", groupType: .public, password: nil)
            
            CometChat.createGroup(group: group, onSuccess: { (Group) in
                print("createGroup onSuccess: \(Group)")
               
                let grpmem1 = GroupMember(UID: "INVALID", groupMemberScope: .participant)
                let grpmem2 = GroupMember(UID: "INVALID", groupMemberScope: .moderator)
                
                CometChat.addMembersToGroup(guid: Group.guid, groupMembers: [grpmem1,grpmem2], onSuccess: { (success) in
                    print("testAddMembersToPublicGroupWithInvalidUIDs onSuccess: \(success)")
                    expectation.fulfill()
                }, onError: { (error) in
                    
                    print("testAddMembersToPublicGroupWithEmptyArray onError: \(String(describing: error?.errorDescription))")
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                    
                })
                
            }) { (error) in
                print("createGroup error: \(String(describing: error?.errorDescription))")
            }
             wait(for: [expectation], timeout: 10)
        }
        
        
        func test088AddMembersToPasswordGroupWithInvalidUIDs(){
            let expectation = self.expectation(description: "testAddMembersToPublicGroupWithInvalidUIDs")
            let group = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "AddMembersToPassword", groupType: .password, password: "12345")
            
            CometChat.createGroup(group: group, onSuccess: { (Group) in
                print("createGroup onSuccess: \(Group)")
                
                let grpmem1 = GroupMember(UID: "INVALID", groupMemberScope: .participant)
                let grpmem2 = GroupMember(UID: "INVALID", groupMemberScope: .moderator)
                
                CometChat.addMembersToGroup(guid: Group.guid, groupMembers: [grpmem1,grpmem2], onSuccess: { (success) in
                    print("testAddMembersToPasswordGroupWithInvalidUIDs onSuccess: \(success)")
                    expectation.fulfill()
                }, onError: { (error) in
                    
                    print("testAddMembersToPasswordGroupWithInvalidUIDs onError: \(String(describing: error?.errorDescription))")
                    XCTAssertNotNil(error)
                    expectation.fulfill()
                    
                })
                
            }) { (error) in
                print("createGroup error: \(String(describing: error?.errorDescription))")
            }
            
         wait(for: [expectation], timeout: 10)
        }
        
        
        
        func test089AddMembersToPrivateGroupWithInvalidUIDs(){
            let expectation = self.expectation(description: "testAddMembersToPublicGroupWithInvalidUIDs")
            let group = Group(guid: "group_\(Int(Date().timeIntervalSince1970 * 100))" , name: "AddMembersToPrivate", groupType: .private, password: nil)
            
            CometChat.createGroup(group: group, onSuccess: { (Group) in
                print("createGroup onSuccess: \(Group)")
                
                let grpmem1 = GroupMember(UID: "INVALID", groupMemberScope: .participant)
                let grpmem2 = GroupMember(UID: "INVALID", groupMemberScope: .moderator)
                
                CometChat.addMembersToGroup(guid: Group.guid, groupMembers: [grpmem1,grpmem2], onSuccess: { (success) in
                    print("testAddMembersToPrivateGroupWithInvalidUIDs onSuccess: \(success)")
                    //doubt
                    expectation.fulfill()
                }, onError: { (error) in
                    
                    print("testAddMembersToPrivateGroupWithInvalidUIDs onError: \(String(describing: error?.errorDescription))")
                    XCTAssertNotNil(error)
                    
                })
                }) { (error) in
                print("createGroup error: \(String(describing: error?.errorDescription))")
            }
             wait(for: [expectation], timeout: 60)
        }
        
////////////////////////////////////////////////////////////////////////////////////////////
    
///////////////////////////// COMETCHATPRO: FETCH GROUP MEMBERS ////////////////////////////
    
    func test090FetchGroupMembersWithAllValidInputs(){
        let expectation = self.expectation(description: "testFetchGroupMembersWithAllValidInputs")
        let memberRequest = GroupMembersRequest.GroupMembersRequestBuilder(guid: TestConstants.grpPublic1).set(limit: 20).build()
        memberRequest.fetchNext(onSuccess: { (members) in
            
            validateGroupMembers(members: members)
           print("testFetchGroupMembersWithAllValidInputs onSuccess: \(members)")
            XCTAssertNotNil(members)
            expectation.fulfill()
        }) { (error) in
            print("testFetchGroupMembersWithAllValidInputs error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    

    func test091FetchGroupMembersWithInvalidLimit(){
        let expectation = self.expectation(description: "testFetchGroupMembersWithInvalidLimit")
        let memberRequest = GroupMembersRequest.GroupMembersRequestBuilder(guid: TestConstants.grpPublic1).set(limit: 1000).build()
        memberRequest.fetchNext(onSuccess: { (members) in
            print("testFetchGroupMembersWithInvalidLimit onSuccess: \(members)")
            
        }) { (error) in
            print("testFetchGroupMembersWithInvalidLimit error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test092FetchGroupMembersWithZeroLimit(){
        let expectation = self.expectation(description: "testFetchGroupMembersWithZeroLimit")
        let memberRequest = GroupMembersRequest.GroupMembersRequestBuilder(guid: TestConstants.grpPublic1).set(limit: 0).build()
        memberRequest.fetchNext(onSuccess: { (members) in
            print("testFetchGroupMembersWithZeroLimit onSuccess: \(members)")
            
        }) { (error) in
            print("testFetchGroupMembersWithZeroLimit error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test093FetchGroupMembersWithMinusLimit(){
        let expectation = self.expectation(description: "testFetchGroupMembersWithMinusLimit")
        let memberRequest = GroupMembersRequest.GroupMembersRequestBuilder(guid: TestConstants.grpPublic1).set(limit: -1).build()
        memberRequest.fetchNext(onSuccess: { (members) in
            print("testFetchGroupMembersWithMinusLimit onSuccess: \(members)")
      }) { (error) in
        print("testFetchGroupMembersWithMinusLimit error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
             expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test094FetchGroupMembersWithNoLimit(){
        let expectation = self.expectation(description: "testFetchGroupMembersWithAllInvalidLimit")
        let memberRequest = GroupMembersRequest.GroupMembersRequestBuilder(guid: TestConstants.grpPublic1).build()
        memberRequest.fetchNext(onSuccess: { (members) in
            validateGroupMembers(members: members)
            print("testFetchGroupMembersWithNoLimit onSuccess: \(members)")
            XCTAssertNotNil(members)
            expectation.fulfill()
        }) { (error) in
            print("testFetchGroupMembersWithNoLimit error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test095FetchGroupMembersWithValidLimitFilterBySetSearchKeyword(){
        let expectation = self.expectation(description: "testFetchGroupMembersWithValidLimitFilterBySetSearchKeyword")
        let memberRequest = GroupMembersRequest.GroupMembersRequestBuilder(guid: TestConstants.grpPublic1).set(limit: 20).set(searchKeyword: "supherhero3").build()
        memberRequest.fetchNext(onSuccess: { (members) in
            validateGroupMembers(members: members)
            print("testFetchGroupMembersWithValidLimitFilterBySetSearchKeyword onSuccess: \(members)")
            XCTAssertNotNil(members)
            expectation.fulfill()
        }) { (error) in
            print("testFetchGroupMembersWithValidLimitFilterBySetSearchKeyword error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test096FetchGroupMembersWithValidLimitFilterByInvalidSearchKeyword(){
        let expectation = self.expectation(description: "testFetchGroupMembersWithValidLimitFilterBySetSearchKeyword")
        let memberRequest = GroupMembersRequest.GroupMembersRequestBuilder(guid: TestConstants.grpPublic1).set(limit: 20).set(searchKeyword: "INVALID").build()
        memberRequest.fetchNext(onSuccess: { (members) in
            print("testFetchGroupMembersWithValidLimitFilterByInvalidSearchKeyword onSuccess: \(members)")
            XCTAssertNotNil(members)
            expectation.fulfill()
        }) { (error) in
            print("testFetchGroupMembersWithValidLimitFilterByInvalidSearchKeyword error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test097FetchGroupMembersWithValidLimitFilterByEmptySearchKeyword(){
        let expectation = self.expectation(description: "testFetchGroupMembersWithValidLimitFilterByEMPTYSearchKeyword")
        let memberRequest = GroupMembersRequest.GroupMembersRequestBuilder(guid: TestConstants.grpPublic1).set(limit: 20).set(searchKeyword: "").build()
        memberRequest.fetchNext(onSuccess: { (members) in
            print("testFetchGroupMembersWithValidLimitFilterByEMPTYSearchKeyword onSuccess: \(members)")
            XCTAssertNotNil(members)
            expectation.fulfill()
        }) { (error) in
            print("testFetchGroupMembersWithValidLimitFilterByEMPTYSearchKeyword error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    

////////////////////////////////////////////////////////////////////////////////////////////
    
///////////////////// COMETCHATPRO: GROUP ACTIONS : BAN MEMBER //////////////////////////////

    func test098BanGroupMember(){
        let expectation = self.expectation(description: "testBanGroupMember")
        
        CometChat.addMembersToGroup(guid: TestConstants.grpPublic2, groupMembers: [GroupMember(UID: TestConstants.testuser4, groupMemberScope: .participant)], onSuccess: { (success) in
            
            CometChat.banGroupMember(UID: TestConstants.testuser4, GUID: TestConstants.grpPublic2, onSuccess: { (success) in
                print("testBanGroupMember onSuccess: \(success)")
                XCTAssertNotNil(success)
                expectation.fulfill()
            }) { (error) in
                print("testBanGroupMember error: \(String(describing: error?.errorDescription))")
                
                XCTAssertEqual("The user with uid \(TestConstants.testuser4) is banned from a group with guid \(TestConstants.testGroup1).", error?.errorDescription)
                expectation.fulfill()
            }
            
        }, onError: { (error) in
            
            print("failed")
            
        })
            
        wait(for: [expectation], timeout: 30)
    }
    
    
    func test099BanGroupMemberWithEmptyUID(){
        let expectation = self.expectation(description: "testBanGroupMemberWithEmptyUID")
        CometChat.banGroupMember(UID: "", GUID: TestConstants.grpPublic1, onSuccess: { (success) in
            print("testBanGroupMemberWithEmptyUID onSuccess: \(success)")
           
        }) { (error) in
            print("testBanGroupMemberWithEmptyUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test100BanGroupMemberWithInvalidUID(){
        let expectation = self.expectation(description: "testBanGroupMemberWithInvalidUID")
        CometChat.banGroupMember(UID: "INVALID", GUID: TestConstants.grpPublic1, onSuccess: { (success) in
            print("testBanGroupMemberWithInvalidUID onSuccess: \(success)")
          
        }) { (error) in
            print("testBanGroupMemberWithInvalidUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test101BanGroupMemberWithInvalidGUID(){
        let expectation = self.expectation(description: "testBanGroupMemberWithInvalidGUID")
        CometChat.banGroupMember(UID: "superhero4", GUID:"INVALID", onSuccess: { (success) in
            print("testBanGroupMemberWithInvalidGUID onSuccess: \(success)")
          
        }) { (error) in
            print("testBanGroupMemberWithInvalidGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test102BanGroupMemberWithEmptyGUID(){
        let expectation = self.expectation(description: "testBanGroupMember")
        CometChat.banGroupMember(UID: "superhero4", GUID: "", onSuccess: { (success) in
            print("testBanGroupMemberWithEmptyGUID onSuccess: \(success)")
            
        }) { (error) in
            print("testBanGroupMemberWithEmptyGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test103BanGroupMemberWithEmptyUIDEmptyGUID(){
        let expectation = self.expectation(description: "testBanGroupMemberWithEmptyUIDEmptyGUID")
        CometChat.banGroupMember(UID: "", GUID: "", onSuccess: { (success) in
            print("testBanGroupMemberWithEmptyUIDEmptyGUID onSuccess: \(success)")
            
        }) { (error) in
            print("testBanGroupMemberWithEmptyUIDEmptyGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test104BanGroupMemberWithInvalidUIDInvalidGUID(){
        let expectation = self.expectation(description: "testBanGroupMemberWithInvalidUIDInvalidGUID")
        CometChat.banGroupMember(UID: "INVALID", GUID: "INVALID", onSuccess: { (success) in
            print("testBanGroupMemberWithInvalidUIDInvalidGUID onSuccess: \(success)")
            
        }) { (error) in
            print("testBanGroupMemberWithInvalidUIDInvalidGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }

////////////////////////////////////////////////////////////////////////////////////////////
    
///////////////////// COMETCHATPRO: GROUP ACTIONS : UNBAN MEMBER////////////////////////////
    
    func test105UnbanGroupMember(){
        let expectation = self.expectation(description: "testUnbanGroupMember")
        CometChat.unbanGroupMember(UID: TestConstants.testuser4, GUID: TestConstants.grpPublic2, onSuccess: { (success) in
            print("testUnbanGroupMember onSuccess: \(success)")
            XCTAssertNotNil(success)
            expectation.fulfill()
        }) { (error) in
            print("testUnbanGroupMember error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test106UnbanGroupMemberWithEmptyUID(){
        let expectation = self.expectation(description: "testUnbanGroupMemberWithEmptyUID")
        CometChat.unbanGroupMember(UID: "", GUID: TestConstants.grpPublic1, onSuccess: { (success) in
            print("testUnbanGroupMemberWithEmptyUID onSuccess: \(success)")
          
        }) { (error) in
            print("testUnbanGroupMemberWithEmptyUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test107UnbanGroupMemberWithInvalidUID(){
        let expectation = self.expectation(description: "testUnbanGroupMemberWithInvalidUID")
        CometChat.unbanGroupMember(UID: "INVALID", GUID: TestConstants.grpPublic1, onSuccess: { (success) in
            print("testUnbanGroupMemberWithInvalidUID onSuccess: \(success)")
           
        }) { (error) in
            print("testUnbanGroupMemberWithInvalidUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test108UnbanGroupMemberWithInvalidGUID(){
        let expectation = self.expectation(description: "testUnbanGroupMemberWithInvalidGUID")
        CometChat.unbanGroupMember(UID: "superhero4", GUID: "INVALID", onSuccess: { (success) in
            print("testUnbanGroupMemberWithInvalidGUID onSuccess: \(success)")
           
        }) { (error) in
            print("testUnbanGroupMemberWithInvalidGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test109UnbanGroupMemberWithEmptyGUID(){
        let expectation = self.expectation(description: "testUnbanGroupMemberWithEmptyGUID")
        CometChat.unbanGroupMember(UID: "superhero4", GUID: "", onSuccess: { (success) in
            print("testUnbanGroupMemberWithEmptyGUID onSuccess: \(success)")
         
        }) { (error) in
            print("testUnbanGroupMemberWithEmptyGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test110UnbanGroupMemberWithEmptyUIDEmptyGUID(){
        let expectation = self.expectation(description: "testUnbanGroupMemberWithEmptyUIDEmptyGUID")
        CometChat.unbanGroupMember(UID: "", GUID: "", onSuccess: { (success) in
            print("testUnbanGroupMemberWithEmptyUIDEmptyGUID onSuccess: \(success)")
            
        }) { (error) in
            print("testUnbanGroupMemberWithEmptyUIDEmptyGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test111UnbanGroupMemberWithInvalidUIDInvalidGUID(){
        let expectation = self.expectation(description: "testUnbanGroupMemberWithInvalidUIDInvalidGUID")
        CometChat.unbanGroupMember(UID: "INVALID", GUID: "INVALID", onSuccess: { (success) in
            print("testUnbanGroupMemberWithInvalidUIDInvalidGUID onSuccess: \(success)")
          
        }) { (error) in
            print("testUnbanGroupMemberWithInvalidUIDInvalidGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    

////////////////////////////////////////////////////////////////////////////////////////////
    
/////////////////COMETCHATPRO: GROUP ACTIONS : FETCH BANNED MEMBERS ////////////////////////
    
    
    func test112FetchBannedGroupMembersWithValidLimit(){
        
      let expectation = self.expectation(description: "Get List of banned members with valid Limit")
        var bannedGroupMembersRequest:BannedGroupMembersRequest!
        bannedGroupMembersRequest = BannedGroupMembersRequest.BannedGroupMembersRequestBuilder(guid: TestConstants.grpPublic1).set(limit: 30).build()
        
        bannedGroupMembersRequest.fetchNext(onSuccess: { (bannedMembers) in
            print("testFetchBannedGroupMembersWithValidLimit onSuccess: )")
            
            validateGroupMembers(members: bannedMembers)
            XCTAssertNotNil(bannedMembers)
            expectation.fulfill()
        }) { (error) in
            print("testFetchBannedGroupMembersWithValidLimit error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 60)
    }
    
    
    func test113FetchBannedGroupMembersWithInValidLimit(){
        let expectation = self.expectation(description: "testFetchBannedGroupMembersWithInValidLimit")
        let bannedMembersRequest = BannedGroupMembersRequest.BannedGroupMembersRequestBuilder(guid: TestConstants.grpPublic1).set(limit: 1000).build()
        bannedMembersRequest.fetchNext(onSuccess: { (bannedMembers) in
            print("testFetchBannedGroupMembersWithInValidLimit onSuccess: \(bannedMembers))")
        }) { (error) in
            print("testFetchBannedGroupMembersWithInValidLimit error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test114FetchBannedGroupMembersWithZeroLimit(){
        let expectation = self.expectation(description: "testFetchBannedGroupMembersWithZeroLimit")
        let bannedMembersRequest = BannedGroupMembersRequest.BannedGroupMembersRequestBuilder(guid: TestConstants.grpPublic1).set(limit: 0).build()
        bannedMembersRequest.fetchNext(onSuccess: { (bannedMembers) in
            print("testFetchBannedGroupMembersWithZeroLimit onSuccess: \(bannedMembers))")
            
        }) { (error) in
            print("testFetchBannedGroupMembersWithZeroLimit error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
           
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test115FetchBannedGroupMembersWithMinusLimit(){
        let expectation = self.expectation(description: "testFetchBannedGroupMembersWithMinusLimit")
        let bannedMembersRequest = BannedGroupMembersRequest.BannedGroupMembersRequestBuilder(guid: TestConstants.grpPublic1).set(limit: -1).build()
        bannedMembersRequest.fetchNext(onSuccess: { (bannedMembers) in
            print("testFetchBannedGroupMembersWithMinusLimit onSuccess: \(bannedMembers))")
        }) { (error) in
            print("testFetchBannedGroupMembersWithMinusLimit error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test116FetchBannedGroupMembersWithNoLimit(){
//        let expectation = self.expectation(description: "testFetchBannedGroupMembersWithNoLimit")
//        let bannedMembersRequest = BannedGroupMembersRequest.BannedGroupMembersRequestBuilder(guid: TestConstants.grpPublic1).build()
//        bannedMembersRequest.fetchNext(onSuccess: { (bannedMembers) in
//            print("testFetchBannedGroupMembersWithNoLimit onSuccess: \(bannedMembers))")
//            XCTAssertNotNil(bannedMembers)
//            expectation.fulfill()
//        }) { (error) in
//            print("testFetchBannedGroupMembersWithNoLimit error: \(String(describing: error?.errorDescription))")
//        }
//        wait(for: [expectation], timeout: 10)
    }
    
    func test117FetchBannedGroupMembersWithInvalidGUID(){
        let expectation = self.expectation(description: "testFetchBannedGroupMembersWithInvalidGUID")
        let bannedMembersRequest = BannedGroupMembersRequest.BannedGroupMembersRequestBuilder(guid: "INVALID").set(limit: 30).build()
        bannedMembersRequest.fetchNext(onSuccess: { (bannedMembers) in
            print("testFetchBannedGroupMembersWithInvalidGUID onSuccess: \(bannedMembers))")
        }) { (error) in
            print("testFetchBannedGroupMembersWithInvalidGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test118FetchBannedGroupMembersWithEmptyGUID(){
        let expectation = self.expectation(description: "testFetchBannedGroupMembersWithEmptyGUID")
        let bannedMembersRequest = BannedGroupMembersRequest.BannedGroupMembersRequestBuilder(guid: "").set(limit: 30).build()
        bannedMembersRequest.fetchNext(onSuccess: { (bannedMembers) in
            print("testFetchBannedGroupMembersWithEmptyGUID onSuccess: \(bannedMembers))")
        }) { (error) in
            print("testFetchBannedGroupMembersWithEmptyGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test119FetchBannedGroupMembersWithSetSearchKeyword(){
        let expectation = self.expectation(description: "testFetchBannedGroupMembersWithSetSearchKeyword")
        let bannedMembersRequest = BannedGroupMembersRequest.BannedGroupMembersRequestBuilder(guid: TestConstants.grpPublic1).set(limit: 30).set(searchKeyword: "super").build()
        bannedMembersRequest.fetchNext(onSuccess: { (bannedMembers) in
            validateGroupMembers(members: bannedMembers)
            print("testFetchBannedGroupMembersWithSetSearchKeyword onSuccess: \(bannedMembers))")
            XCTAssertNotNil(bannedMembers)
            expectation.fulfill()
        }) { (error) in
            print("testFetchBannedGroupMembersWithSetSearchKeyword error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test120FetchBannedGroupMembersWithSetSearchKeywordInvalid(){
        let expectation = self.expectation(description: "testFetchBannedGroupMembersWithSetSearchKeyword")
        let bannedMembersRequest = BannedGroupMembersRequest.BannedGroupMembersRequestBuilder(guid: TestConstants.grpPublic1).set(limit: 30).set(searchKeyword: "abc").build()
        bannedMembersRequest.fetchNext(onSuccess: { (bannedMembers) in
            print("testFetchBannedGroupMembersWithSetSearchKeywordInvalid onSuccess: \(bannedMembers))")
            XCTAssertNotNil(bannedMembers)
            expectation.fulfill()
        }) { (error) in
            print("testFetchBannedGroupMembersWithSetSearchKeywordInvalid error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test121FetchBannedGroupMembersWithSetSearchKeywordEmpty(){
        let expectation = self.expectation(description: "testFetchBannedGroupMembersWithSetSearchKeywordEmpty")
        let bannedMembersRequest = BannedGroupMembersRequest.BannedGroupMembersRequestBuilder(guid: TestConstants.grpPublic1).set(limit: 30).set(searchKeyword: "").build()
        bannedMembersRequest.fetchNext(onSuccess: { (bannedMembers) in
            print("testFetchBannedGroupMembersWithSetSearchKeywordEmpty onSuccess: \(bannedMembers))")
            XCTAssertNotNil(bannedMembers)
            expectation.fulfill()
        }) { (error) in
            print("testFetchBannedGroupMembersWithSetSearchKeywordEmpty error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test122FetchBannedGroupMembersWithAllValidParameters(){
        let expectation = self.expectation(description: "testFetchBannedGroupMembersWithAllValidParameters")
        let bannedMembersRequest = BannedGroupMembersRequest.BannedGroupMembersRequestBuilder(guid: TestConstants.grpPublic1).set(limit: 30).set(searchKeyword: "super").build()
        bannedMembersRequest.fetchNext(onSuccess: { (bannedMembers) in
            validateGroupMembers(members: bannedMembers)
            print("testFetchBannedGroupMembersWithAllValidParameters onSuccess: \(bannedMembers))")
            XCTAssertNotNil(bannedMembers)
            expectation.fulfill()
        }) { (error) in
            print("testFetchBannedGroupMembersWithAllValidParameters error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test123FetchBannedGroupMembersWithAllInValidParameters(){
        let expectation = self.expectation(description: "testFetchBannedGroupMembersWithAllValidParameters")
        let bannedMembersRequest = BannedGroupMembersRequest.BannedGroupMembersRequestBuilder(guid: "INVALID").set(limit: 1000).set(searchKeyword: "abc").build()
        bannedMembersRequest.fetchNext(onSuccess: { (bannedMembers) in
            print("testFetchBannedGroupMembersWithAllInValidParameters onSuccess: \(bannedMembers))")
           
        }) { (error) in
            print("testFetchBannedGroupMembersWithAllInValidParameters error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
////////////////////////////////////////////////////////////////////////////////////////////
    
///////////////////////  COMETCHATPRO: GROUP ACTIONS : CHANGE SCOPE ////////////////////////
    
    
    func test124ChangeScopeOfMemberToParticipant(){
        let expectation = self.expectation(description: "testChangeScopeOfMemberToParticipant")
        
        CometChat.addMembersToGroup(guid: TestConstants.grpPublic2, groupMembers: [GroupMember(UID: TestConstants.testuser4, groupMemberScope: .moderator)], onSuccess: { (success) in
            
            CometChat.updateGroupMemberScope(UID: TestConstants.testuser4, GUID: TestConstants.grpPublic2, scope: .participant, onSuccess: { (sucess) in
                print("testChangeScopeOfMemberToParticipant onSuccess \(sucess)")
                XCTAssertNotNil(sucess)
                expectation.fulfill()
            }) { (error) in
                print("testChangeScopeOfMemberToParticipant error: \(String(describing: error?.errorDescription))")
                XCTAssertEqual(error?.errorDescription, "Member already has the same scope participant")
                expectation.fulfill()
            }
            
        }) { (error) in
            
            print("testChangeScopeOfMemberToParticipant error: \(String(describing: error?.errorDescription))")
        }
        
        
        wait(for: [expectation], timeout: 30)
    }
    
    
    func test125ChangeScopeOfMemberToModorator(){
        let expectation = self.expectation(description: "testChangeScopeOfMemberToModorator")
        CometChat.updateGroupMemberScope(UID: TestConstants.testuser4, GUID: TestConstants.grpPublic2, scope: .moderator, onSuccess: { (sucess) in
            print("testChangeScopeOfMemberToModorator onSuccess \(sucess)")
            XCTAssertNotNil(sucess)
            expectation.fulfill()
        }) { (error) in
            print("testChangeScopeOfMemberToModorator error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test126ChangeScopeOfMemberToAdmin(){
        let expectation = self.expectation(description: "testChangeScopeOfMember")
        CometChat.updateGroupMemberScope(UID: TestConstants.testuser4, GUID: TestConstants.grpPublic2, scope: .admin, onSuccess: { (sucess) in
            print("testChangeScopeOfMember onSuccess \(sucess)")
            XCTAssertNotNil(sucess)
            expectation.fulfill()
        }) { (error) in
            print("testChangeScopeOfMember error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    
    func test127ChangeScopeOfMemberToAdminWithInvalidUID(){
        let expectation = self.expectation(description: "testChangeScopeOfMemberToAdminWithInvalidUID")
        CometChat.updateGroupMemberScope(UID: "INVALID", GUID: TestConstants.grpPublic1, scope: .admin, onSuccess: { (sucess) in
            print("testChangeScopeOfMemberToAdminWithInvalidUID onSuccess \(sucess)")
            
        }) { (error) in
            print("testChangeScopeOfMemberToAdminWithInvalidUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    
    
    func test128ChangeScopeOfMemberToParticipantInvalidUID(){
        let expectation = self.expectation(description: "testChangeScopeOfMemberToParticipantInvalidUID")
        CometChat.updateGroupMemberScope(UID: "INVALID", GUID: TestConstants.grpPublic1, scope: .participant, onSuccess: { (sucess) in
            print("testChangeScopeOfMemberToParticipantInvalidUID onSuccess \(sucess)")
            
        }) { (error) in
            print("testChangeScopeOfMemberToParticipantInvalidUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test129ChangeScopeOfMemberToAdminWithEmptyUID(){
        let expectation = self.expectation(description: "testChangeScopeOfMemberToAdminWithEmptyUID")
        CometChat.updateGroupMemberScope(UID: "", GUID: TestConstants.grpPublic1, scope: .admin, onSuccess: { (sucess) in
            print("testChangeScopeOfMemberToAdminWithEmptyUID onSuccess \(sucess)")
            
        }) { (error) in
            print("testChangeScopeOfMemberToAdminWithEmptyUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    
    func test130ChangeScopeOfMemberToParticipantEmptyUID(){
        let expectation = self.expectation(description: "testChangeScopeOfMemberToParticipantInvalidUID")
        CometChat.updateGroupMemberScope(UID: "", GUID: TestConstants.grpPublic1, scope: .participant, onSuccess: { (sucess) in
            print("testChangeScopeOfMemberToParticipantEmptyUID onSuccess \(sucess)")
            
        }) { (error) in
            print("testChangeScopeOfMemberToParticipantEmptyUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test131ChangeScopeOfMemberToAdminWithInvalidGUID(){
        let expectation = self.expectation(description: "testChangeScopeOfMemberToAdminWithInvalidGUID")
        CometChat.updateGroupMemberScope(UID: TestConstants.user2, GUID: "INVALID", scope: .admin, onSuccess: { (sucess) in
            print("testChangeScopeOfMemberToAdminWithInvalidGUID onSuccess \(sucess)")
            
        }) { (error) in
            print("testChangeScopeOfMemberToAdminWithInvalidGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test132ChangeScopeOfMemberToModoratorWithInvalidGUID(){
        let expectation = self.expectation(description: "testChangeScopeOfMemberToModoratorWithInvalidGUID")
        CometChat.updateGroupMemberScope(UID: "superhero4", GUID: "INVALID", scope: .moderator, onSuccess: { (sucess) in
            print("testChangeScopeOfMemberToAdminWithInvalidGUID onSuccess \(sucess)")
            
        }) { (error) in
            print("testChangeScopeOfMemberToAdminWithInvalidGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test133ChangeScopeOfMemberToParticipantWithInvalidGUID(){
        let expectation = self.expectation(description: "testChangeScopeOfMemberToAdminWithInvalidGUID")
        CometChat.updateGroupMemberScope(UID: "superhero5", GUID: "INVALID", scope: .participant, onSuccess: { (sucess) in
            print("testChangeScopeOfMemberToAdminWithInvalidGUID onSuccess \(sucess)")
            
        }) { (error) in
            print("testChangeScopeOfMemberToAdminWithInvalidGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test134ChangeScopeOfMemberToAdminWithEmptyGUID(){
        let expectation = self.expectation(description: "testChangeScopeOfMemberToAdminWithEmptyGUID")
        CometChat.updateGroupMemberScope(UID: TestConstants.user2, GUID: "", scope: .admin, onSuccess: { (sucess) in
            print("testChangeScopeOfMemberToAdminWithEmptyGUID onSuccess \(sucess)")
            
        }) { (error) in
            print("testChangeScopeOfMemberToAdminWithEmptyGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test135ChangeScopeOfMemberToModoratorWithEmptyGUID(){
        let expectation = self.expectation(description: "testChangeScopeOfMemberToModoratorWithEmptyGUID")
        CometChat.updateGroupMemberScope(UID: "superhero4", GUID: "", scope: .moderator, onSuccess: { (sucess) in
            print("testChangeScopeOfMemberToModoratorWithEmptyGUID onSuccess \(sucess)")
            
        }) { (error) in
            print("testChangeScopeOfMemberToModoratorWithEmptyGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test136ChangeScopeOfMemberToParticipantWithEmptyGUID(){
        let expectation = self.expectation(description: "testChangeScopeOfMemberToParticipantWithEmptyGUID")
        CometChat.updateGroupMemberScope(UID: "superhero5", GUID: "", scope: .participant, onSuccess: { (sucess) in
            print("testChangeScopeOfMemberToParticipantWithEmptyGUID onSuccess \(sucess)")
            
        }) { (error) in
            print("testChangeScopeOfMemberToParticipantWithEmptyGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test137ChangeScopeOfMemberToAdminWithEmptyGUIDEmptyUID(){
        let expectation = self.expectation(description: "testChangeScopeOfMemberToAdminWithEmptyGUIDEmptyUID")
        CometChat.updateGroupMemberScope(UID: "", GUID: "", scope: .admin, onSuccess: { (sucess) in
            print("testChangeScopeOfMemberToAdminWithEmptyGUIDEmptyUID onSuccess \(sucess)")
            
        }) { (error) in
            print("testChangeScopeOfMemberToAdminWithEmptyGUIDEmptyUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test138ChangeScopeOfMemberToModoratorWithEmptyGUIDEmptyUID(){
        let expectation = self.expectation(description: "testChangeScopeOfMemberToModoratorWithEmptyGUID")
        CometChat.updateGroupMemberScope(UID: "", GUID: "", scope: .moderator, onSuccess: { (sucess) in
            print("testChangeScopeOfMemberToModoratorWithEmptyGUIDEmptyUID onSuccess \(sucess)")
            
        }) { (error) in
            print("testChangeScopeOfMemberToModoratorWithEmptyGUIDEmptyUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test139ChangeScopeOfMemberToParticipantWithEmptyGUIDEmptyUID(){
        let expectation = self.expectation(description: "testChangeScopeOfMemberToParticipantWithEmptyGUID")
        CometChat.updateGroupMemberScope(UID: "", GUID: "", scope: .participant, onSuccess: { (sucess) in
            print("testChangeScopeOfMemberToParticipantWithEmptyGUIDEmptyUID onSuccess \(sucess)")
            
        }) { (error) in
            print("testChangeScopeOfMemberToParticipantWithEmptyGUIDEmptyUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test140ChangeScopeOfMemberToAdminWithInvalidGUIDInvalidUID(){
        let expectation = self.expectation(description: "testChangeScopeOfMemberToAdminWithInvalidGUIDInvalidUID")
        CometChat.updateGroupMemberScope(UID: "INVALID", GUID: "INVALID", scope: .admin, onSuccess: { (sucess) in
            print("testChangeScopeOfMemberToAdminWithInvalidGUIDInvalidUID onSuccess \(sucess)")
            
        }) { (error) in
            print("testChangeScopeOfMemberToAdminWithInvalidGUIDInvalidUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test141ChangeScopeOfMemberToModoratorWithInvalidGUIDInvalidUID(){
        let expectation = self.expectation(description: "testChangeScopeOfMemberToModoratorWithInvalidGUIDInvalidUID")
        CometChat.updateGroupMemberScope(UID: "INVALID", GUID: "INVALID", scope: .moderator, onSuccess: { (sucess) in
            print("testChangeScopeOfMemberToModoratorWithInvalidGUIDInvalidUID onSuccess \(sucess)")
            
        }) { (error) in
            print("testChangeScopeOfMemberToModoratorWithInvalidGUIDInvalidUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test142ChangeScopeOfMemberToParticipantWithInvalidGUIDInvalidUID(){
        let expectation = self.expectation(description: "testChangeScopeOfMemberToParticipantWithEmptyGUID")
        CometChat.updateGroupMemberScope(UID: "INVALID", GUID: "INVALID", scope: .participant, onSuccess: { (sucess) in
            print("testChangeScopeOfMemberToParticipantWithInvalidGUIDInvalidUID onSuccess \(sucess)")
            
        }) { (error) in
            print("testChangeScopeOfMemberToParticipantWithInvalidGUIDInvalidUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
////////////////////////////////////////////////////////////////////////////////////////////
    
///////////////////// COMETCHATPRO: GROUP ACTIONS : KICK MEMBER/////////////////////////////
    
    
    func test143KickGroupMember(){
        let expectation = self.expectation(description: "testKickGroupMember")
        
        // If test case fail due to 'The user with uid superhero2 is banned from a group with guid supergroup', Kindly, uncomment and re - run the case.
//        CometChat.joinGroup(GUID: TestConstants.grpPublic1, groupType: .public, password: nil, onSuccess: { (sucess) in
//
//        }) { (error) in
//
//        }
        
        CometChat.kickGroupMember(UID: TestConstants.testuser4, GUID: TestConstants.grpPublic2, onSuccess: { (success) in
            print("testKickGroupMember onSuccess: \(success)")
            XCTAssertNotNil(success)
            expectation.fulfill()
        }) { (error) in
            print("testKickGroupMember error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test144KickGroupMemberWithEmptyUID(){
        let expectation = self.expectation(description: "testKickGroupMember")
        CometChat.kickGroupMember(UID: "", GUID: TestConstants.grpPublic1, onSuccess: { (success) in
            print("testKickGroupMemberWithEmptyUID onSuccess: \(success)")
            
        }) { (error) in
            print("testKickGroupMemberWithEmptyUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test145KickGroupMemberWithInvalidUID(){
        let expectation = self.expectation(description: "testKickGroupMember")
        CometChat.kickGroupMember(UID: "INVALID", GUID: TestConstants.grpPublic1, onSuccess: { (success) in
            print("testKickGroupMemberWithInvalidUID onSuccess: \(success)")
            
        }) { (error) in
            print("testKickGroupMemberWithInvalidUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test146KickGroupMemberWithInvalidGUID(){
        let expectation = self.expectation(description: "testKickGroupMember")
        CometChat.kickGroupMember(UID: "supherhero3", GUID: "INVALID", onSuccess: { (success) in
            print("testKickGroupMemberWithInvalidGUID onSuccess: \(success)")
            
        }) { (error) in
            print("testKickGroupMemberWithInvalidGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test147KickGroupMemberWithEmptyGUID(){
        let expectation = self.expectation(description: "testKickGroupMember")
        CometChat.kickGroupMember(UID: "supherhero3", GUID: "", onSuccess: { (success) in
            print("testKickGroupMemberWithEmptyGUID onSuccess: \(success)")
            
        }) { (error) in
            print("testKickGroupMemberWithEmptyGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    
    func test148KickGroupMemberWithEmptyUIDEmptyGUID(){
        let expectation = self.expectation(description: "testKickGroupMember")
        CometChat.kickGroupMember(UID: "", GUID: "", onSuccess: { (success) in
            print("testKickGroupMemberWithEmptyUIDEmptyGUID onSuccess: \(success)")
            
        }) { (error) in
            print("testKickGroupMemberWithEmptyUIDEmptyGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test149KickGroupMemberWithInvalidUIDInvalidGUID(){
        let expectation = self.expectation(description: "testKickGroupMember")
        CometChat.kickGroupMember(UID: "INVALID", GUID: "INVALID", onSuccess: { (success) in
            print("testKickGroupMemberWithInvalidUIDInvalidGUID onSuccess: \(success)")
            
        }) { (error) in
            print("testKickGroupMemberWithInvalidUIDInvalidGUID error: \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }

    



////////////////////////////////////////////////////////////////////////////////////////////
    
/////////////////////////////   COMETCHATPRO: DELETE GROUP  ////////////////////////////////
    
    func test150DeleteGroup(){
      let expectation = self.expectation(description: "testDeleteGroup")
        CometChat.deleteGroup(GUID: TestConstants.grpPublic2, onSuccess: { (sucess) in
           print("testDeleteGroup onSuccess \(sucess)")
            XCTAssertNotNil(sucess)
            expectation.fulfill()
        }) { (error) in
            print("testDeleteGroup error \(error?.errorDescription)")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test151DeleteGroupWithEmptyGUID(){
        let expectation = self.expectation(description: "testDeleteGroupWithEmptyGUID")
        CometChat.deleteGroup(GUID: "", onSuccess: { (sucess) in
            print("testDeleteGroupWithEmptyGUID onSuccess \(sucess)")
         
        }) { (error) in
            print("testDeleteGroupWithEmptyGUID error \(error?.errorDescription)")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test152DeleteGroupWithInvalidGUID(){
        let expectation = self.expectation(description: "testDeleteGroupWithInvalidGUID")
        CometChat.deleteGroup(GUID: "INVALID", onSuccess: { (sucess) in
            print("testDeleteGroupWithInvalidGUID onSuccess \(sucess)")
            
        }) { (error) in
            print("testDeleteGroupWithInvalidGUID error \(String(describing: error?.errorDescription))")
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }
    
////////////////////////////////////////////////////////////////////////////////////////////

    func test153FetchGroupMembersWithAllValidScopes(){
        let expectation = self.expectation(description: "test153FetchGroupMembersWithAllValidScopes")
        let memberRequest = GroupMembersRequest.GroupMembersRequestBuilder(guid: TestConstants.grpPublic1).set(limit: 20).set(scopes : ["admin","participant"]).build()
        memberRequest.fetchNext(onSuccess: { (members) in
            
            validateGroupMembers(members: members)
           print("test153FetchGroupMembersWithAllValidScopes onSuccess: \(members)")
            XCTAssertNotNil(members)
            expectation.fulfill()
        }) { (error) in
            print("test153FetchGroupMembersWithAllValidScopes error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test154FetchGroupMembersWithAllEmptyScopes(){
        let expectation = self.expectation(description: "test154FetchGroupMembersWithAllEmptyScopes")
        let memberRequest = GroupMembersRequest.GroupMembersRequestBuilder(guid: TestConstants.grpPublic1).set(limit: 20).set(scopes : []).build()
        memberRequest.fetchNext(onSuccess: { (members) in
            
            validateGroupMembers(members: members)
           print("test154FetchGroupMembersWithAllEmptyScopes onSuccess: \(members)")
            XCTAssertNotNil(members)
            expectation.fulfill()
        }) { (error) in
            print("test154FetchGroupMembersWithAllEmptyScopes error: \(String(describing: error?.errorDescription))")
        }
        wait(for: [expectation], timeout: 10)
    }
}
