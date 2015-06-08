FactoryGirl.define do

  factory :receipt do
    location
		amount 					15
		purchased_on 		{ 2.days.ago }
		image_filename 	"receipt.jpg"
		status					Receipt::UNTOUCHED


		factory :receipt_approved do
			actioned_on 	{ Date.today }
			status Receipt::APPROVED
		end


		factory :receipt_rejected do
			actioned_on 	{ Date.today }
			status Receipt::REJECTED
			reject_reason "You are so mean"
		end


		factory :receipt_with_location do
			before(:build) do |receipt|
				receipt.location = create(:location)
			end
		end


		factory :invalid_receipt do
			amount 					nil
			location 				nil
			purchased_on 		nil
			image_filename 	nil
		end
  end

end