//
//  FirebasePlugin.swift
//  PluginsForIOSLibrary
//
//  Created by FMA1 on 25.05.21.
//  Copyright © 2021 FMA1. All rights reserved.
//

import Foundation
import Firebase

/**
 Diese Klasse hält die Daten des eingeloggten Nutzers
 - Parameter uid: Die einzigartige ID des Nutzers
 - Parameter email: Die Emailadressse des Nutzers
 - Parameter displayName: Der Anzeigename des Nutzers (nicht einzigartig)
 - Parameter isEmailVerified: Gibt an, ob der Nutzer seine Emailadresse verifiziert hat
 */
public class TPFirebaseAuthenticationUser {
    /// Die einzigartige ID des Nutzers
    public var uid: String
    /// Die Emailadressse des Nutzers
    public var email: String
    /// Der Anzeigename des Nutzers (nicht einzigartig)
    public var displayName: String?
    /// Gibt an, ob der Nutzer seine Emailadresse verifiziert hat
    public var isEmailVerified: Bool
    
    /**
    Konstruktor (kann nur von der TPFirebaseAuthentication-Library verwendet werden)
    - Parameter uid: Die einzigartige ID des Nutzers
    - Parameter email: Die Emailadressse des Nutzers
    - Parameter displayName: Der Anzeigename des Nutzers (nicht einzigartig)
    - Parameter isEmailVerified: Gibt an, ob der Nutzer seine Emailadresse verifiziert hat
    */
    fileprivate init(uid: String, email: String, displayName: String? = nil, isEmailVerified: Bool) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
        self.isEmailVerified = isEmailVerified
    }
    
    public func toString() -> String {
        return "mail: \(email), name: \(displayName ?? "/")"
    }
}

/**
 Diese Klasse stellt Methoden für die Authentifizierung eines Nutzers bereit
*/
public struct TPFirebaseAuthentication {
    
    /**
     Anmelden eines Nutzers mit Hilfe seiner Credentials
     - Parameter email: Nutzeremailadresse
     - Parameter password: Nutzerpasswort
     - Parameter callback: Callback für Ergebnisrückgabe
     - Parameter user: Nutzer (Im Erfolgsfall)
     - Parameter error: Fehlermeldung (Bei Misserfolg)
     # Reference TPFirebaseAuthenticationUser
     */
    public static func signIn(
        email: String,
        password: String,
        callback: @escaping(_ user: TPFirebaseAuthenticationUser?, _ error: String?) -> Void
    ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { result, error in
            if let user = result?.user {
                let tpUser = TPFirebaseAuthenticationUser(uid: user.uid, email: user.email!, displayName: user.displayName, isEmailVerified: user.isEmailVerified)
                callback(tpUser, nil)
            } else {
                callback(nil, "\(error!.localizedDescription)")
            }
        })
    }
    
    /**
    Registrieren eines neuen Nutzers mit Hilfe einer Emailadresse und eines Passworts
    - Parameter email: Nutzeremailadresse
    - Parameter password: Nutzerpasswort
    - Parameter callback: Callback für Ergebnisrückgabe
    - Parameter user: Nutzer (Im Erfolgsfall)
    - Parameter error: Fehlermeldung (Bei Misserfolg)
    # Reference TPFirebaseAuthenticationUser
    */
    public static func signUp(
        email: String,
        password: String,
        callback: @escaping(_ user: TPFirebaseAuthenticationUser?, _ error: String?) -> Void
    ) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
            if let user = result?.user {
                let tpUser = TPFirebaseAuthenticationUser(uid: user.uid, email: user.email!, displayName: user.displayName, isEmailVerified: user.isEmailVerified)
                callback(tpUser, nil)
            } else {
                callback(nil, "\(error!.localizedDescription)")
            }
        })
    }
    
    /**
    Registrieren eines neuen Nutzers mit Hilfe einer Emailadresse, eines Passworts und eines Anzeigenamens
    - Parameter email: Nutzeremailadresse
    - Parameter password: Nutzerpasswort
    - Parameter displayName: Anzeigename
    - Parameter callback: Callback für Ergebnisrückgabe
    - Parameter user: Nutzer (Im Erfolgsfall)
    - Parameter error: Fehlermeldung (Bei Misserfolg)
    # Reference TPFirebaseAuthenticationUser
    */
    public static func signUp(
        email: String,
        password: String,
        displayName: String,
        callback: @escaping(_ user: TPFirebaseAuthenticationUser?, _ error: String?) -> Void
    ) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
            if let firebaseUser = result?.user {
                let changeRequest = firebaseUser.createProfileChangeRequest()
                changeRequest.displayName = displayName
                changeRequest.commitChanges(completion: { error in
                    if error == nil {
                        let tpUser = TPFirebaseAuthenticationUser(uid: firebaseUser.uid, email: firebaseUser.email!, displayName: displayName, isEmailVerified: firebaseUser.isEmailVerified)
                        callback(tpUser, nil)
                    } else {
                        let tpUser = TPFirebaseAuthenticationUser(uid: firebaseUser.uid, email: firebaseUser.email!, displayName: nil, isEmailVerified: firebaseUser.isEmailVerified)
                        callback(tpUser, "\(error!.localizedDescription)")
                    }
                })
            } else {
                callback(nil, "\(error!.localizedDescription)")
            }
        })
    }
    
    /**
     Meldet angemeldeten Nutzer ab
     */
    public static func signOut() {
        do {
            try Auth.auth().signOut()
        } catch { }
    }
    
    /**
     Gibt den aktuell angemeldeten Nutzer zurück, ist keiner angemeldet wird null zurückgegeben
     - Returns: Angemeldeten Nutzer als TPFirebaseAuthenticationUser-Objekt
     # Reference TPFirebaseAuthenticationUser
     */
    public static func getUser() -> TPFirebaseAuthenticationUser? {
        if let firebaseUser = Auth.auth().currentUser {
            return TPFirebaseAuthenticationUser(uid: firebaseUser.uid, email: firebaseUser.email!, displayName: firebaseUser.displayName, isEmailVerified: firebaseUser.isEmailVerified)
        }
        return nil
    }
    
    /**
    Aktualisiert die Emailadresse des aktuell angemeldeten Nutzers
    - Parameter email: Nutzeremailadresse
    - Parameter callback: Callback für Ergebnisrückgabe (nur bei Misserfolg)
    - Parameter error: Fehlermeldung (Bei Misserfolg)
    */
    public static func updateCurrentUserEmail(
        email: String,
        callback: @escaping(_ error: String?) -> Void
    ) {
        if isSignedIn() {
            Auth.auth().currentUser!.updateEmail(to: email, completion: { error in
                if error == nil {
                    callback(nil)
                } else {
                    callback("\(error!.localizedDescription)")
                }
            })
        } else {
            callback("No user signed in")
        }
    }
    
    /**
    Aktualisiert den Anzeigename des aktuell angemeldeten Nutzers
    - Parameter displayName: Anzeigename
    - Parameter callback: Callback für Ergebnisrückgabe (nur bei Misserfolg)
    - Parameter error: Fehlermeldung (Bei Misserfolg)
    */
    public static func updateCurrentUserDisplayName(
        displayName: String,
        callback: @escaping(_ error: String?) -> Void
    ) {
        if let firebaseUser = Auth.auth().currentUser {
            let changeRequest = firebaseUser.createProfileChangeRequest()
            changeRequest.displayName = displayName
            changeRequest.commitChanges(completion: { error in
                if error == nil {
                    callback(nil)
                } else {
                    callback("\(error!.localizedDescription)")
                }
            })
        } else {
            callback("No user signed in")
        }
    }
    
    /**
    Löscht den aktuell angemeldeten Nutzer und loggt ihn aus
    - Parameter callback: Callback für Ergebnisrückgabe (nur bei Misserfolg)
    - Parameter error: Fehlermeldung (Bei Misserfolg)
    */
    public static func deleteUser(
        callback: @escaping(_ error: String?) -> Void
    ) {
        if isSignedIn() {
            Auth.auth().currentUser!.delete(completion: { error in
                if error == nil {
                    callback(nil)
                } else {
                    callback("\(error!.localizedDescription)")
                }
            })
        }
    }
    
    /**
    Prüft, ob ein Nutzer aktuell angemeldet ist
    - Returns: Ob der Nutzer aktuell angemeldet ist als Bool
    */
    public static func isSignedIn() -> Bool {
        return getUser() !== nil
    }
    
    /**
    Sendet eine Nachricht zur Verifikation an die Emailadresse des aktuell angemeldeten Nutzers
    - Parameter callback: Callback für Ergebnisrückgabe (nur bei Misserfolg)
    - Parameter error: Fehlermeldung (Bei Misserfolg)
    */
    public static func sendEmailVerification(
        callback: @escaping(_ error: String?) -> Void
    ) {
        if isSignedIn() {
            Auth.auth().currentUser!.sendEmailVerification(completion: { error in
                if error == nil {
                    callback(nil)
                } else {
                    callback("\(error!.localizedDescription)")
                }
            })
        } else {
            callback("No user signed in")
        }
    }
    
    /**
    Sendet eine Nachricht zur Zurücksetzung des Passwortes an die Emailadresse des aktuell angemeldeten Nutzers
    - Parameter callback: Callback für Ergebnisrückgabe (nur bei Misserfolg)
    - Parameter error: Fehlermeldung (Bei Misserfolg)
    */
    public static func sendPasswordResetEmail(
        callback: @escaping(_ error: String?) -> Void
    ) {
        if isSignedIn() {
            Auth.auth().sendPasswordReset(withEmail: getUser()!.email, completion: { error in
                if error == nil {
                    callback(nil)
                } else {
                    callback("\(error!.localizedDescription)")
                }
            })
        } else {
            callback("No user signed in")
        }
    }
}
