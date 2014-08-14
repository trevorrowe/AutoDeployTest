require 'spec_helper'

describe AutoDeployTest do

  it 'has an X.Y.Z version' do
    expect(AutoDeployTest::VERSION).to match(/^\d+\.\d+\.\d+$/)
  end

  it 'returns true from #testable_method' do
    expect(AutoDeployTest.new.testable_method).to be(true)
  end

end
