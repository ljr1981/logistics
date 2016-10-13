note
	description: "[
		Abstract notion of a Shipping Container.
		]"

class
	LG_CONTAINER

create
	make,
	make_with_id

feature {NONE} -- Initialization

	make_with_id (a_container_id: STRING)
			-- ISO 6346 conforming container number (if possible).
			-- AAA A 999999 9
			-- Owner Code, Equipment Code, Serial Number, Check digit
		note
			design: "[
				There exists the possibility that `a_container_id' will not conform
				to ISO 6346. Therefore, we attempt to conform within limits, setting
				the overall `container_id' to the incoming (passed argument) ID.
				However, for non-ISO-conforming ID's, we work left-to-right, parsing
				the incoming ID as far as we can along the vector of owner, equipment,
				and serial number fields.
				]"
		do
			set_container_id (a_container_id)
			if not a_container_id.is_empty then
				if a_container_id.count >= 3 then
					owner_code := a_container_id.substring (1, 3)
				else
					owner_code := a_container_id.substring (1, a_container_id.count)
				end
				if a_container_id.count >= 4 then
					equipment_category_id := a_container_id [4]
				else
					do_nothing
				end
				if a_container_id.count >= 10 then
					serial_number := a_container_id.substring (5, 10)
				elseif a_container_id.count >= 5 then
					serial_number := a_container_id.substring (5, a_container_id.count)
				else
					do_nothing
				end
			end
		end

	make (a_owner_code: STRING; a_equipment_category_id: CHARACTER; a_serial_number: STRING)
			-- Presumes an ISO 6346 conforming `a_owner_code', `a_equipment_category_id' and `a_serial_number'
			-- The checksum value is computed and not passed
		do
			owner_code := a_owner_code
			equipment_category_id := a_equipment_category_id
			serial_number := a_serial_number
			container_id.do_nothing
		ensure
			ISO: is_iso_6346_compliant
			valid: is_valid_container_id (container_id)
		end

feature -- Identification System

	container_id: STRING
			-- `container_id' (settable or computed from `owner_code' etc.)
		attribute
			Result := owner_code.twin
			Result.append_character (equipment_category_id)
			Result.append_string_general (serial_number)
			Result.append_character (check_digit)
		end

	owner_code: STRING
		note
			EIS: "src=https://en.wikipedia.org/wiki/ISO_6346#Owner_Code"
		attribute
			create Result.make_empty
		end

	equipment_category_id: CHARACTER
		note
			EIS: "src=https://en.wikipedia.org/wiki/ISO_6346#Equipment_Category_Identifier"
		attribute
			Result := 'U'
		end

	serial_number: STRING
		note
			EIS: "src=https://en.wikipedia.org/wiki/ISO_6346#Serial_Number"
		attribute
			create Result.make_empty
		end

	check_digit: CHARACTER
		note
			EIS: "src=https://en.wikipedia.org/wiki/ISO_6346#Check_Digit"
			EIS: "src=https://en.wikipedia.org/wiki/ISO_6346#Conversion_Algorithm"
			EIS: "src=https://en.wikipedia.org/wiki/ISO_6346#Calculation_Step_1"
			EIS: "src=https://en.wikipedia.org/wiki/ISO_6346#Calculation_Step_2"
			EIS: "src=https://en.wikipedia.org/wiki/ISO_6346#Calculation_Step_3"
		local
			l_d1, l_d2, l_d3, l_d4, l_d5, l_d6, l_d7, l_d8, l_d9, l_d10,
			l_sum1,
			l_sum2: INTEGER
			l_div_by_11: REAL_64
		do
			l_d1 := conversion_hash.at (owner_code [1]) * 1
			l_d2 := conversion_hash.at (owner_code [2]) * 2
			l_d3 := conversion_hash.at (owner_code [3]) * 4
			l_d4 := conversion_hash.at (equipment_category_id) * 8
			l_d5 := serial_number [1].out.to_integer * 16
			l_d6 := serial_number [2].out.to_integer * 32
			l_d7 := serial_number [3].out.to_integer * 64
			l_d8 := serial_number [4].out.to_integer * 128
			l_d9 := serial_number [5].out.to_integer * 256
			l_d10 := serial_number [6].out.to_integer * 512
			l_sum1 := l_d1 + l_d2 + l_d3 + l_d4 + l_d5 + l_d6 + l_d7 + l_d8 + l_d9 + l_d10
			l_div_by_11 := l_sum1 / 11
			l_sum2 := l_div_by_11.truncated_to_integer
			Result := (l_sum1 - (l_sum2 * 11)).out [1]
		end

	conversion_hash: HASH_TABLE [INTEGER, CHARACTER]
		once
			create Result.make (26)
			Result.force (10, 'A')
			Result.force (12, 'B')
			Result.force (13, 'C')
			Result.force (14, 'D')
			Result.force (15, 'E')
			Result.force (16, 'F')
			Result.force (17, 'G')
			Result.force (18, 'H')
			Result.force (19, 'I')
			Result.force (30, 'J')
			Result.force (21, 'K')
			Result.force (23, 'L')
			Result.force (24, 'M')
			Result.force (25, 'N')
			Result.force (26, 'O')
			Result.force (27, 'P')
			Result.force (28, 'Q')
			Result.force (29, 'R')
			Result.force (30, 'S')
			Result.force (31, 'T')
			Result.force (32, 'U')
			Result.force (34, 'V')
			Result.force (35, 'W')
			Result.force (36, 'X')
			Result.force (37, 'Y')
			Result.force (38, 'Z')
		ensure
			has_26: Result.count = 26
		end

	position_hash: HASH_TABLE [STRING, STRING]
			-- Each of the numbers calculated in step 1 is multiplied by 2^position,
			--	where position is the exponent to base 2. Position starts at 0,
			--	from left to right.
		once
			create Result.make (26)
			-- 1. nbr	2. nbr	3. nbr	4. nbr	5. nbr	6. nbr	7. nbr	8. nbr	9. nbr	10. nbr
			-- 20		21		22		23		24		25		26		27		28		29
			-- 1		2		4		8		16		32		64		128		256		512
		end

feature -- Size & Type

	length_codes: HASH_TABLE [STRING, STRING]
		note
			EIS: "src=https://en.wikipedia.org/wiki/ISO_6346#Size_and_Type_Codes"
		once
			create Result.make (11)
			Result.force ("10'",	"1")
			Result.force ("20'",	"2")
			Result.force ("30'",	"3")
			Result.force ("40'",	"4")
			Result.force ("24'",	"B")
			Result.force ("24'6%"",	"C")
			Result.force ("41'",	"G")
			Result.force ("43'",	"H")
			Result.force ("45'",	"L")
			Result.force ("48'",	"M")
			Result.force ("49'",	"N")
		end

feature -- Dimensions

	height: DECIMAL
		do
			if is_high_cube and is_metric then
				create Result.make_from_string ("2.9")
			elseif is_high_cube and not is_metric then
				create Result.make_from_string ("9.5")
			elseif not is_high_cube and is_metric then
				create Result.make_from_string ("2.6")
			else
				create Result.make_from_string ("8.5")
			end
		end

feature -- Queries

	is_metric: BOOLEAN

	is_high_cube: BOOLEAN

	is_general_purpose: BOOLEAN
	is_dry_freight: BOOLEAN do Result := is_general_purpose end

	is_valid_container_id (a_id: STRING): BOOLEAN
			--
		do
			Result := a_id.count = 11
			Result := Result and then
						(not (a_id.substring (1, 3)).is_number_sequence) and then
						across a_id.substring (1, 3) as ic all alpha.has (ic.item) end
			Result := Result and then
						across a_id.substring (4, 4) as ic all category_ids.has (ic.item) end
			Result := Result and then
						a_id.substring (5, 11).is_number_sequence
		end

	is_iso_6346_compliant: BOOLEAN
			-- Is the `container_id' ISO 6346 compliant?
		do
			Result := is_valid_container_id (container_id)
		end

feature -- Settings

	set_container_id (a_id: like container_id)
			-- `set_container_id' with `a_id' like `container_id'.
		do
			container_id := a_id
		ensure
			set: container_id.same_string (a_id)
		end

	set_is_metric (a_is_metric: like is_metric)
			-- Sets `is_metric' with `a_is_metric'.
		do
			is_metric := a_is_metric
		ensure
			is_metric_set: is_metric = a_is_metric
		end

	set_is_high_cube (a_is_high_cube: like is_high_cube)
			-- Sets `is_high_cube' with `a_is_high_cube'.
		do
			is_high_cube := a_is_high_cube
		ensure
			is_high_cube_set: is_high_cube = a_is_high_cube
		end

	set_is_general_purpose (a_is_general_purpose: like is_general_purpose)
			-- Sets `is_general_purpose' with `a_is_general_purpose'.
		do
			is_general_purpose := a_is_general_purpose
		ensure
			is_general_purpose_set: is_general_purpose = a_is_general_purpose
		end
feature {NONE} -- Implementation: Constants

	alpha: STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

	category_ids: STRING = "UJZ"

invariant
	owner_code_valid: is_iso_6346_compliant implies
						(owner_code.count = 3) and then across owner_code as ic all alpha.has (ic.item) end
	equipment_category_valid: is_iso_6346_compliant implies
						across category_ids as ic some equipment_category_id = ic.item end
	serial_number_valid: is_iso_6346_compliant implies
						serial_number.is_integer and then serial_number.to_integer >= 0 and serial_number.to_integer <= 999999

;note
	types: "[

		]"

end
