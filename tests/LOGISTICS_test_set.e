note
	description: "Tests of {LOGISTICS}."
	testing: "type/manual"

class
	LOGISTICS_TEST_SET

inherit
	EQA_TEST_SET
		rename
			assert as assert_old
		end

	EQA_COMMONLY_USED_ASSERTIONS
		undefine
			default_create
		end

	TEST_SET_BRIDGE
		undefine
			default_create
		end

feature -- Test routines

	LOGISTICS_tests
			-- `LOGISTICS_tests'
		local
			l_bol: LG_BOL
			l_cod: LG_COD
			l_item: LG_BOL_ITEM

			l_business: BU_BUSINESS
			l_address: BU_ADDRESS
			l_type: BU_TYPE
		do
			create l_bol
			create l_item.make (100, "some_description")
			assert_integers_equal ("100", 100, l_item.number_of_units)

			create l_type.make ("blah", "blah")
			create l_address.make (l_type)
			create l_business.make ("XYZ Corp", <<l_address>>, <<>>)
			create l_cod.make (create {DECIMAL}.make_from_string ("100.00"), l_business, l_address)
		end

end
