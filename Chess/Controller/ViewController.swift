//
//  ViewController.swift
//  Chess
//
//  Created by Dhruv Shah on 2022-01-06.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController{
    
    // Model:
    var chessEngine: ChessEngine = ChessEngine()
    
    // View:
    @IBOutlet weak var boardView: BoardView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    
    
    // MultiPeerConnectivity Variables:
    var peerID: MCPeerID!
    var session: MCSession!
    var nearbyServiceAdvertiser: MCNearbyServiceAdvertiser!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Modify View Elements:
        createButton.layer.cornerRadius = 10
        joinButton.layer.cornerRadius = 10
        createButton.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        joinButton.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        
        // Gives the delegate a func for move piece from the current instance (self) which we provide
        boardView.chessDelegate = self
        
        chessEngine.initializeGame()
        boardView.shawdowPiece = chessEngine.pieces
        boardView.setNeedsDisplay()
        
        
        // Intialize Multipeer Connectivity Variables:
        
        // uniquely identify an app running on a device to nearby peers
        peerID = MCPeerID(displayName: UIDevice.current.name)
        
        // support communication between connected peer devices
        /// App creates a session and adds peers to it when peers accept an invitation to connect
        /// creates a session when invited to connect by another peer.
        /// Session objects maintain a set of peer ID objects that represent the peers connected to the session.
    
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        
    }
    
    // Advertise: Give Out Signal for MC
    @IBAction func advertise(_ sender: Any) {
        
        // tell nearby peers that your app is willing to join sessions of a specified type
        nearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "Chess")
        
        nearbyServiceAdvertiser.delegate = self
        
        // Begins advertising the service provided by a local peer.
        nearbyServiceAdvertiser.startAdvertisingPeer()
        
        // Make player Black
        boardView.blackOnTop = false
        boardView.setNeedsDisplay() // Redraw
    }
    
    // Connect to Advertised Signal & Join
    @IBAction func join(_ sender: Any) {
        
        // let your app search programmatically for nearby devices with "Chess" session
        let browser = MCBrowserViewController(serviceType: "Chess", session: session)
        browser.delegate = self
        present(browser, animated: true)
        
        // Make Player White
        boardView.blackOnTop = true
        boardView.setNeedsDisplay()
    }
    
    @IBAction func reset(_ sender: Any) {
        chessEngine.initializeGame()
        boardView.shawdowPiece = chessEngine.pieces
        boardView.setNeedsDisplay()
        infoLabel.text = "White's Turn"
        
        
        // Send Data
        if let data = "Reset".data(using: .utf8) {
            try? session.send(data, toPeers: session.connectedPeers, with: .reliable)
        }
        
    }
}
