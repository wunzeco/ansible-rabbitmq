require 'spec_helper'

describe package('rabbitmq-server') do
  it { should be_installed }
end

if os[:family] == 'ubuntu'
  describe package('erlang-nox') do
    it { should be_installed }
  end
end

if os[:family] == 'redhat'
  describe package('erlang') do
    it { should be_installed }
  end
end

%w( 
  /etc/rabbitmq
  /etc/rabbitmq/ssl
).each do |d|
  describe file(d) do
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_mode 755 }
  end
end

%w( 
  /etc/default/rabbitmq-server
  /etc/rabbitmq/rabbitmq.config
  /etc/rabbitmq/rabbitmq-env.conf
  /etc/rabbitmq/rabbitmqadmin.conf
  /etc/logrotate.d/rabbitmq-server
  /etc/security/limits.d/rabbitmq-server.conf
).each do |f|
  describe file(f) do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_mode 644 }
  end
end

describe service('rabbitmq-server') do
  it { should be_running }
end

describe command('rabbitmq-plugins list -e | grep "]" | awk "{print $2}"') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match %r/rabbitmq_management/ }
  its(:stdout) { should_not match %r/cowboy/ }
end

describe command('rabbitmqctl list_vhosts | awk "{print $1}"') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match %r/one/ }
  its(:stdout) { should_not match %r/cat/ }
end

describe command('rabbitmqctl list_users | awk "{print $1}"') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match %r/ogonna/ }
  its(:stdout) { should match %r/adminuser/ }
  its(:stdout) { should_not match %r/john/ }
end

describe command('rabbitmqctl list_user_permissions ogonna | awk "{print $1}"') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match %r/\.\*\s+\.\*\s+\.\*/ }
end
