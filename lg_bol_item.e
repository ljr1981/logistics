class
	LG_BOL_ITEM

create
	make

feature {NONE} -- Initialization

	make (a_count: like number_of_units; a_description: like description)
			--
		do
			number_of_units := a_count
			description := a_description
		end

feature -- Access

	bulk: detachable STRING

	number_of_units: INTEGER

	package_type: detachable BU_TYPE

	is_hazardous_material: BOOLEAN

	description: STRING

	NMFC_item_number: detachable STRING
			-- In the United States, each commodity or type of product is
			--	assigned a National Motor Freight Classification (NMFC) and
			--	corresponding class for less than truckload (LTL) freight
			--	shipments. The (NMFC) system is a standardized method
			--	designed to give consumers a uniform pricing structure
			--	when transporting freight.

	sub_of: detachable STRING

	class_of: detachable STRING

	weight_in_pounds: INTEGER

	declared_value: detachable DECIMAL

	declared_value_per_uom: detachable BU_UOM

feature -- Settings

	set_bulk (a_bulk: attached like bulk)
			-- Sets `bulk' with `a_bulk'.
		do
			bulk := a_bulk
		ensure
			bulk_set: bulk = a_bulk
		end

	set_number_of_units (a_number_of_units: attached like number_of_units)
			-- Sets `number_of_units' with `a_number_of_units'.
		do
			number_of_units := a_number_of_units
		ensure
			number_of_units_set: number_of_units = a_number_of_units
		end

	set_package_type (a_package_type: attached like package_type)
			-- Sets `package_type' with `a_package_type'.
		do
			package_type := a_package_type
		ensure
			package_type_set: package_type = a_package_type
		end

	set_is_hazardous_material (a_is_hazardous_material: attached like is_hazardous_material)
			-- Sets `is_hazardous_material' with `a_is_hazardous_material'.
		do
			is_hazardous_material := a_is_hazardous_material
		ensure
			is_hazardous_material_set: is_hazardous_material = a_is_hazardous_material
		end

	set_description (a_description: attached like description)
			-- Sets `description' with `a_description'.
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

	set_NMFC_item_number (a_NMFC_item_number: attached like NMFC_item_number)
			-- Sets `NMFC_item_number' with `a_NMFC_item_number'.
		do
			NMFC_item_number := a_NMFC_item_number
		ensure
			NMFC_item_number_set: NMFC_item_number = a_NMFC_item_number
		end

	set_sub_of (a_sub_of: attached like sub_of)
			-- Sets `sub_of' with `a_sub_of'.
		do
			sub_of := a_sub_of
		ensure
			sub_of_set: sub_of = a_sub_of
		end

	set_class_of (a_class_of: attached like class_of)
			-- Sets `class_of' with `a_class_of'.
		do
			class_of := a_class_of
		ensure
			class_of_set: class_of = a_class_of
		end

	set_weight_in_pounds (a_weight_in_pounds: attached like weight_in_pounds)
			-- Sets `weight_in_pounds' with `a_weight_in_pounds'.
		do
			weight_in_pounds := a_weight_in_pounds
		ensure
			weight_in_pounds_set: weight_in_pounds = a_weight_in_pounds
		end

	set_declared_value (a_declared_value: attached like declared_value)
			-- Sets `declared_value' with `a_declared_value'.
		do
			declared_value := a_declared_value
		ensure
			declared_value_set: declared_value = a_declared_value
		end

	set_declared_value_per_uom (a_declared_value_per_uom: attached like declared_value_per_uom)
			-- Sets `declared_value_per_uom' with `a_declared_value_per_uom'.
		do
			declared_value_per_uom := a_declared_value_per_uom
		ensure
			declared_value_per_uom_set: declared_value_per_uom = a_declared_value_per_uom
		end

end
