note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	LG_CONTAINER_TEST_SET

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

	container_tests
			-- `container_tests'
		local
			l_container: LG_CONTAINER
		do
			create l_container.make ("CSQ", 'U', "305438")
			l_container.set_is_high_cube (True)
			assert_characters_equal ("check_digit_3", '3', l_container.check_digit)
			create l_container.make ("TOL", 'U', "473478")
			l_container.set_is_high_cube (True)
			assert_characters_equal ("check_digit_7", '7', l_container.check_digit)
		end

end


