/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.
import Foundation

public struct SIWARequestBody: Codable {
    public init(id: String, email: String? = nil, state: String? = nil, authorizationCode: Data? = nil, name: String? = nil, identityToken: Data? = nil, apiToken: String? = nil) {
        self.id = id
        self.email = email
        self.state = state
        self.authorizationCode = authorizationCode
        self.name = name
        self.identityToken = identityToken
        self.apiToken = apiToken
    }
    
    /// Apple user identifier.  Remember it might be a relay!
    public let id: String
    
    /// The email address to use for user communications.  Remember it might be a relay!
    public let email: String?
    
    /** @abstract A copy of the state value that was passed to ASAuthorizationRequest.
     */
    public let state: String?
    
    /** @abstract A short-lived, one-time valid token that provides proof of authorization to the server component of the app. The authorization code is bound to the specific transaction using the state attribute passed in the authorization request. The server component of the app can validate the code using Apple’s identity service endpoint provided for this purpose.
     */
    public let authorizationCode: Data?
    
    /// The components which make up the user's name.  See `displayName(style:)`
    public let name: String?
    
    /** @abstract A JSON Web Token (JWT) used to communicate information about the identity of the user in a secure way to the app. The ID token will contain the following information: Issuer Identifier, Subject Identifier, Audience, Expiry Time and Issuance Time signed by Apple's identity service.
     */
    public let identityToken: Data?
    
    /// The Stranded API JWT token
    public let apiToken: String?
}
