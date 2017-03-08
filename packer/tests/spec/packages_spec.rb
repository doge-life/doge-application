require 'spec_helper'

describe command('java -version') do
  its(:stderr) { should include 'openjdk version "1.8' }
end

describe command('ps -ef | grep doge-webapp.jar') do
  its(:stdout) { should include '/var/doge-webapp/doge-webapp.jar' }
end
