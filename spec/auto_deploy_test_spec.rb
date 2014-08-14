require 'spec_helper'

describe AutoDeployTest do

  it 'has an X.Y.Z version' do
    expect(AutoDeployTest::VERSION).to match(/^\d+\.\d+\.\d+$/)
  end

end
