"""
Each file that starts with test... in this directory is scanned for subclasses of unittest.TestCase or testLib.RestTestCase
"""

import unittest
import os
import testLib
        
class TestAddUser(testLib.RestTestCase):
    """Test adding users"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        """
        Check that the response data dictionary matches the expected values
        """
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)

    def testEmptyUsername(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : '', 'password' : 'password'} )
        self.assertResponse(respData, None, testLib.RestTestCase.ERR_BAD_USERNAME)

    
    def testAdd2(self):
        respData1 = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user2.1', 'password' : 'password'} )
        respData2 = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user2.2', 'password' : 'password'} )
        self.assertResponse(respData1, count = 1)

    def testLogin(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user3', 'password' : 'password'} )
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user3', 'password' : 'password'} )
        self.assertResponse(respData, count = 2)

    def testWrongPw(self):
        respData = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user4', 'password' : 'password'} )
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user4', 'password' : 'wordpass'} )
        self.assertResponse(respData, None, testLib.RestTestCase.ERR_BAD_CREDENTIALS)

    def testLogin2(self):
        self.makeRequest("/users/login", method="POST", data = { 'user' : 'user5', 'password' : 'password'} )
        respData = self.makeRequest("/users/login", method="POST", data = { 'user' : 'user5.1', 'password' : 'password'} )
        self.assertResponse(respData, None, testLib.RestTestCase.ERR_BAD_CREDENTIALS)

    def testAdd3(self):
        self.makeRequest("/users/add", method="POST", data = { 'user' : 'user6', 'password' : 'password'} )
        respData1 = self.makeRequest("/users/add", method="POST", data = { 'user' : 'user6', 'password' : 'password'} )
        self.assertResponse(respData, count=1, testLib.RestTestCase.ERR_USER_EXISTS)
