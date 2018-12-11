#
# Cookbook:: base
# Spec:: default
#
# Copyright:: 2018,  Larry Charbonneau
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'spec_helper'

describe 'lc4_base::default' do
  context 'When all attributes are default, on CentOS 7.5.1804' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.5.1804')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates my user account' do
      expect(chef_run).to create_user('larry').with(uid: '1337')
    end

    it 'creates authorized keys' do
      expect(chef_run).to create_template('/home/larry/.ssh/authorized_keys').with(user: 'larry', group: 'larry', mode: '0700')
    end

    it 'configures sshd' do
      expect(chef_run).to create_template('/etc/ssh/sshd_config').with(user: 'root', mode: '0644')
    end

    it 'adds me to the wheel group' do
      expect(chef_run).to modify_group('wheel').with(members: ['larry'])
    end

    

  end
end
