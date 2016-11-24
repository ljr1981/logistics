note
	description: "Constants"

class
	LG

feature -- Constants

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

	alpha: STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

	category_ids: STRING = "UJZ"

end
