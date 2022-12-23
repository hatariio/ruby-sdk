require 'spec_helper'
require 'hatari_ruby_sdk/hatari'

describe HatariRubySdk do 

    it 'No exception raised' do 
        HatariRubySdk::HatariClient.new('38834340030344384843', '17274923928323737238')
    end
end