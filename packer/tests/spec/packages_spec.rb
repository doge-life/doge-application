require 'spec_helper'

describe command('java -version') do
    its(:stderr){ should include 'openjdk version "1.8' }
end
