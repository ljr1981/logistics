class
	LG_BOL

feature -- Consignee

	consignee: detachable BU_BUSINESS

	consignee_address: detachable BU_ADDRESS

feature -- Shipper

	shipper: detachable BU_BUSINESS

	shipper_address: detachable BU_ADDRESS

	shippers_number: detachable STRING

feature -- BOL Data

	date: DATE
		attribute
			create Result.make_now
		end

	hazmat_emergency_phone: detachable BU_PHONE

	contract_number: detachable STRING

	offerers_name: detachable STRING

	contract_holders_name: detachable STRING

	bill_to_address: detachable BU_ADDRESS

	special_instructions: STRING
		attribute
			create Result.make_empty
		end

feature -- Financial

	cod: detachable LG_COD

	purchase_order_number: detachable STRING

	quote_number: detachable STRING

feature -- Additional Services

	is_lift_gate: BOOLEAN

	is_inside_pickup: BOOLEAN

	is_inside_delivery: BOOLEAN

	is_freeze_protection: BOOLEAN

	is_residential: BOOLEAN

	is_delivery_notification: BOOLEAN

	is_proof_of_delivery: BOOLEAN

feature -- Guaranteed Service Options

	is_guaranteed_5pm: BOOLEAN

	is_guaranteed_window: BOOLEAN

	window_start: detachable TIME

	window_end: detachable TIME

	is_guaranteed_morning: BOOLEAN

feature -- Charge Handling

	is_shipper_responsible: BOOLEAN
		do
			Result := not is_consignee_responsible
		end

	is_consignee_responsible: BOOLEAN

feature -- Items

	items: ARRAYED_LIST [LG_BOL_ITEM]
			-- `items' of {LG_BOL}.
		attribute
			create Result.make (100)
		end

feature -- Settings

	set_consignee (a_consignee: attached like consignee)
			-- Sets `consignee' with `a_consignee'.
		do
			consignee := a_consignee
		ensure
			consignee_set: consignee = a_consignee
		end

	set_consignee_address (a_consignee_address: attached like consignee_address)
			-- Sets `consignee_address' with `a_consignee_address'.
		do
			consignee_address := a_consignee_address
		ensure
			consignee_address_set: consignee_address = a_consignee_address
		end

	set_shipper (a_shipper: attached like shipper)
			-- Sets `shipper' with `a_shipper'.
		do
			shipper := a_shipper
		ensure
			shipper_set: shipper = a_shipper
		end

	set_shipper_address (a_shipper_address: attached like shipper_address)
			-- Sets `shipper_address' with `a_shipper_address'.
		do
			shipper_address := a_shipper_address
		ensure
			shipper_address_set: shipper_address = a_shipper_address
		end

	set_shippers_number (a_shippers_number: attached like shippers_number)
			-- Sets `shippers_number' with `a_shippers_number'.
		do
			shippers_number := a_shippers_number
		ensure
			shippers_number_set: shippers_number = a_shippers_number
		end

	set_date (a_date: attached like date)
			-- Sets `date' with `a_date'.
		do
			date := a_date
		ensure
			date_set: date = a_date
		end

	set_hazmat_emergency_phone (a_hazmat_emergency_phone: attached like hazmat_emergency_phone)
			-- Sets `hazmat_emergency_phone' with `a_hazmat_emergency_phone'.
		do
			hazmat_emergency_phone := a_hazmat_emergency_phone
		ensure
			hazmat_emergency_phone_set: hazmat_emergency_phone = a_hazmat_emergency_phone
		end

	set_contract_number (a_contract_number: attached like contract_number)
			-- Sets `contract_number' with `a_contract_number'.
		do
			contract_number := a_contract_number
		ensure
			contract_number_set: contract_number = a_contract_number
		end

	set_offerers_name (a_offerers_name: attached like offerers_name)
			-- Sets `offerers_name' with `a_offerers_name'.
		do
			offerers_name := a_offerers_name
		ensure
			offerers_name_set: offerers_name = a_offerers_name
		end

	set_contract_holders_name (a_contract_holders_name: attached like contract_holders_name)
			-- Sets `contract_holders_name' with `a_contract_holders_name'.
		do
			contract_holders_name := a_contract_holders_name
		ensure
			contract_holders_name_set: contract_holders_name = a_contract_holders_name
		end

	set_bill_to_address (a_bill_to_address: attached like bill_to_address)
			-- Sets `bill_to_address' with `a_bill_to_address'.
		do
			bill_to_address := a_bill_to_address
		ensure
			bill_to_address_set: bill_to_address = a_bill_to_address
		end

	set_special_instructions (a_special_instructions: attached like special_instructions)
			-- Sets `special_instructions' with `a_special_instructions'.
		do
			special_instructions := a_special_instructions
		ensure
			special_instructions_set: special_instructions = a_special_instructions
		end

	set_cod (a_cod: attached like cod)
			-- Sets `cod' with `a_cod'.
		do
			cod := a_cod
		ensure
			cod_set: cod = a_cod
		end

	set_purchase_order_number (a_purchase_order_number: attached like purchase_order_number)
			-- Sets `purchase_order_number' with `a_purchase_order_number'.
		do
			purchase_order_number := a_purchase_order_number
		ensure
			purchase_order_number_set: purchase_order_number = a_purchase_order_number
		end

	set_quote_number (a_quote_number: attached like quote_number)
			-- Sets `quote_number' with `a_quote_number'.
		do
			quote_number := a_quote_number
		ensure
			quote_number_set: quote_number = a_quote_number
		end

	set_is_lift_gate (a_is_lift_gate: attached like is_lift_gate)
			-- Sets `is_lift_gate' with `a_is_lift_gate'.
		do
			is_lift_gate := a_is_lift_gate
		ensure
			is_lift_gate_set: is_lift_gate = a_is_lift_gate
		end

	set_is_inside_pickup (a_is_inside_pickup: attached like is_inside_pickup)
			-- Sets `is_inside_pickup' with `a_is_inside_pickup'.
		do
			is_inside_pickup := a_is_inside_pickup
		ensure
			is_inside_pickup_set: is_inside_pickup = a_is_inside_pickup
		end

	set_is_inside_delivery (a_is_inside_delivery: attached like is_inside_delivery)
			-- Sets `is_inside_delivery' with `a_is_inside_delivery'.
		do
			is_inside_delivery := a_is_inside_delivery
		ensure
			is_inside_delivery_set: is_inside_delivery = a_is_inside_delivery
		end

	set_is_freeze_protection (a_is_freeze_protection: attached like is_freeze_protection)
			-- Sets `is_freeze_protection' with `a_is_freeze_protection'.
		do
			is_freeze_protection := a_is_freeze_protection
		ensure
			is_freeze_protection_set: is_freeze_protection = a_is_freeze_protection
		end

	set_is_residential (a_is_residential: attached like is_residential)
			-- Sets `is_residential' with `a_is_residential'.
		do
			is_residential := a_is_residential
		ensure
			is_residential_set: is_residential = a_is_residential
		end

	set_is_delivery_notification (a_is_delivery_notification: attached like is_delivery_notification)
			-- Sets `is_delivery_notification' with `a_is_delivery_notification'.
		do
			is_delivery_notification := a_is_delivery_notification
		ensure
			is_delivery_notification_set: is_delivery_notification = a_is_delivery_notification
		end

	set_is_guaranteed_5pm (a_is_guaranteed_5pm: attached like is_guaranteed_5pm)
			-- Sets `is_guaranteed_5pm' with `a_is_guaranteed_5pm'.
		do
			is_guaranteed_5pm := a_is_guaranteed_5pm
		ensure
			is_guaranteed_5pm_set: is_guaranteed_5pm = a_is_guaranteed_5pm
		end

	set_is_guaranteed_window (a_is_guaranteed_window: attached like is_guaranteed_window)
			-- Sets `is_guaranteed_window' with `a_is_guaranteed_window'.
		do
			is_guaranteed_window := a_is_guaranteed_window
		ensure
			is_guaranteed_window_set: is_guaranteed_window = a_is_guaranteed_window
		end

	set_is_proof_of_delivery (a_is_proof_of_delivery: attached like is_proof_of_delivery)
			-- Sets `is_proof_of_delivery' with `a_is_proof_of_delivery'.
		do
			is_proof_of_delivery := a_is_proof_of_delivery
		ensure
			is_proof_of_delivery_set: is_proof_of_delivery = a_is_proof_of_delivery
		end

	set_window_start (a_window_start: attached like window_start)
			-- Sets `window_start' with `a_window_start'.
		do
			window_start := a_window_start
		ensure
			window_start_set: window_start = a_window_start
		end

	set_window_end (a_window_end: attached like window_end)
			-- Sets `window_end' with `a_window_end'.
		do
			window_end := a_window_end
		ensure
			window_end_set: window_end = a_window_end
		end

	set_is_guaranteed_morning (a_is_guaranteed_morning: attached like is_guaranteed_morning)
			-- Sets `is_guaranteed_morning' with `a_is_guaranteed_morning'.
		do
			is_guaranteed_morning := a_is_guaranteed_morning
		ensure
			is_guaranteed_morning_set: is_guaranteed_morning = a_is_guaranteed_morning
		end

	set_is_consignee_responsible (a_is_consignee_responsible: attached like is_consignee_responsible)
			-- Sets `is_consignee_responsible' with `a_is_consignee_responsible'.
		do
			is_consignee_responsible := a_is_consignee_responsible
		ensure
			is_consignee_responsible_set: is_consignee_responsible = a_is_consignee_responsible
		end

end
