require 'spec_helper'

describe AbilityRole do
  it { should belong_to(:role) }
  it { should belong_to(:ability) }
end
