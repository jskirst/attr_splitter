require 'spec_helper'

class User < SuperModel::Base
  include ActiveModel::MassAssignmentSecurity
  extend AttrSplitter::ModelAdditions
  
  attr_splitter :phone_number, prefixes: [:first, :second, :third]
  attr_splitter :home_phone, suffixes: [:area_code, :first_three, :last_four]
end

describe AttrSplitter::ModelAdditions do
  it "combines prefixed attributes on save" do
    u = User.create!(first_phone_number: "415", second_phone_number: "555", third_phone_number: "9999")
    u.phone_number.should eq("4155559999")
  end
  
  it "combines suffixed attributes on save" do
    u = User.new
    u = User.create!(home_phone_area_code: "415", home_phone_first_three: "555", home_phone_last_four: "9999")
    u.home_phone.should eq("4155559999")
  end
end

# describe AttrSplitter::FormBuilderAdditions do
#   include AttrSplitterSpecHelper
#   
#   before :each do
#     @output_buffer = ''
#   end
#   
#   it "outputs something" do
#     concat(form_for(User.new, url: "/test") do |f|
#       concat(f.multi_text_field(:phone_number, fields: ["first", "second", "third"]))
#     end)
#   end
# end
  