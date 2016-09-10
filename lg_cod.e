class
	LG_COD

create
	make

feature {NONE} -- Initialization

	make (a_amount: DECIMAL; a_paid_by: BU_BUSINESS; a_remit_to: BU_ADDRESS)
			--
		do
			total_amount := a_amount
			paid_by := a_paid_by
			remit_to := a_remit_to
		end

feature -- Access

	total_amount: DECIMAL

	certified_check: BOOLEAN

	company_check: BOOLEAN

	paid_by: BU_BUSINESS

	remit_to: BU_ADDRESS

feature -- Settings

	set_total_amount (a_total_amount: attached like total_amount)
			-- Sets `total_amount' with `a_total_amount'.
		do
			total_amount := a_total_amount
		ensure
			total_amount_set: total_amount = a_total_amount
		end

	set_certified_check (a_certified_check: attached like certified_check)
			-- Sets `certified_check' with `a_certified_check'.
		do
			certified_check := a_certified_check
		ensure
			certified_check_set: certified_check = a_certified_check
		end

	set_company_check (a_company_check: attached like company_check)
			-- Sets `company_check' with `a_company_check'.
		do
			company_check := a_company_check
		ensure
			company_check_set: company_check = a_company_check
		end

	set_paid_by (a_paid_by: attached like paid_by)
			-- Sets `paid_by' with `a_paid_by'.
		do
			paid_by := a_paid_by
		ensure
			paid_by_set: paid_by = a_paid_by
		end

	set_remit_to (a_remit_to: attached like remit_to)
			-- Sets `remit_to' with `a_remit_to'.
		do
			remit_to := a_remit_to
		ensure
			remit_to_set: remit_to = a_remit_to
		end
		
end
