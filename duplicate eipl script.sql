Declare
	v_old_eipl_pkid				Text;
	v_new_eipl_pkid				Text;
	v_new_event_pkid			Text;
Begin

	v_new_event_pkid = p_new_event_pkid;
	v_old_eipl_pkid = p_old_eipl_pkid;

		-- duplicate eipls
		Insert Into eipl 
			(
				fkevents_, fkdiscounts, duedate, type_, balance_, grandtotal_, subtotal_, discount_, lidiscountsum_, tax_, totalpaid_, discounttype_, discountperc_, discountamount_, shippingmethod_, taxtotal_, discounttotal_
			)
			Select
				v_new_event_pkid, fkdiscounts, duedate, type_, balance_, grandtotal_, subtotal_, discount_, lidiscountsum_, tax_, totalpaid_, discounttype_, discountperc_, discountamount_, shippingmethod_, taxtotal_, discounttotal_
			From eipl 
			Where pkid = v_old_eipl_pkid
			Returning pkid Into v_new_eipl_pkid;

		-- duplicate contact venue data stuff grabbing contact venue information from the new event
		Insert Into contact_venue_data
			(
				fkcontacts, fkvenues, fkevents_, fkeipl, primary_
			)
			Select 
				fkcontacts, fkvenues, '', v_new_eipl_pkid, primary_
			From contact_venue_data
			Where fkevents_ = v_new_event_pkid
			And primary_ = True;

		-- duplicate discounts
		Insert Into discounts_
			(
				fkeipl, department_, type_, amount_, grandtotal_, subtotal_, discountperc_, discountamount_
			)
			Select 
				v_new_eipl_pkid, department_, type_, amount_, grandtotal_, subtotal_, discountperc_, discountamount_
			From discounts_
			Where fkeipl = v_old_eipl_pkid;

		-- duplicate lineitems
		Insert Into lineitems
			(
				name_, manufacturer, model, department, category, subcategory, description, price, quantity_, fkeipl, fkinventory, type_, note_, rate_, discounttype_, total_, time_, discount_, discountperc_, discountamount_, taxable_, taxtotal_, quantity, ignore_price_discrepency
			)
			Select 
				name_, manufacturer, model, department, category, subcategory, description, price, quantity_, v_new_eipl_pkid, fkinventory, type_, note_, rate_, discounttype_, total_, time_, discount_, discountperc_, discountamount_, taxable_, taxtotal_, quantity, ignore_price_discrepency
			From lineitems
			Where fkeipl = v_old_eipl_pkid;

Return 'well';

End;