//
//  MultiPeerController.swift
//  Chess
//
//  Created by Dhruv Shah on 2022-02-02.
//

import Foundation
import MultipeerConnectivity


extension ViewController: MCNearbyServiceAdvertiserDelegate {
    // Incoming invitation request:
    // Called when an invitation to join a session is received from a nearby peer.
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
    
    // Remote peer changed state
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
    
    // Received data from remote peer
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        // print("recieved data: \(data)")
        if let move = String(data: data, encoding: .utf8) {
            
            if move == "Reset" {
                chessEngine.initializeGame()
                boardView.shawdowPiece = chessEngine.pieces
                DispatchQueue.main.async { [self] in
                    boardView.setNeedsDisplay()
                    infoLabel.text = "White's Turn"
                }
                
                return
            }
            
            let moveArray = move.components(separatedBy: ":")
        
            
            if let fromCol = Int(moveArray[0]), let fromRow = Int(moveArray[1]), let toCol = Int(moveArray[2]), let toRow = Int(moveArray[3]) {
                DispatchQueue.main.async {
                    self.updateMove(fromCol: fromCol, fromRow: fromRow, toCol: toCol, toRow: toRow)
                }
                
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
}
