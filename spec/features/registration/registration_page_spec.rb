require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'when I visit the registration form' do
    it 'I see fields for email, password, password confirmation, and a register button' do
      
    end

    describe 'when I click the register button' do 
      before :each do   
      end 
      it 'with completed fields and unique email, I am logged in and redirected to my dashboard' do 

      end

      it 'with one or more incomplete fields, I see an error message on the registration form' do
        
      end

      it 'if I try registering with an existing email, I see an error message and stay on the form' do
        
      end

      it 'if my passwords do not match, I receive a see an error message and stay on the form' do
        
      end
    end
  end
end