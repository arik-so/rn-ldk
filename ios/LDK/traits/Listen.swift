import Foundation

open class Listen: NativeTypeWrapper {

	private static var instanceCounter: UInt = 0
	internal let instanceNumber: UInt

    internal var cOpaqueStruct: LDKListen?

    public init() {
		Self.instanceCounter += 1
		self.instanceNumber = Self.instanceCounter

    	/* NATIVE_CALLBACKS_START */

		func block_connectedCallback(pointer: UnsafeRawPointer?, block: LDKu8slice, height: UInt32) -> Void {
			let instance: Listen = Bindings.pointerToInstance(pointer: pointer!, sourceMarker: "Listen.swift::block_connected")
			
			return instance.block_connected(block: Bindings.LDKu8slice_to_array(nativeType: block), height: height)
		}

		func block_disconnectedCallback(pointer: UnsafeRawPointer?, headerPointer: UnsafePointer<(UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8)>?, height: UInt32) -> Void {
			let instance: Listen = Bindings.pointerToInstance(pointer: pointer!, sourceMarker: "Listen.swift::block_disconnected")
			
								var header: [UInt8]? = nil
								if let headerUnwrapped = headerPointer {
									header = Bindings.tuple80_to_array(nativeType: headerUnwrapped.pointee)
								}
							
			return instance.block_disconnected(header: header, height: height)
		}

		func freeCallback(pointer: UnsafeMutableRawPointer?) -> Void {
			let instance: Listen = Bindings.pointerToInstance(pointer: pointer!, sourceMarker: "Listen.swift::free")
			
			return instance.free()
		}

		/* NATIVE_CALLBACKS_END */

		super.init(conflictAvoidingVariableName: 0)
        self.cOpaqueStruct = LDKListen(this_arg: Bindings.instanceToPointer(instance: self), 
			block_connected: block_connectedCallback,
			block_disconnected: block_disconnectedCallback,
			free: freeCallback)

    }

    public init(pointer: LDKListen){
    	Self.instanceCounter += 1
		self.instanceNumber = Self.instanceCounter
		self.cOpaqueStruct = pointer
		super.init(conflictAvoidingVariableName: 0)
	}

	public init(pointer: LDKListen, anchor: NativeTypeWrapper){
		Self.instanceCounter += 1
		self.instanceNumber = Self.instanceCounter
		self.cOpaqueStruct = pointer
		super.init(conflictAvoidingVariableName: 0)
		self.dangling = true
		try! self.addAnchor(anchor: anchor)
	}

    /* SWIFT_CALLBACKS_START */



					internal func dangle() -> Listen {
        				self.dangling = true
						return self
					}
					
					deinit {
						if !self.dangling {
							Bindings.print("Freeing Listen \(self.instanceNumber).")
							self.free()
						} else {
							Bindings.print("Not freeing Listen \(self.instanceNumber) due to dangle.")
						}
					}
				

    open func block_connected(block: [UInt8], height: UInt32) -> Void {
    	/* EDIT ME */
		Bindings.print("Listen::block_connected should be overridden!", severity: .WARNING)


    }

    open func block_disconnected(header: [UInt8]?, height: UInt32) -> Void {
    	/* EDIT ME */
		Bindings.print("Listen::block_disconnected should be overridden!", severity: .WARNING)


    }

    open func free() -> Void {
    	/* EDIT ME */
		Bindings.print("Listen::free should be overridden!", severity: .WARNING)


    }

    /* SWIFT_CALLBACKS_END */

}


public class NativelyImplementedListen: Listen {
	/* SWIFT_DEFAULT_CALLBACKS_START */

	public override func block_connected(block: [UInt8], height: UInt32) -> Void {
		
				
						let blockWrapper = Bindings.new_LDKu8sliceWrapper(array: block)
						defer {
							blockWrapper.noOpRetain()
						}
					
				
				self.cOpaqueStruct!.block_connected(self.cOpaqueStruct!.this_arg, blockWrapper.cOpaqueStruct!, height)
				
			
	}

	public override func block_disconnected(header: [UInt8]?, height: UInt32) -> Void {
		
				
				withUnsafePointer(to: Bindings.array_to_tuple80(array: header!)) { (headerPointer: UnsafePointer<(UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8)>) in

				self.cOpaqueStruct!.block_disconnected(self.cOpaqueStruct!.this_arg, headerPointer, height)
				
}
			
	}

	public override func free() -> Void {
		
				
				
				self.cOpaqueStruct!.free(self.cOpaqueStruct!.this_arg)
				
			
	}

	/* SWIFT_DEFAULT_CALLBACKS_END */
}
