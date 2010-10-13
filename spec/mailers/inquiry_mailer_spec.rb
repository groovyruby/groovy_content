require "spec_helper"

describe InquiryMailer do
  describe "inquiry_received" do
    let(:mail) { InquiryMailer.inquiry_received }

    it "renders the headers" do
      mail.subject.should eq("Inquiry received")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
