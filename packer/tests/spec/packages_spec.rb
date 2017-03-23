require 'spec_helper'

describe command('java -version') do
  its(:stderr) { should include 'openjdk version "1.8' }
end

describe file('/var/doge-webapp/doge-webapp.jar') do
  it { should exist }
  it { should be_executable }
end

describe file('/etc/init.d/doge-webapp') do
  it { should be_symlink }
  it { should be_linked_to '/var/doge-webapp/doge-webapp.jar' }
end

describe service('doge-webapp') do
  it { should be_enabled }
end

describe iptables do
    it { should have_rule('-A PREROUTING -p tcp -m tcp --dport 80 -j REDIRECT --to-ports 8080').with_table('nat') }
end
