require 'spec_helper'

describe command('java -version') do
    its(:stderr){ should include 'java version "1.8' }
end
