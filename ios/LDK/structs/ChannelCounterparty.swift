public class ChannelCounterparty: NativeTypeWrapper {

	private static var instanceCounter: UInt = 0
	internal let instanceNumber: UInt

    internal var cOpaqueStruct: LDKChannelCounterparty?


	/* DEFAULT_CONSTRUCTOR_START */
    public init(node_id_arg: [UInt8], features_arg: InitFeatures, unspendable_punishment_reserve_arg: UInt64, forwarding_info_arg: CounterpartyForwardingInfo) {
    	Self.instanceCounter += 1
		self.instanceNumber = Self.instanceCounter
    	
        self.cOpaqueStruct = ChannelCounterparty_new(Bindings.new_LDKPublicKey(array: node_id_arg), features_arg.danglingClone().cOpaqueStruct!, unspendable_punishment_reserve_arg, forwarding_info_arg.danglingClone().cOpaqueStruct!)
        super.init(conflictAvoidingVariableName: 0)
    }
    /* DEFAULT_CONSTRUCTOR_END */

    public init(pointer: LDKChannelCounterparty){
    	Self.instanceCounter += 1
		self.instanceNumber = Self.instanceCounter
		self.cOpaqueStruct = pointer
		super.init(conflictAvoidingVariableName: 0)
	}

	public init(pointer: LDKChannelCounterparty, anchor: NativeTypeWrapper){
		Self.instanceCounter += 1
		self.instanceNumber = Self.instanceCounter
		self.cOpaqueStruct = pointer
		super.init(conflictAvoidingVariableName: 0)
		self.dangling = true
		try! self.addAnchor(anchor: anchor)
	}

    /* STRUCT_METHODS_START */

    public func get_node_id() -> [UInt8] {
    	
        return Bindings.LDKPublicKey_to_array(nativeType: withUnsafePointer(to: self.cOpaqueStruct!) { (this_ptrPointer: UnsafePointer<LDKChannelCounterparty>) in
ChannelCounterparty_get_node_id(this_ptrPointer)
});
    }

    public func set_node_id(val: [UInt8]) -> Void {
    	
							let this_ptrPointer = UnsafeMutablePointer<LDKChannelCounterparty>.allocate(capacity: 1)
							this_ptrPointer.initialize(to: self.cOpaqueStruct!)
						
        return ChannelCounterparty_set_node_id(this_ptrPointer, Bindings.new_LDKPublicKey(array: val));
    }

    public func get_features() -> InitFeatures {
    	
        return InitFeatures(pointer: withUnsafePointer(to: self.cOpaqueStruct!) { (this_ptrPointer: UnsafePointer<LDKChannelCounterparty>) in
ChannelCounterparty_get_features(this_ptrPointer)
});
    }

    public func set_features(val: InitFeatures) -> Void {
    	
							let this_ptrPointer = UnsafeMutablePointer<LDKChannelCounterparty>.allocate(capacity: 1)
							this_ptrPointer.initialize(to: self.cOpaqueStruct!)
						
        return ChannelCounterparty_set_features(this_ptrPointer, val.danglingClone().cOpaqueStruct!);
    }

    public func get_unspendable_punishment_reserve() -> UInt64 {
    	
        return withUnsafePointer(to: self.cOpaqueStruct!) { (this_ptrPointer: UnsafePointer<LDKChannelCounterparty>) in
ChannelCounterparty_get_unspendable_punishment_reserve(this_ptrPointer)
};
    }

    public func set_unspendable_punishment_reserve(val: UInt64) -> Void {
    	
							let this_ptrPointer = UnsafeMutablePointer<LDKChannelCounterparty>.allocate(capacity: 1)
							this_ptrPointer.initialize(to: self.cOpaqueStruct!)
						
        return ChannelCounterparty_set_unspendable_punishment_reserve(this_ptrPointer, val);
    }

    public func get_forwarding_info() -> CounterpartyForwardingInfo {
    	
        return CounterpartyForwardingInfo(pointer: withUnsafePointer(to: self.cOpaqueStruct!) { (this_ptrPointer: UnsafePointer<LDKChannelCounterparty>) in
ChannelCounterparty_get_forwarding_info(this_ptrPointer)
});
    }

    public func set_forwarding_info(val: CounterpartyForwardingInfo) -> Void {
    	
							let this_ptrPointer = UnsafeMutablePointer<LDKChannelCounterparty>.allocate(capacity: 1)
							this_ptrPointer.initialize(to: self.cOpaqueStruct!)
						
        return ChannelCounterparty_set_forwarding_info(this_ptrPointer, val.danglingClone().cOpaqueStruct!);
    }

    public func clone() -> ChannelCounterparty {
    	
        return ChannelCounterparty(pointer: withUnsafePointer(to: self.cOpaqueStruct!) { (origPointer: UnsafePointer<LDKChannelCounterparty>) in
ChannelCounterparty_clone(origPointer)
});
    }

					internal func danglingClone() -> ChannelCounterparty {
        				let dangledClone = self.clone()
						dangledClone.dangling = true
						return dangledClone
					}
				

    internal func free() -> Void {
    	
        return ChannelCounterparty_free(self.cOpaqueStruct!);
    }

					internal func dangle() -> ChannelCounterparty {
        				self.dangling = true
						return self
					}
					
					deinit {
						if !self.dangling {
							Bindings.print("Freeing ChannelCounterparty \(self.instanceNumber).")
							self.free()
						} else {
							Bindings.print("Not freeing ChannelCounterparty \(self.instanceNumber) due to dangle.")
						}
					}
				

    /* STRUCT_METHODS_END */

}
