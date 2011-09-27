require File.dirname(__FILE__) + '/../spec_helper'

describe Survey do
  it { should validate_presence_of :title }
  it { should validate_presence_of :author }
  it { should have_many :questions }
  it { should have_many(:answers).through :questions }
end
