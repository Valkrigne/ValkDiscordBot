require 'spec_helper'

describe Kiranico do
  describe 'regex' do
    it 'should match the test string' do
      expect(Kiranico::REGEX).to match "test!mh test"
      expect(Kiranico::REGEX).to_not match "test!mh"
    end
  end
end
