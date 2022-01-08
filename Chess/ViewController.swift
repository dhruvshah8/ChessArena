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
    
    
    // MultiPeerConnectivity Variables:
    var peerID: MCPeerID!
    var session: MCSession!
    var nearbyServiceAdvertiser: MCNearbyServiceAdvertiser!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Intialize Multipeer Connectivity Variables:
        peerID = MCPeerID(displayName: UIDevice.current.name)
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        
        // Gives the delegate a func for move piece from the current instance (self) which we provide below
        boardView.chessDelegate = self
        
        chessEngine.initializeGame()
        boardView.shawdowPiece = chessEngine.pieces
        boardView.setNeedsDisplay()
    }
    
    // Advertise: Give Out Signal for MC
    @IBAction func advertise(_ sender: Any) {
        nearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: "Chess")
        nearbyServiceAdvertiser.delegate = self
        nearbyServiceAdvertiser.startAdvertisingPeer()
    }
    
    // Connect to Advertised Signal & Join
    @IBAction func join(_ sender: Any) {
        let browser = MCBrowserViewController(serviceType: "Chess", session: session)
        browser.delegate = self
        present(browser, animated: true)
    }
    
    @IBAction func reset(_ sender: Any) {
        chessEngine.initializeGame()
        boardView.shawdowPiece = chessEngine.pieces
        boardView.setNeedsDisplay()
        infoLabel.text = "White's Turn"
    }
}

extension ViewController: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, session)
        
    }
}

extension ViewController: MCBrowserViewControllerDelegate {
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
         dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    
}

extension ViewController: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            print("connected \(peerID.displayName)")
        case .connecting:
            print("connecting \(peerID.displayName)")
        case .notConnected:
            print("not connected \(peerID.displayName)")
        default:
            fatalError()
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print("recieved data: \(data)")
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
}


extension ViewController: ChessDelegate {
    // Whatever data we get from View, we pass -> Engine
    func movePiece(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
        chessEngine.movePiece(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        boardView.shawdowPiece = chessEngine.pieces
        boardView.setNeedsDisplay()
        
        if chessEngine.whitesTurn {
            infoLabel.text = "White's Turn"
        } else {
            infoLabel.text = "Blacks Turn"
        }
        
    }
    
    func pieceAt(col: Int, row: Int) -> ChessPiece? {
        return chessEngine.pieceAt(col: col, row: row)
    }
}

