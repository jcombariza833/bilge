//
//  PollConnectionManager.swift
//  Bilge
//
//  Created by JUAN PABLO COMBARIZA MEJIA on 12/6/21.
//

import Foundation
import MultipeerConnectivity
import Combine

class PollConnectionManager: NSObject, ObservableObject {
    
    // New code
    @Published var peers: [MCPeerID] = []
    @Published var studentsAvailable: [MCPeerID] = []
    @Published var pollToSendN: PollModel?
    @Published var receivedPoll: Poll = Poll(name: "",
                                             components: [Statement](),
                                             courseCode: "", sectionCode: "")
    @Published var receivedPollNotifier: Poll?
    @Published var connected = false
    
    private var myPeerId: MCPeerID = MCPeerID(displayName: UIDevice.current.name)  // TODO: username
    private var service: String = "" //TODO: roomid
    private var session: MCSession?
    private var nearbyServiceAdvertiser: MCNearbyServiceAdvertiser? // to be discovered
    private var nearbyServiceBrowser: MCNearbyServiceBrowser? // to connect
    private var isHosting = false
    

    
    func configuration(service: String, username: String) {
        self.service = service
        self.myPeerId = MCPeerID(displayName: username)
    }
    
    
    func host() {
        isHosting = true
        peers.removeAll()
        pollToSendN = nil
        connected = true
        session = MCSession(peer: myPeerId, securityIdentity: nil, encryptionPreference: .none)
        session?.delegate = self
        nearbyServiceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: service)
        nearbyServiceBrowser?.delegate = self
        nearbyServiceBrowser?.startBrowsingForPeers()
    }
    
    //Client
    func join() {
        peers.removeAll()
        receivedPollNotifier = nil
        session = MCSession(peer: myPeerId, securityIdentity: nil, encryptionPreference: .none)
        session?.delegate = self
        nearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId,
                                                            discoveryInfo: nil,
                                                            serviceType: service)
        nearbyServiceAdvertiser?.delegate = self
        nearbyServiceAdvertiser?.startAdvertisingPeer()
    }
    
    func leave() {
        isHosting = false
        connected = false
        nearbyServiceAdvertiser?.stopAdvertisingPeer()
        nearbyServiceBrowser?.stopBrowsingForPeers()
        pollToSendN = nil
        session = nil
        nearbyServiceAdvertiser = nil
        nearbyServiceBrowser = nil
    }
    
    func sendPoll(_ poll: PollModel) {
      guard
        let session = session,
        let data = try? JSONEncoder().encode(poll),
        !session.connectedPeers.isEmpty
      else { return }

      do {
        try session.send(data, toPeers: session.connectedPeers, with: .reliable)
      } catch {
        print(error.localizedDescription)
      }
    }
    
    func invitePeer(_ peerID: MCPeerID) {
        guard let session = session else { return }
        nearbyServiceBrowser?.invitePeer(peerID, to: session, withContext: nil, timeout: TimeInterval(120))
    }
    
    func sendFeedback(to peer: MCPeerID) {
      
    }

}

//MARK: - to be discovered
extension PollConnectionManager: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        // Automatic connection
        invitationHandler(true, self.session)
    }
}

//MARK: - Brose
extension PollConnectionManager: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
        if isHosting {
            if !studentsAvailable.contains(peerID) {
                studentsAvailable.append(peerID)
                invitePeer(peerID)
            }
        }
        
    }

    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
      guard let index = studentsAvailable.firstIndex(of: peerID) else { return }
        studentsAvailable.remove(at: index)
    }
}

//MARK: - manage session
extension PollConnectionManager: MCSessionDelegate {
  func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
    switch state {
    case .connected:
        DispatchQueue.main.async {
            if !self.peers.contains(peerID) {
                self.peers.insert(peerID, at: 0)
            }
        }
    case .notConnected:
        DispatchQueue.main.async {
            if let index = self.peers.firstIndex(of: peerID) {
              self.peers.remove(at: index)
            }
            if self.peers.isEmpty && !self.isHosting {
              self.connected = false
            }
        }
        
    case .connecting:
      print("Connecting to: \(peerID.displayName)")
    @unknown default:
      print("Unknown state: \(state)")
    }
  }

  func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
      guard let poll = try? JSONDecoder().decode(PollModel.self, from: data) else { return }
      DispatchQueue.main.async {
          let pollNew = PollManger.invert(poll)
          self.receivedPollNotifier = pollNew
          self.receivedPoll = pollNew
      }
  }

  func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
      print("didReceive stream")
  }

  func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
      print("didStartReceivingResourceWithName")
  }

  func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
      print("didFinishReceivingResourceWithName")
  }
}


