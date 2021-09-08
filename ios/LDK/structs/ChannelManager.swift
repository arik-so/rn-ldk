public class ChannelManager: NativeTypeWrapper {

	private static var instanceCounter: UInt = 0
	internal let instanceNumber: UInt

    internal var cOpaqueStruct: LDKChannelManager?


	/* DEFAULT_CONSTRUCTOR_START */
    public init(fee_est: FeeEstimator, chain_monitor: Watch, tx_broadcaster: BroadcasterInterface, logger: Logger, keys_manager: KeysInterface, config: UserConfig, params: ChainParameters) {
    	Self.instanceCounter += 1
		self.instanceNumber = Self.instanceCounter
    	
        self.cOpaqueStruct = ChannelManager_new(fee_est.cOpaqueStruct!, chain_monitor.cOpaqueStruct!, tx_broadcaster.cOpaqueStruct!, logger.cOpaqueStruct!, keys_manager.cOpaqueStruct!, config.danglingClone().cOpaqueStruct!, params.danglingClone().cOpaqueStruct!)
        super.init(conflictAvoidingVariableName: 0)
    }
    /* DEFAULT_CONSTRUCTOR_END */

    public init(pointer: LDKChannelManager){
    	Self.instanceCounter += 1
		self.instanceNumber = Self.instanceCounter
		self.cOpaqueStruct = pointer
		super.init(conflictAvoidingVariableName: 0)
	}

	public init(pointer: LDKChannelManager, anchor: NativeTypeWrapper){
		Self.instanceCounter += 1
		self.instanceNumber = Self.instanceCounter
		self.cOpaqueStruct = pointer
		super.init(conflictAvoidingVariableName: 0)
		self.dangling = true
		try! self.addAnchor(anchor: anchor)
	}

    /* STRUCT_METHODS_START */

    public func get_current_default_configuration() -> UserConfig {
    	
        return UserConfig(pointer: withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
ChannelManager_get_current_default_configuration(this_argPointer)
});
    }

    public func create_channel(their_network_key: [UInt8], channel_value_satoshis: UInt64, push_msat: UInt64, user_id: UInt64, override_config: UserConfig) -> Result_NoneAPIErrorZ {
    	
        return Result_NoneAPIErrorZ(pointer: withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
ChannelManager_create_channel(this_argPointer, Bindings.new_LDKPublicKey(array: their_network_key), channel_value_satoshis, push_msat, user_id, override_config.danglingClone().cOpaqueStruct!)
});
    }

    public func list_channels() -> [ChannelDetails] {
    	
        return Bindings.LDKCVec_ChannelDetailsZ_to_array(nativeType: withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
ChannelManager_list_channels(this_argPointer)
})
						.map { (cOpaqueStruct) in
							ChannelDetails(pointer: cOpaqueStruct)
						}
					;
    }

    public func list_usable_channels() -> [ChannelDetails] {
    	
        return Bindings.LDKCVec_ChannelDetailsZ_to_array(nativeType: withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
ChannelManager_list_usable_channels(this_argPointer)
})
						.map { (cOpaqueStruct) in
							ChannelDetails(pointer: cOpaqueStruct)
						}
					;
    }

    public func close_channel(channel_id: [UInt8]) -> Result_NoneAPIErrorZ {
    	
        return Result_NoneAPIErrorZ(pointer: withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
withUnsafePointer(to: Bindings.array_to_tuple32(array: channel_id)) { (channel_idPointer: UnsafePointer<(UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8)>) in
ChannelManager_close_channel(this_argPointer, channel_idPointer)
}
});
    }

    public func close_channel_with_target_feerate(channel_id: [UInt8], target_feerate_sats_per_1000_weight: UInt32) -> Result_NoneAPIErrorZ {
    	
        return Result_NoneAPIErrorZ(pointer: withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
withUnsafePointer(to: Bindings.array_to_tuple32(array: channel_id)) { (channel_idPointer: UnsafePointer<(UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8)>) in
ChannelManager_close_channel_with_target_feerate(this_argPointer, channel_idPointer, target_feerate_sats_per_1000_weight)
}
});
    }

    public func force_close_channel(channel_id: [UInt8]) -> Result_NoneAPIErrorZ {
    	
        return Result_NoneAPIErrorZ(pointer: withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
withUnsafePointer(to: Bindings.array_to_tuple32(array: channel_id)) { (channel_idPointer: UnsafePointer<(UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8)>) in
ChannelManager_force_close_channel(this_argPointer, channel_idPointer)
}
});
    }

    public func force_close_all_channels() -> Void {
    	
        return withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
ChannelManager_force_close_all_channels(this_argPointer)
};
    }

    public func send_payment(route: Route, payment_hash: [UInt8], payment_secret: [UInt8]) -> Result_NonePaymentSendFailureZ {
    	
        return Result_NonePaymentSendFailureZ(pointer: withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
withUnsafePointer(to: route.cOpaqueStruct!) { (routePointer: UnsafePointer<LDKRoute>) in
ChannelManager_send_payment(this_argPointer, routePointer, Bindings.new_LDKThirtyTwoBytes(array: payment_hash), Bindings.new_LDKThirtyTwoBytes(array: payment_secret))
}
});
    }

    public func send_spontaneous_payment(route: Route, payment_preimage: [UInt8]) -> Result_PaymentHashPaymentSendFailureZ {
    	
        return Result_PaymentHashPaymentSendFailureZ(pointer: withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
withUnsafePointer(to: route.cOpaqueStruct!) { (routePointer: UnsafePointer<LDKRoute>) in
ChannelManager_send_spontaneous_payment(this_argPointer, routePointer, Bindings.new_LDKThirtyTwoBytes(array: payment_preimage))
}
});
    }

    public func funding_transaction_generated(temporary_channel_id: [UInt8], funding_transaction: [UInt8]) -> Result_NoneAPIErrorZ {
    	
						let funding_transactionWrapper = Bindings.new_LDKTransactionWrapper(array: funding_transaction)
						defer {
							funding_transactionWrapper.noOpRetain()
						}
					
        return Result_NoneAPIErrorZ(pointer: withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
withUnsafePointer(to: Bindings.array_to_tuple32(array: temporary_channel_id)) { (temporary_channel_idPointer: UnsafePointer<(UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8)>) in
ChannelManager_funding_transaction_generated(this_argPointer, temporary_channel_idPointer, funding_transactionWrapper.dangle().cOpaqueStruct!)
}
});
    }

    public func broadcast_node_announcement(rgb: [UInt8], alias: [UInt8], addresses: [NetAddress]) -> Void {
    	
							let addressesUnwrapped = addresses.map { (addressesCurrentValue) in
							addressesCurrentValue
								.danglingClone().cOpaqueStruct!
							}
						
        return self.broadcast_node_announcement(rgb: rgb, alias: alias, addresses: addressesUnwrapped);
    }

    internal func broadcast_node_announcement(rgb: [UInt8], alias: [UInt8], addresses: [LDKNetAddress]) -> Void {
    	
						let addressesWrapper = Bindings.new_LDKCVec_NetAddressZWrapper(array: addresses)
						defer {
							addressesWrapper.noOpRetain()
						}
					
        return withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
ChannelManager_broadcast_node_announcement(this_argPointer, Bindings.new_LDKThreeBytes(array: rgb), Bindings.new_LDKThirtyTwoBytes(array: alias), addressesWrapper.dangle().cOpaqueStruct!)
};
    }

    public func process_pending_htlc_forwards() -> Void {
    	
        return withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
ChannelManager_process_pending_htlc_forwards(this_argPointer)
};
    }

    public func timer_tick_occurred() -> Void {
    	
        return withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
ChannelManager_timer_tick_occurred(this_argPointer)
};
    }

    public func fail_htlc_backwards(payment_hash: [UInt8]) -> Bool {
    	
        return withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
withUnsafePointer(to: Bindings.array_to_tuple32(array: payment_hash)) { (payment_hashPointer: UnsafePointer<(UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8)>) in
ChannelManager_fail_htlc_backwards(this_argPointer, payment_hashPointer)
}
};
    }

    public func claim_funds(payment_preimage: [UInt8]) -> Bool {
    	
        return withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
ChannelManager_claim_funds(this_argPointer, Bindings.new_LDKThirtyTwoBytes(array: payment_preimage))
};
    }

    public func get_our_node_id() -> [UInt8] {
    	
        return Bindings.LDKPublicKey_to_array(nativeType: withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
ChannelManager_get_our_node_id(this_argPointer)
});
    }

    public func channel_monitor_updated(funding_txo: OutPoint, highest_applied_update_id: UInt64) -> Void {
    	
        return withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
withUnsafePointer(to: funding_txo.cOpaqueStruct!) { (funding_txoPointer: UnsafePointer<LDKOutPoint>) in
ChannelManager_channel_monitor_updated(this_argPointer, funding_txoPointer, highest_applied_update_id)
}
};
    }

    public func create_inbound_payment(min_value_msat: Option_u64Z, invoice_expiry_delta_secs: UInt32, user_payment_id: UInt64) -> C2Tuple_PaymentHashPaymentSecretZ {
    	
        return C2Tuple_PaymentHashPaymentSecretZ(pointer: withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
ChannelManager_create_inbound_payment(this_argPointer, min_value_msat.danglingClone().cOpaqueStruct!, invoice_expiry_delta_secs, user_payment_id)
});
    }

    public func create_inbound_payment_for_hash(payment_hash: [UInt8], min_value_msat: Option_u64Z, invoice_expiry_delta_secs: UInt32, user_payment_id: UInt64) -> Result_PaymentSecretAPIErrorZ {
    	
        return Result_PaymentSecretAPIErrorZ(pointer: withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
ChannelManager_create_inbound_payment_for_hash(this_argPointer, Bindings.new_LDKThirtyTwoBytes(array: payment_hash), min_value_msat.danglingClone().cOpaqueStruct!, invoice_expiry_delta_secs, user_payment_id)
});
    }

    public func as_MessageSendEventsProvider() -> NativelyImplementedMessageSendEventsProvider {
    	
        return NativelyImplementedMessageSendEventsProvider(pointer: withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
ChannelManager_as_MessageSendEventsProvider(this_argPointer)
}, anchor: self);
    }

    public func as_EventsProvider() -> NativelyImplementedEventsProvider {
    	
        return NativelyImplementedEventsProvider(pointer: withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
ChannelManager_as_EventsProvider(this_argPointer)
}, anchor: self);
    }

    public func as_Listen() -> NativelyImplementedListen {
    	
        return NativelyImplementedListen(pointer: withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
ChannelManager_as_Listen(this_argPointer)
}, anchor: self);
    }

    public func as_Confirm() -> NativelyImplementedConfirm {
    	
        return NativelyImplementedConfirm(pointer: withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
ChannelManager_as_Confirm(this_argPointer)
}, anchor: self);
    }

    public func await_persistable_update_timeout(max_wait: UInt64) -> Bool {
    	
        return withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
ChannelManager_await_persistable_update_timeout(this_argPointer, max_wait)
};
    }

    public func await_persistable_update() -> Void {
    	
        return withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
ChannelManager_await_persistable_update(this_argPointer)
};
    }

    public func current_best_block() -> BestBlock {
    	
        return BestBlock(pointer: withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
ChannelManager_current_best_block(this_argPointer)
});
    }

    public func as_ChannelMessageHandler() -> NativelyImplementedChannelMessageHandler {
    	
        return NativelyImplementedChannelMessageHandler(pointer: withUnsafePointer(to: self.cOpaqueStruct!) { (this_argPointer: UnsafePointer<LDKChannelManager>) in
ChannelManager_as_ChannelMessageHandler(this_argPointer)
}, anchor: self);
    }

    public func write() -> [UInt8] {
    	
        return Bindings.LDKCVec_u8Z_to_array(nativeType: withUnsafePointer(to: self.cOpaqueStruct!) { (objPointer: UnsafePointer<LDKChannelManager>) in
ChannelManager_write(objPointer)
});
    }

    internal func free() -> Void {
    	
        return ChannelManager_free(self.cOpaqueStruct!);
    }

					internal func dangle() -> ChannelManager {
        				self.dangling = true
						return self
					}
					
					deinit {
						if !self.dangling {
							Bindings.print("Freeing ChannelManager \(self.instanceNumber).")
							self.free()
						} else {
							Bindings.print("Not freeing ChannelManager \(self.instanceNumber) due to dangle.")
						}
					}
				

    /* STRUCT_METHODS_END */

}
