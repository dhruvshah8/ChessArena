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
        
        // View Elements:
        createButton.layer.cornerRadius = 10
        joinButton.layer.cornerRadius = 10
        createButton.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        joinButton.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        
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
        
        // Make player Black
        boardView.blackOnTop = false
        boardView.setNeedsDisplay() // Redraw
    }
    
    // Connect to Advertised Signal & Join
    @IBAction func join(_ sender: Any) {
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
        // Make Player White
        boardView.blackOnTop = true
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
        if let move = String(data: data, encoding: .utf8) {
            let moveArray = move.components(separatedBy: ":")
        
            
            if let fromCol = Int(moveArray[0]), let fromRow = Int(moveArray[1]), let toCol = Int(moveArray[2]), let toRow = Int(moveArray[3]) {
                DispatchQueue.main.async {
                    self.updateMove(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
                }
                
            }
            
//            print(" HERE: ")
//            print(moveArray)

        }
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
        
        updateMove(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
        let move: String = "\(fromCol):\(fromRow):\(toCol):\(toRow)"
        // Encode String as UTF8 Data and send data to peers
        if let data = move.data(using: .utf8) {
            try? session.send(data, toPeers: session.connectedPeers, with: .reliable)
        }
    }
    
    func updateMove(fromCol: Int, fromRow: Int, toCol: Int, toRow: Int) {
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
