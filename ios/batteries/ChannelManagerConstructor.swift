//
//  ChannelManagerConstructor.swift
//  LDKSwiftARC
//
//  Created by Arik Sosman on 5/19/21.
//

import Foundation

enum InvalidSerializedDataError: Error {
    case invalidSerializedChannelMonitor
    case invalidSerializedChannelManager
}

public class ChannelManagerConstructor: NativeTypeWrapper {


    public let channelManager: ChannelManager

    /**
     * The latest block has the channel manager saw. If this is non-null it is a 32-byte block hash.
     * You should sync the blockchain starting with the block that builds on this block.
     */


    public let channel_manager_latest_block_hash: [UInt8]?

    let logger: Logger
    fileprivate var customPersister: CustomChannelManagerPersister?
    fileprivate var customEventHandler: CustomEventHandler?
    public let peerManager: PeerManager


    /**
     * A list of ChannelMonitors and the last block they each saw. You should sync the blockchain on each individually
     * starting with the block that builds on the hash given.
     * After doing so (and syncing the blockchain on the channel manager as well), you should call chain_sync_completed()
     * and then continue to normal application operation.
     */
    public private(set) var channel_monitors: [(ChannelMonitor, [UInt8])]

    private let chain_monitor: ChainMonitor


    public init(channel_manager_serialized: [UInt8], channel_monitors_serialized: [[UInt8]], keys_interface: KeysInterface, fee_estimator: FeeEstimator, chain_monitor: ChainMonitor, filter: Filter?, router: NetGraphMsgHandler?, tx_broadcaster: BroadcasterInterface, logger: Logger) throws {

        var monitors: [LDKChannelMonitor] = []
        self.channel_monitors = []

        for currentSerializedChannelMonitor in channel_monitors_serialized {
            let channelMonitorResult: Result_C2Tuple_BlockHashChannelMonitorZDecodeErrorZ = UtilMethods.constructor_BlockHashChannelMonitorZ_read(ser: currentSerializedChannelMonitor, arg: keys_interface)
            if channelMonitorResult.cOpaqueStruct?.result_ok != true {
                throw InvalidSerializedDataError.invalidSerializedChannelMonitor
            }
            // res

            let value: LDKCResult_C2Tuple_BlockHashChannelMonitorZDecodeErrorZPtr = channelMonitorResult.cOpaqueStruct!.contents
            let a: LDKThirtyTwoBytes = value.result!.pointee.a
            var b: LDKChannelMonitor = value.result!.pointee.b

            var clonedChannelMonitor = ChannelMonitor(pointer: b).dangle().clone()
            // var clonedChannelMonitor = currentChannelMonitor.clone(orig: currentChannelMonitor)
            clonedChannelMonitor.cOpaqueStruct?.is_owned = false // is_owned should never have to be modified

            monitors.append(clonedChannelMonitor.cOpaqueStruct!)
            self.channel_monitors.append((clonedChannelMonitor, Bindings.LDKThirtyTwoBytes_to_array(nativeType: a)))
        }

        print("Collected channel monitors, reading channel manager")
        let channelManagerResult: Result_C2Tuple_BlockHashChannelManagerZDecodeErrorZ = UtilMethods.constructor_BlockHashChannelManagerZ_read(ser: channel_manager_serialized, arg_keys_manager: keys_interface, arg_fee_estimator: fee_estimator, arg_chain_monitor: chain_monitor.as_Watch(), arg_tx_broadcaster: tx_broadcaster, arg_logger: logger, arg_default_config: UserConfig(), arg_channel_monitors: monitors)
        if channelManagerResult.isOk() != true {
            throw InvalidSerializedDataError.invalidSerializedChannelManager
        }

        for clonedChannelMonitor in self.channel_monitors {
            clonedChannelMonitor.0.cOpaqueStruct!.is_owned = true
        }

        let latestBlockHash = Bindings.LDKThirtyTwoBytes_to_array(nativeType: channelManagerResult.cOpaqueStruct!.contents.result.pointee.a)
        let channelManager = ChannelManager(pointer: channelManagerResult.cOpaqueStruct!.contents.result.pointee.b)
        try! channelManager.dangle().addAnchor(anchor: channelManagerResult)


        self.channelManager = channelManager
        self.channel_manager_latest_block_hash = latestBlockHash
        self.chain_monitor = chain_monitor
        self.logger = logger

        let random_data = keys_interface.get_secure_random_bytes();
        if let router = router {
            let messageHandler = MessageHandler(chan_handler_arg: channelManager.as_ChannelMessageHandler(), route_handler_arg: router.as_RoutingMessageHandler())
            self.peerManager = PeerManager(message_handler: messageHandler.dangle(), our_node_secret: keys_interface.get_node_secret(), ephemeral_random_data: random_data, logger: self.logger, custom_message_handler: IgnoringMessageHandler().as_CustomMessageHandler())
        } else {
            let messageHandler = MessageHandler(chan_handler_arg: channelManager.as_ChannelMessageHandler(), route_handler_arg: IgnoringMessageHandler().as_RoutingMessageHandler())
            self.peerManager = PeerManager(message_handler: messageHandler.dangle(), our_node_secret: keys_interface.get_node_secret(), ephemeral_random_data: random_data, logger: self.logger, custom_message_handler: IgnoringMessageHandler().as_CustomMessageHandler())
        }

        if let filter = filter {
            for (currentMonitor, _) in self.channel_monitors {
                currentMonitor.load_outputs_to_watch(filter: filter)
            }
        }

        super.init(conflictAvoidingVariableName: 0)
        // try! self.peerManager.addAnchor(anchor: self)
        // try! self.channelManager.addAnchor(anchor: self)

    }



    /**
     * Constructs a channel manager from the given interface implementations
     */
    public init(network: LDKNetwork, config: UserConfig, current_blockchain_tip_hash: [UInt8], current_blockchain_tip_height: UInt32, keys_interface: KeysInterface, fee_estimator: FeeEstimator, chain_monitor: ChainMonitor, router: NetGraphMsgHandler?, tx_broadcaster: BroadcasterInterface, logger: Logger) {
        self.channel_monitors = []
        self.channel_manager_latest_block_hash = nil
        self.chain_monitor = chain_monitor
        let block = BestBlock(block_hash: current_blockchain_tip_hash, height: current_blockchain_tip_height)
        let chainParameters = ChainParameters(network_arg: network, best_block_arg: block)
        self.channelManager = ChannelManager(fee_est: fee_estimator, chain_monitor: chain_monitor.as_Watch(), tx_broadcaster: tx_broadcaster, logger: logger, keys_manager: keys_interface, config: config, params: chainParameters)
        self.logger = logger

        let random_data = keys_interface.get_secure_random_bytes();
        if let router = router {
            let messageHandler = MessageHandler(chan_handler_arg: channelManager.as_ChannelMessageHandler(), route_handler_arg: router.as_RoutingMessageHandler())
            self.peerManager = PeerManager(message_handler: messageHandler.dangle(), our_node_secret: keys_interface.get_node_secret(), ephemeral_random_data: random_data, logger: self.logger, custom_message_handler: IgnoringMessageHandler().as_CustomMessageHandler())
        } else {
            let messageHandler = MessageHandler(chan_handler_arg: channelManager.as_ChannelMessageHandler(), route_handler_arg: IgnoringMessageHandler().as_RoutingMessageHandler())
            self.peerManager = PeerManager(message_handler: messageHandler.dangle(), our_node_secret: keys_interface.get_node_secret(), ephemeral_random_data: random_data, logger: self.logger, custom_message_handler: IgnoringMessageHandler().as_CustomMessageHandler())
        }

        super.init(conflictAvoidingVariableName: 0)
        // try! self.peerManager.addAnchor(anchor: self)
        // try! self.channelManager.addAnchor(anchor: self)
    }


    var persisterWorkItem: DispatchWorkItem?
    var backgroundProcessor: BackgroundProcessor?
    var shutdown = false

    /**
     * Utility which adds all of the deserialized ChannelMonitors to the chain watch so that further updates from the
     * ChannelManager are processed as normal.
     *
     * This also spawns a background thread which will call the appropriate methods on the provided
     * ChannelManagerPersister as required.
     */
    public func chain_sync_completed(persister: ExtendedChannelManagerPersister) {

        if self.backgroundProcessor != nil {
            return
        }

        for (currentChannelMonitor, _) in self.channel_monitors {
            let chainMonitorWatch = self.chain_monitor.as_Watch()
            let monitorClone = currentChannelMonitor.clone()
            monitorClone.cOpaqueStruct?.is_owned = false
            let fundingTxo = monitorClone.get_funding_txo()
            let outPoint = OutPoint(pointer: fundingTxo.cOpaqueStruct!.a).dangle()
            print("watching channel")
            let monitorWatchResult = chainMonitorWatch.watch_channel(funding_txo: outPoint, monitor: monitorClone)
            if !monitorWatchResult.isOk() {
                print("Some error occurred with a chainMonitorWatch.watch_channel call")
            }
            monitorClone.cOpaqueStruct?.is_owned = true
        }

        self.customPersister = CustomChannelManagerPersister(handler: persister)
        self.customEventHandler = CustomEventHandler(handler: persister)
        let netGraphMessageHandler = NetGraphMsgHandler(pointer: LDKNetGraphMsgHandler(inner: nil, is_owned: false))
        self.backgroundProcessor = BackgroundProcessor(persister: self.customPersister!, event_handler: self.customEventHandler!, chain_monitor: self.chain_monitor, channel_manager: self.channelManager, net_graph_msg_handler: netGraphMessageHandler, peer_manager: self.peerManager, logger: self.logger)
        try! self.backgroundProcessor!.addAnchor(anchor: self.peerManager)
        try! self.backgroundProcessor!.addAnchor(anchor: persister)
        try! self.backgroundProcessor!.addAnchor(anchor: self.customEventHandler!)
        try! self.backgroundProcessor!.addAnchor(anchor: self.customPersister!)

    }

    public func interrupt(tcpPeerHandler: TCPPeerHandler? = nil) {
        self.shutdown = true
        if let tcpHandler = tcpPeerHandler {
            print("stopping TCP peer handler")
            tcpHandler.interrupt()
            print("stopped TCP peer handler")
        }
        print("stopping background processor")
        self.backgroundProcessor?.dangle().stop()
        print("stopped background processor")
        if let processor = self.backgroundProcessor {
            for currentAnchor in processor.anchors {
                Bindings.removeInstancePointer(instance: currentAnchor)
            }
            print("removed background processor anchors")
        }
        self.backgroundProcessor = nil
        print("unset background processor")
    }

    deinit {
        print("deiniting ChannelManagerConstructor")
    }


}

fileprivate class CustomChannelManagerPersister: ChannelManagerPersister {

    let handler: ExtendedChannelManagerPersister

    init(handler: ExtendedChannelManagerPersister) {
        self.handler = handler
        super.init()
    }

    override func persist_manager(channel_manager: ChannelManager) -> Result_NoneErrorZ {
        return self.handler.persist_manager(channel_manager: channel_manager)
    }
}

fileprivate class CustomEventHandler: EventHandler {

    let handler: ExtendedChannelManagerPersister

    init(handler: ExtendedChannelManagerPersister) {
        self.handler = handler
        super.init()
    }

    override func handle_event(event: Event) {
        self.handler.handle_event(event: event)
    }


}

public protocol ExtendedChannelManagerPersister: ChannelManagerPersister {
    func handle_event(event: Event) -> Void;
}
