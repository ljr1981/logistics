note
	description: "[
		Abstract notion of a Shipping Container.
		]"

class
	LG_CONTAINER

create
	make

feature {NONE} -- Initialization

	make (a_owner_code: STRING; a_equipment_category_id: CHARACTER; a_serial_number: STRING)
			--
		do
			owner_code := a_owner_code
			equipment_category_id := a_equipment_category_id
			serial_number := a_serial_number
		end

feature -- Identification System

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
			Result := "000000"
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

	code_me_out_next
		note
			EIS: "src=https://en.wikipedia.org/wiki/ISO_6346#Size_and_Type_Codes"
		do

		end

	common_iso_type_group: HASH_TABLE [STRING, STRING]
			-- Item=Description, Key=Code
		do
			create Result.make (20)
			Result.force ("General Purpose Container", "20GP")
--ISO Type Group	ISO Size Type
--Code	Description	Code	Description
--20GP	GENERAL PURPOSE CONT.	20G0	GENERAL PURPOSE CONT.
--20G1	GENERAL PURPOSE CONT.
--20HR	ISOLADO CONTAINE REEFER	20H0	INSULATED CONTAINER
--20PF	FLAT (FIXED ENDS)	20P1	FLAT (FIXED ENDS)
--20TD	TANK CONTAINER	20T3	TANK CONTAINER
--20T4	TANK CONTAINER
--20T5	TANK CONTAINER
--20T6	TANK CONTAINER
--20TG	TANK CONTAINER	20T7	TANK CONTAINER
--20T8	TANK CONTAINER
--20TN	TANK CONTAINER	20T0	TANK CONTAINER
--20T1	TANK CONTAINER
--20T2	TANK CONTAINER
--22BU	BULK CONTAINER	22B0	BULK CONTAINER
--22GP	GENERAL PURPOSE CONT.	22G0	GENERAL PURPOSE CONT.
--22G1	GENERAL PURPOSE CONT.
--22HR	INSULATED CONTAINER	22H0	INSULATED CONTAINER
--22PC	FLAT (COLLAPSIBLE)	22P3	FLAT (COLLAPSIBLE)
--22P8	FLAT (COLL.FLUSH FOLDING)
--22P9	FLAT (COLLAPSIBLE)
--22PF	FLAT (FIXED ENDS)	22P1	FLAT (FIXED ENDS)
--22P7	FLAT (GENSET CARRIER)
--22RC	REEFER CONT.(NO FOOD)	22R9	REEFER CONT.(NO FOOD)
--22RS	BUILT-IN GEN. F. POWER SPLY OF REEF	22R7	BUILT-IN GEN. F. POWER SPLY OF REEF
--22RT	REEFER CONTAINER	22R1	REEFER CONTAINER
--22SN	NAMED CARGO CONTAINER	22S1	NAMED CARGO CONTAINER
--22TD	TANK CONTAINER	22T3	TANK CONTAINER
--22T4	TANK CONTAINER
--22T5	TANK CONTAINER
--22T6	TANK CONTAINER
--22TG	TANK CONTAINER	22T7	TANK CONTAINER
--22T8	TANK CONTAINER
--22TN	TANK CONTAINER	22T0	TANK CONTAINER
--22T1	TANK CONTAINER
--22T2	TANK CONTAINER
--22UP	HARDTOP CONTAINER	22U6	HARDTOP CONTAINER
--22UT	OPEN TOP CONTAINER	22U1	OPEN TOP CONTAINER
--22VH	VENTILATED CONTAINER	22V0	VENTILATED CONTAINER
--22V2	VENTILATED CONTAINER
--22V3	VENTILATED CONTAINER
--25GP	GP-CONTAINER OVER-HEIGHT	25G0	GP-CONTAINER OVER-HEIGHT
--26GP	GP-CONTAINER OVER-HEIGHT	26G0	GP-CONTAINER OVER-HEIGHT
--26HR	INSULATED CONTAINER	26H0	INSULATED CONTAINER
--28TG	TANK FOR GAS	28T8	TANK FOR GAS
--28UT	OPEN TOP (HALF HEIGHT)	28U1	OPEN TOP (HALF HEIGHT)
--28VH	VE-HALF-HEIGHT =1448 MM HEIGHT	28V0	VE-HALF-HEIGHT =1448 MM HEIGHT
--29PL	PLATFORM	29P0	PLATFORM
--2EGP	GEN. PURP. WITHOUT VENT WIDTH 2.5M	2EG0	HIGH CUBE CONT. (WIDTH 2.5M)
--42GP	GENERAL PURPOSE CONT.	42G0	GENERAL PURPOSE CONT.
--42G1	GENERAL PURPOSE CONT.
--42HR	INSULATED CONTAINER	42H0	INSULATED CONTAINER
--42PC	FLAT (COLLAPSIBLE)	42P3	FLAT (COLLAPSIBLE)
--42P8	FLAT (COLL.FLUSH FOLDING)
--42P9	FLAT (COLLAPSIBLE)
--42PF	FLAT (FIXED ENDS)	42P1	FLAT (FIXED ENDS)
--42PS	FLAT (SPACE SAVER)	42P6	FLAT SPACE SAVER
--42RC	REEFER CONT.(NO FOOD)	42R9	REEFER CONT.(NO FOOD)
--42RS	REEFER CONT.(DIESEL GEN.)	42R3	REEFER CONT.(DIESEL GEN.)
--42RT	REEFER CONTAINER	42R1	REEFER CONTAINER
--42SN	NAMED CARGO CONTAINER	42S1	NAMED CARGO CONTAINER
--42TD	TANK CONTAINER	42T5	TANK CONTAINER
--42T6	TANK CONTAINER
--42TG	TANK CONTAINER	42T8	TANK CONTAINER
--42TN	TANK CONTAINER	42T2	TANK CONTAINER
--42UP	HARDTOP CONTAINER	42U6	HARDTOP CONTAINER
--42UT	OPEN TOP CONTAINER	42U1	OPEN TOP CONTAINER
--45BK	BULK CONTAINER	45B3	BULK CONTAINER
--45GP	HIGH CUBE CONT.	45G0	HIGH CUBE CONT.
--45G1	HIGH CUBE CONT.
--45PC	FLAT (COLLAPSIBLE)	45P3	FLAT (COLLAPSIBLE)
--45P8	FLAT (COLL.FLUSH FOLDING)
--45RC	REEFER CONT.(NO FOOD)	45R9	REEFER CONT.(NO FOOD)
--45RT	REEFER HIGHCUBE CONTAINER	45R1	REEFER HIGHCUBE CONTAINER
--45UT	OPEN TOP CONTAINER	45U1	OPEN TOP CONTAINER
--45UP	HIGH CUBE HARDTOP CONT.	45U6	HIGH CUBE HARDTOP CONT.
--46HR	INSULATED CONTAINER	46H0	INSULATED CONTAINER
--48TG	TANK FOR GAS	48T8	TANK FOR GAS
--49PL	PLATFORM	49P0	PLATFORM
--4CGP	GP CONTAINER	4CG0	GP CONTAINER (WIDTH 2.5 M)
--L0GP	HIGH CUBE CONT.	L0G1	HIGH CUBE CONT.
--L2GP	HIGH CUBE CONT.	L2G1	HIGH CUBE CONT.
--L5GP	HIGH CUBE CONT.	L5G1	HIGH CUBE CONT.
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

feature -- Settings

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

invariant
	owner_code_valid: (owner_code.count = 3) and then across owner_code as ic all ("ABCDEFGHIJKLMNOPQRSTUVWXYZ").has (ic.item) end
	equipment_category_valid: across ("UJZ") as ic some equipment_category_id = ic.item end
	serial_number_valid: serial_number.is_integer and then serial_number.to_integer >= 0 and serial_number.to_integer <= 999999

;note
	types: "[

		]"

end
